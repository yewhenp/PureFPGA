import re
import bitstring
from assembler.src.lists_and_dicts import *


class Assembler:
    NOP = "addnv reg0 reg0"

    def __init__(self, source_file: str = None, prep_file: str = None, dest_file: str = None):
        self.source_file = source_file
        self.prep_file = prep_file
        self.dest_file = dest_file

    # There are two mods - ascii and binary
    def assemble_preprocessed(self, verbose: bool = False, mode="ascii"):
        if mode == "ascii":
            with open(self.dest_file, "w") as dest_file:
                result = ""
                for line_n, line in enumerate(open(self.prep_file, "r")):
                    line = line.strip()
                    encoded = self.encode_command(line)

                    # long instruction
                    if len(encoded) == 32:
                        result += encoded[:16] + "\n" + encoded[16:] + "\n"
                    else:
                        result += encoded + "\n"
                    if verbose:
                        print(f"Processed line #{line_n}: {encoded}     ({line})")
                dest_file.write(result)
        elif mode == "bin":
            with open(self.dest_file, "wb") as dest_file:
                for line_n, line in enumerate(open(self.prep_file, "r")):
                    line = line.strip()
                    encoded = self.encode_command(line)
                    value = bitstring.BitArray(bin=encoded)
                    my_bytes = value.tobytes()

                    dest_file.write(my_bytes)
                    if verbose:
                        print(f"Processed line #{line_n}: {encoded}     ({line})")

    def preprocess_source(self, verbose: bool = False):
        with open(self.prep_file, "w") as prep_file:
            instr_counter = 0
            last_inst_was_16_bit = False

            labels = {}

            for line in open(self.source_file, "r"):
                # skip comments and empty lines
                if line.startswith("//") or line.strip() == "":
                    continue
                line = re.sub("//(.)*", "", line)  # delete comments at the same line
                line = line.strip()

                # label
                if re.match(r"\s*\w+\s*(:)\s*", line):
                    pass

                line = line.lower()
                line = line.split()

                if verbose:
                    print(f"Preprocessing {line}")


                # insert NOP in front of movl / movh if instruction's number is odd
                if line[0] in mem_only_num_command_unprocessed and instr_counter % 2 and last_inst_was_16_bit:
                    print(instr_counter, last_inst_was_16_bit)
                    prep_file.write(self.NOP + "\n")

                if line[0] in mem_only_num_command_unprocessed:
                    last_inst_was_16_bit = False
                else:
                    last_inst_was_16_bit = True

                # mov - mov0-1 store - store0-1 load - load0-1 conversion
                if line[0][:-2] in mem_suffix_commands_unprocessed and \
                        line[0][-2:] in suffixes:  # there is a suffix
                    if line[0][-2:] in suffixes_0:
                        line[0] = line[0][0:-2] + "0" + line[0][-2:]
                    elif line[0][-2:] in suffixes:
                        line[0] = line[0][0:-2] + "1" + line[0][-2:]
                    else:
                        raise ValueError(f"Bad suffix: {line[0][-2:]}")
                elif line[0] in mem_suffix_commands_unprocessed:  # no suffix
                    line[0] += "1"

                # add 'al' if needed
                if line[0] not in not_suffix_commands and line[0][-2:] not in suffixes:
                    line[0] += "al"

                if verbose:
                    print(f"Preprocess res: {line}")

                if line[0] == "nopal":
                    prep_file.write(self.NOP + "\n")
                else:
                    prep_file.write(" ".join(line) + "\n")

                # insert NOP if jump's ip is even number.
                if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                    print(instr_counter)
                    prep_file.write(self.NOP + "\n")

                instr_counter += 1

    @staticmethod
    def encode_command(parsed_command: str):
        result = ""
        command_list = parsed_command.split()

        # suffixes and clear command fromo it
        if command_list[0][-2:] in suffixes and command_list[0] not in not_suffix_commands:
            command_clear = command_list[0][:-2]
            suffix = command_list[0][-2:]
        else:
            command_clear = command_list[0]
            suffix = ""

        # two command typesopcode of
        if command_clear in commands['alu']:
            command_type = "alu"
        elif command_clear in commands['memory']:
            command_type = "memory"
        else:
            raise KeyError(f"Unknown command: {command_clear}")

        # first two bits of command
        result = result + "1" if command_clear in mem_only_num_command_unprocessed else result + "0"
        result = result + "1" if command_type == "alu" else result + "0"

        if command_type == "alu":
            result += commands["alu"][command_clear]           # 4 bits - opcode
            result += suffixes[suffix]                         # 4 bits - suffix
            result += registers[command_list[1]]               # 3 bits - dest reg
            if command_clear not in alu_one_dest_commands:     # if not inc/dec/not
                result += registers[command_list[2]]           # 3 bits - second operand
            else:
                result += "0" * 3                                   # unused bits

        elif command_type == "memory":
            result += commands["memory"][command_clear]        # 5 bits - opcode

            # load / store / mov
            if command_clear in mem_suffix_commands:
                result += suffixes[suffix][1:]                # 3 bits - suffix
                result += registers[command_list[1]]          # 3 bits - first reg
                result += registers[command_list[2]]          # 3 bits - second reg

            # movl/movh
            elif command_clear in mem_only_num_command_unprocessed:
                result += suffixes[suffix]                    # 4 bits - suffix
                result += registers[command_list[1]]          # 3 bits - register
                bin_num = bin(int(command_list[-1]))[2:]
                if len(bin_num) > 16:
                    raise ValueError(f"Can't move number to register: {command_list[-1]}")
                bin_num = "0" * (16 - len(bin_num)) + bin_num
                result += "0" * 2                                  # unused bits
                result += bin_num                                  # 16 bit number

            # jumps / movf
            elif command_clear in not_suffix_commands:
                result += registers[command_list[1]]          # 3 bits - first reg
                result += "0" * 6

            # coreidx
            elif command_clear in coreidx:
                result += suffixes[suffix]
                result += registers[command_list[1]]
                result += "0" * 2

            # int
            elif command_clear == "int":
                result += suffixes[suffix]                      # 4 bits suffix
                bin_num = bin(int(command_list[-1]))[2:]
                bin_num = "0" * (3 - len(bin_num)) + bin_num
                result += bin_num                               # 3 bits interrupt number
                result += "0" * 2
            else:
                print(f"Unknow command: {command_list}")
                raise ValueError

        return result
