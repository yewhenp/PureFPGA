import re
import bitstring
from assembler.src.lists_and_dicts import *
import math


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
                    encoded = self.__encode_command(line)

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
                    encoded = self.__encode_command(line)
                    value = bitstring.BitArray(bin=encoded)
                    my_bytes = value.tobytes()

                    dest_file.write(my_bytes)
                    if verbose:
                        print(f"Processed line #{line_n}: {encoded}     ({line})")

        elif mode == "quartus_bin":
            with open(self.dest_file, "w") as dest_file:
                dest_file.write("DEPTH = 16384;\n")
                dest_file.write("WIDTH = 32;\n")
                dest_file.write("ADDRESS_RADIX = BIN;\n")
                dest_file.write("DATA_RADIX = BIN;\n")
                dest_file.write("CONTENT\n")
                dest_file.write("BEGIN\n")

                temp = ""
                counter = 0
                for line_n, line in enumerate(open(self.prep_file, "r")):
                    line = line.strip()
                    encoded = self.__encode_command(line)

                    if len(encoded) == 32:
                        dest_file.write('{:015b}'.format(counter) + " : " + encoded + ";\n")
                        counter += 1
                    else:
                        if temp == "":
                            temp = encoded
                        else:
                            temp += encoded
                            dest_file.write('{:015b}'.format(counter) + " : " + temp + ";\n")
                            counter += 1
                            temp = ""
                dest_file.write("\nEND;\n")

    def preprocess_source(self, verbose: bool = False):
        with open(self.prep_file, "w") as prep_file:
            instr_counter = 0

            # find all labels
            labels = self.__find_labels(self.source_file, verbose)

            for line in open(self.source_file, "r"):
                line = line.strip()
                # skip comments and empty lines
                if line.startswith("//") or line == "":
                    continue
                line = re.sub("//(.)*", "", line)  # delete comments at the same line
                line = line.lower()

                # skip value labels
                if re.match(r"\s*\w+\s*(=)\s*\d+\s*", line):
                    continue

                # insert nop before jump label if it's instruction is not even
                if re.match(r"\s*\w+\s*(:)\s*", line):
                    if instr_counter % 2:
                        prep_file.write(self.NOP + "\n")
                        instr_counter += 1
                    continue

                line = line.split()

                if verbose:
                    print(f"Preprocessing {line}")

                # nop
                if line[0] == "nop":
                    prep_file.write(self.NOP + "\n")
                    instr_counter += 1
                    continue

                result = []

                # insert NOP before movl / movh if instruction's number is odd
                if line[0] in mem_only_num_command_unprocessed and instr_counter % 2:
                    result.append(self.NOP + "\n")
                    instr_counter += 1

                # ######################################## LABELS ###################################################
                # change CORE_NUM to 4 for movl/movh
                if line[0] in mem_only_num_command_unprocessed and line[2] == "core_num":
                    line[2] = CORE_NUM

                # mov regi label = movl regi label[16:] + movl regi label[:16]
                if line[0] == "mov" and line[2] not in registers:
                    if line[2] in labels:
                        result += self.__num_to_reg(line[1], labels[line[2]])
                        instr_counter += 2
                        for instr in result:
                            prep_file.write(instr)
                        continue
                    else:
                        raise ValueError(f"Unknown label: {line[2]}")

                # substitute label to load / store
                if line[0] in mem_suffix_commands_unprocessed and line[2] not in registers:
                    if line[2] in labels:
                        result += self.__num_to_reg(LABEL_REGISTER, labels[line[2]])
                        instr_counter += 2
                        line[2] = LABEL_REGISTER
                    else:
                        raise ValueError(f"Unknown label: {line[2]}")

                # substituting label to jump
                if line[0] in mem_jump_commmands and line[1] not in registers:
                    if line[1] in labels:
                        result += self.__num_to_reg(LABEL_REGISTER,
                                                    labels[line[1]])  # write label address to reg5
                        instr_counter += 2
                        line[1] = LABEL_REGISTER  # programmer has to save content of reg5 before jumping to label
                    else:
                        raise ValueError(f"Unknown label: {line[1]}")

                # movl/movh is basically two instructions
                if line[0] in mem_only_num_command_unprocessed:
                    instr_counter += 1

                # mov0/1; load0/1; store0/1; 'al'
                self.__coding_related_prep(line)

                result.append(" ".join(line) + "\n")
                instr_counter += 1

                # insert NOP after jump if jump's ip is even number.
                if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                    result.append(self.NOP + "\n")
                    instr_counter += 1

                if verbose:
                    print(f"Preprocess res: {result}, {instr_counter}")

                for instr in result:
                    prep_file.write(instr)

            if instr_counter % 2 == 0:
                prep_file.write(self.NOP + "\n")  # number of instructions should be even, else undefined behaviour
                instr_counter += 1
            if verbose:
                print(f"Number of instructions: {instr_counter}")

    @staticmethod
    def __encode_command(parsed_command: str):
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

    @staticmethod
    def __num_to_reg(reg, number):
        binary = bin(number)[2:]
        binary = "0" * (32 - len(binary)) + binary
        return [f"movlal {reg} {int(binary[16:], 2)}\n", f"movhal {reg} {int(binary[:16], 2)}\n"]

    @staticmethod
    def __find_labels(file, verbose):
        instr_counter = 0
        labels = {}

        label_names = set()
        # just find label names
        for line in open(file, "r"):
            if line.strip().startswith("//") or line.strip() == "":
                continue
            line = re.sub("//(.)*", "", line).strip().lower()
            if re.match(r"\s*\w+\s*(:)\s*", line):
                label_names.add(re.findall(r"[a-zA-Z_]+", line)[0])
                continue
            if re.match(r"\s*\w+\s*(=)\s*\d+\s*", line):
                label_names.add(re.findall(r"[a-zA-Z_]+", line)[0])
                continue

        # now find values of labels
        for line in open(file, "r"):
            if line.strip().startswith("//") or line.strip() == "":
                continue
            line = re.sub("//(.)*", "", line).strip().lower()

            # jump label preprocessing
            if re.match(r"\s*\w+\s*(:)\s*", line):
                # nop before label if odd number of instructions
                if instr_counter % 2:
                    instr_counter += 1
                name = re.findall(r"[a-zA-Z_]+", line)[0]
                labels[name] = math.ceil(instr_counter / 2)  # take only text part; /2 bacause there are 2 instructions in one memory cell
                # instr_counter += 1
                if verbose:
                    print(f"Found new jump label: " + name + "=" + str(labels[name]))
                continue

            # value label preprocessing
            if re.match(r"\s*\w+\s*(=)\s*\d+\s*", line):
                # take only text part and save number after '='
                name = re.findall(r"[a-zA-Z_]+", line)[0]
                labels[name] = int(re.findall(r"\d+", line)[0])
                if verbose:
                    print(f"Found new value label: " + name + "=" + str(labels[name]))
                continue

            line = line.split()

            # nop
            if line[0] == "nop":
                instr_counter += 1
                continue
            # insert NOP before movl / movh if instruction's number is odd
            if line[0] in mem_only_num_command_unprocessed and instr_counter % 2:
                instr_counter += 1
            # mov regi label = movl regi label[16:] + movl regi label[:16]
            if line[0] == "mov" and line[2] not in registers and line[2] in label_names:
                instr_counter += 1
            # substitute label to load / store
            if line[0] in mem_suffix_commands_unprocessed and line[2] not in registers and line[2] in label_names:
                instr_counter += 2
            # substituting label to jump
            if line[0] in mem_jump_commmands and line[1] not in registers and line[1] in label_names:
                instr_counter += 2
            # insert NOP if jump's ip is even number.
            if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                instr_counter += 1
            # movl/movh is basically two instructions
            if line[0] in mem_only_num_command_unprocessed:
                instr_counter += 1

            instr_counter += 1
        print(instr_counter)
        return labels

    @staticmethod
    def __coding_related_prep(line):
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
