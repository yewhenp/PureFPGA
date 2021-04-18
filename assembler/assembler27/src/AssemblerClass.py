import re
from .lists_and_dicts import *


class Assembler:
    NOP = "addnv reg0 reg0"
    RAM_SIZE = 65535

    def __init__(self, source_file=None, prep_file=None, dest_file=None):
        self.source_file = source_file
        self.prep_file = prep_file
        self.dest_file = dest_file

    # There are two mods - ascii and binary
    def assemble_preprocessed(self, verbose=False):
        with open(self.dest_file, "w") as dest_file:
            result = ""
            temp = ""
            counter = 0
            for line_n, line in enumerate(open(self.prep_file, "r")):
                line = line.strip()
                encoded = self.__encode_command(line)

                if len(encoded) == 32:
                    if verbose:
                        print "Processed line #" + str(counter) + ":" + str(encoded) + "   (" + str(line) + ")"
                    result += encoded + "\n"
                    counter += 1
                else:
                    if temp == "":
                        temp = encoded
                        line_before = line
                    else:
                        temp += encoded
                        if verbose:
                            print "Processed line #" + str(counter) + ":" + str(temp) + "   (" + str([line_before, line]) + ")"
                        result += temp + "\n"
                        counter += 1
                        temp = ""
            dest_file.write(result)

    def preprocess_source(self, verbose=False):
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
                    print "Preprocessing " + str(line)

                # nop
                if line[0] == "nop":
                    prep_file.write(self.NOP + "\n")
                    instr_counter += 1
                    continue

                if line[0] == "stack_size":
                    result, deltaInstr = self.__set_stacks_size(line)
                    for instr in result:
                        prep_file.write(instr)
                    instr_counter += deltaInstr
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
                        if instr_counter % 2:
                            result.append(self.NOP + "\n")
                            instr_counter += 1
                        result += self.__num_to_reg(line[1], labels[line[2]])
                        instr_counter += 4
                        for instr in result:
                            prep_file.write(instr)
                        continue
                    else:
                        raise ValueError("Unknown label: " + str(line[2]))

                # substitute label to load / store / mov
                if line[0] in mem_suffix_commands_unprocessed and \
                        (line[2] not in registers or line[1] not in registers):
                    if line[1] in labels:
                        idx = 1
                    elif line[2] in labels:
                        idx = 2
                    else:
                        raise ValueError("Unknown label here: " + str(line))

                    # insert nop if needed before movl/movh
                    if instr_counter % 2:
                        result.append(self.NOP + "\n")
                        instr_counter += 1
                    result += self.__num_to_reg(LABEL_REGISTER, labels[line[idx]])
                    instr_counter += 4
                    line[idx] = LABEL_REGISTER

                # substituting label to jump
                if line[0] in mem_jump_commmands and line[1] not in registers:
                    if line[1] in labels:
                        if instr_counter % 2:
                            result.append(self.NOP + "\n")
                            instr_counter += 1
                        result += self.__num_to_reg(LABEL_REGISTER,
                                                    labels[line[1]])  # write label address to reg5
                        instr_counter += 4
                        line[1] = LABEL_REGISTER  # programmer has to save content of reg5 before jumping to label
                    else:
                        raise ValueError("Unknown label: " + str(line[1]))

                # movl/movh is basically two instructions
                if line[0] in mem_only_num_command_unprocessed:
                    instr_counter += 1

                # mov0/1; load0/1; store0/1; 'al'
                self.__coding_related_prep(line)
                result.append(" ".join(line) + "\n")

                # insert NOP after jump if jump's ip is even number.
                if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                    result.append(self.NOP + "\n")
                    instr_counter += 1

                if verbose:
                    print "Preprocess res: " + str([result, instr_counter])

                for instr in result:
                    prep_file.write(instr)
                instr_counter += 1

            if instr_counter % 2 == 1:
                prep_file.write(self.NOP + "\n")  # number of instructions should be even, else undefined behaviour
                instr_counter += 1
            if verbose:
                print "Number of instructions: " + str(instr_counter)

    @staticmethod
    def __encode_command(parsed_command):
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
            raise KeyError("Unknown command: " + str(command_clear))

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
                    raise ValueError("Can't move number to register: " + str(command_list[-1]))
                bin_num = "0" * (16 - len(bin_num)) + bin_num
                result += "0" * 2                                  # unused bits
                result += bin_num                                  # 16 bit number

            # jumps / movf
            elif command_clear in not_suffix_commands:
                result += registers[command_list[1]]          # 3 bits - first reg
                result += "0" * 6

            # coreidx
            elif command_clear in suffix_reg_commands:
                print "--------------------------------"
                print command_list
                print suffix
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
                print "Unknow command: " + command_list
                raise ValueError

        return result

    @staticmethod
    def __num_to_reg(reg, number):
        binary = bin(number)[2:]
        binary = "0" * (32 - len(binary)) + binary
        return ["movlal " + reg + " " + str(int(binary[16:], 2)) + "\n",
                "movhal " + reg + " " + str(int(binary[:16], 2)) + "\n"]

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
                labels[name] = instr_counter // 2   # take only text part; /2 bacause there are 2 instructions in one memory cell
                # instr_counter += 1
                if verbose:
                    print "Found new jump label: " + name + "=" + str(labels[name])
                continue

            # value label preprocessing
            if re.match(r"\s*\w+\s*(=)\s*\d+\s*", line):
                # take only text part and save number after '='
                name = re.findall(r"[a-zA-Z_]+", line)[0]
                labels[name] = int(re.findall(r"\d+", line)[0])
                if verbose:
                    print "Found new value label: " + name + "=" + str(labels[name])
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
                if instr_counter % 2:
                    instr_counter += 1
                instr_counter += 4
                continue

            # substitute label to load / store
            if line[0] in mem_suffix_commands_unprocessed and line[2] not in registers and line[2] in label_names:
                if instr_counter % 2:
                    instr_counter += 1
                instr_counter += 4

            # substituting label to jump
            if line[0] in mem_jump_commmands and line[1] not in registers and line[1] in label_names:
                if instr_counter % 2:
                    instr_counter += 1
                instr_counter += 4

            # movl/movh is basically two instructions
            if line[0] in mem_only_num_command_unprocessed:
                instr_counter += 1

            # insert NOP after jump if jump's ip is even number.
            if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                instr_counter += 1

            print(line, instr_counter)

            instr_counter += 1

        if instr_counter % 2 == 1:
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
                raise ValueError("Bad suffix: " + str(line[0][-2:]))
        elif line[0] in mem_suffix_commands_unprocessed:  # no suffix
            line[0] += "1"

        # add 'al' if needed
        if line[0] not in not_suffix_commands and line[0][-2:] not in suffixes:
            line[0] += "al"

    def __set_stacks_size(self, line):
        result = []
        sizes = []
        for i in range(1, len(line)):
            sizes.append(int(line[i]))

        # basic idea behind code below - using suffixes, load different number to stack registers
        # coreidx reg6; xor reg3 reg3 - clear register
        # movl reg3 i
        # cmp reg6 reg3
        # mov[l/h]eq reg5 address
        # msb reg5, ... mse reg5, ... sb reg5, ...
        stack_begin = self.RAM_SIZE - sum(sizes)
        binary_stack_begin = bin(stack_begin)[2:]
        binary_stack_begin = "0" * (32 - len(binary_stack_begin)) + binary_stack_begin

        my_stack_begin = stack_begin
        for i, size in enumerate(sizes):
            my_stack_end = my_stack_begin + size
            # convert to binary
            binary_my_stack_begin = bin(my_stack_begin)[2:]
            binary_my_stack_begin = "0" * (32 - len(binary_my_stack_begin)) + binary_my_stack_begin

            binary_my_stack_end = bin(my_stack_end)[2:]
            binary_my_stack_end = "0" * (32 - len(binary_my_stack_end)) + binary_my_stack_end

            result.append("coreidxal reg6\n")
            result.append("xoral reg3 reg3\n")
            result.append("movlal reg4 " + str(i) + "\n")
            result.append("cmpal reg6 reg3\n")
            # write number to LABEL_REGISTER (reg5) if this is core with index {i}
            result.append("movleq " + LABEL_REGISTER + " " + str(int(binary_my_stack_begin[16:], 2)) + "\n")
            result.append("movheq " + LABEL_REGISTER + " " + str(int(binary_my_stack_begin[:16], 2)) + "\n")
            result.append("msbeq " + LABEL_REGISTER+ "\n")
            result.append(self.NOP + "\n")
            result.append("movleq " + LABEL_REGISTER + " " + str(int(binary_my_stack_end[16:], 2)) + "\n")
            result.append("movheq " + LABEL_REGISTER + " " + str(int(binary_my_stack_end[:16], 2)) + "\n")
            result.append("mseeq " + LABEL_REGISTER+ "\n")
            result.append(self.NOP + "\n")
            result.append("movleq " + LABEL_REGISTER + " " + str(int(binary_stack_begin[16:], 2)) + "\n")
            result.append("movheq " + LABEL_REGISTER + " " + str(int(binary_stack_begin[:16], 2)) + "\n")
            result.append("sbeq " + LABEL_REGISTER+ "\n")
            result.append(self.NOP + "\n")

            my_stack_begin = my_stack_end

        return result, 16 * len(sizes)