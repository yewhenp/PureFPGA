import re
from pprint import pprint
from .utils import *


class Assembler:
    NOP = "addnv reg0 reg0"
    NOP_ = ["addnv", "reg0", "reg0"]
    RAM_SIZE = 65535

    def __init__(self, source_file=None, prep_file=None, dest_file=None):
        self.source_file = source_file
        self.prep_file = prep_file
        self.dest_file = dest_file
        self.COMMAND_TYPE_ENCODE = {"alu": self.__alu_encode, "mem": self.__mem_encode}

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

    def __encode_command(self, parsed_command):
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
            command_type = "mem"
        else:
            raise KeyError("Unknown command: " + str(command_clear))

        # first two bits of command
        # first bit - 16 or 32 bit command
        result = result + "1" if command_clear in mem_only_num_command_unprocessed else result + "0"
        # second bit - alu or mem command
        result = result + "1" if command_type == "alu" else result + "0"

        # other 14 / 30 bits
        result += self.COMMAND_TYPE_ENCODE[command_type](command_clear, suffix, command_list)

        return result

    @staticmethod
    def __alu_encode(command_clear, suffix, command_list):
        result = ""
        result += commands["alu"][command_clear]         # 4 bits - opcode
        result += suffixes[suffix]                       # 4 bits - suffix
        result += registers[command_list[1]]             # 3 bits - dest reg
        if command_clear not in alu_one_dest_commands:   # if not inc/dec/not
            result += registers[command_list[2]]         # 3 bits - second operand
        else:
            result += "0" * 3                            # unused bits
        return result

    @staticmethod
    def __mem_encode(command_clear, suffix, command_list):
        result = ""
        result += commands["memory"][command_clear]     # 5 bits - opcode

        # load / store / mov
        if command_clear in mem_suffix_commands:
            result += suffixes[suffix][1:]              # 3 bits - suffix
            result += registers[command_list[1]]        # 3 bits - first reg
            result += registers[command_list[2]]        # 3 bits - second reg

        # movl/movh
        elif command_clear in mem_only_num_command_unprocessed:
            result += suffixes[suffix]                  # 4 bits - suffix
            result += registers[command_list[1]]        # 3 bits - register
            bin_num = bin(int(command_list[-1]))[2:]
            if len(bin_num) > 16:
                raise ValueError("Can't move number to register: " + str(command_list[-1]))
            bin_num = "0" * (16 - len(bin_num)) + bin_num
            result += "0" * 2                           # unused bits
            result += bin_num                           # 16 bit number

        # jumps / movf
        elif command_clear in not_suffix_commands:
            result += registers[command_list[1]]        # 3 bits - first reg
            result += "0" * 6                           # 6 bits unused

        # coreidx / stack commands
        elif command_clear in suffix_reg_commands:
            result += suffixes[suffix]                  # 4 bits - suffix
            result += registers[command_list[1]]        # 3 bites - register
            result += "0" * 2                           # 2 bits - unused

        # int
        elif command_clear == "int":
            result += suffixes[suffix]                  # 4 bits suffix
            bin_num = bin(int(command_list[-1]))[2:]
            bin_num = "0" * (3 - len(bin_num)) + bin_num
            result += bin_num                           # 3 bits interrupt number
            result += "0" * 2                           # 2 bits 0 unused
        else:
            raise ValueError("Unknow command: " + command_list)
        return result

    def preprocess_source(self, verbose=False):
        with open(self.prep_file, "w") as prep_file:

            # detect labels and remove comments
            val_labels, jump_labels, stripped_program = self.__find_labels_and_strip(self.source_file, verbose=verbose)

            # replace core_num and insert movl and movh for labels where needed
            program = self.__extract_labels_macroses(stripped_program, jump_labels=jump_labels)
            pprint(program)

            # insert everywhere where needed nops, and handle stack
            program = self.__nop_inserter(program, jump_labels)

            # add 'al' suffix where needed and handle '0'-'1' memory hell
            program = self.__coding_related_prep(program)

            labels = val_labels
            labels.update(jump_labels)

            # replace labels with corresponding numbers
            program = self.__insert_labels(program, labels)

            if len(program) % 2:
                program.append(self.NOP_)

            if verbose:
                print("Preprocessed:")
                pprint(program)

            for line in program:
                prep_file.write(" ".join(line) + "\n")

    @staticmethod
    def __find_labels_and_strip(file_, verbose):
        instr_counter = 0
        stripped_program = []
        val_labels = {}
        jump_labels = {}

        # now find values of labels
        for line in open(file_, "r"):
            if line.strip().startswith("//") or line.strip() == "":
                continue
            line = re.sub("//(.)*", "", line).strip().lower()

            # jump label
            if re.match(r"\s*\w+\s*(:)\s*", line):
                label_name = re.findall(r"[a-zA-Z_]+", line)[0]
                # labels[label_name] = instr_counter
                jump_labels[label_name] = instr_counter
                if verbose:
                    print "Found new jump label: " + str(label_name) + "=" + str(instr_counter)
                    continue

            # value label
            if re.match(r"\s*\w+\s*(=)\s*\d+\s*", line):
                label_name = re.findall(r"[a-zA-Z_]+", line)[0]
                val_labels[label_name] = instr_counter
                if verbose:
                    print "Found new value label: " + str(label_name) + "=" + str(instr_counter)
                    continue

            line = line.split()
            stripped_program.append(line)

            instr_counter += 1

        return val_labels, jump_labels, stripped_program

    def __extract_labels_macroses(self, program, jump_labels):
        processed_program = []
        instr_counter = 0

        # now insert labels
        for line in program:
            if line[0] in MACROSES:
                exctracted = MACROSES[line[0]](self, line)
                processed_program += exctracted[0]
                for label in jump_labels:
                    if jump_labels[label] > instr_counter:
                        jump_labels[label] += exctracted[1] - 1
                instr_counter += exctracted[1]

            # change CORE_NUM to 4 for movl/movh
            elif line[0] in mem_only_num_command_unprocessed and line[2] == "core_num":
                line[2] = CORE_NUM
                processed_program.append(line)
                instr_counter += 1

            # mov regi label = movl regi label[16:] + movl regi label[:16]
            elif line[0] == "mov" and line[2] not in registers:
                if line[2] in jump_labels:
                    for label in jump_labels:
                        if jump_labels[label] > instr_counter:
                            jump_labels[label] += 1
                    instr_counter += 2
                else:
                    raise ValueError("Unknown label: " + str(line[2]))
                processed_program += label_to_reg(line[1], line[2])

            # substitute label to load / store
            # load regi label / store regi label
            # load label regi / store label regi
            elif line[0] in mem_suffix_commands_unprocessed and \
                    (line[2] not in registers or line[1] not in registers):
                # detect if label is first or second operand
                if line[1] in jump_labels:
                    idx = 1
                elif line[2] in jump_labels:
                    idx = 2
                else:
                    raise ValueError("Unknown label here: " + str(line))
                for label in jump_labels:
                    if jump_labels[label] > instr_counter:
                        jump_labels[label] += 2
                instr_counter += 3

                processed_program += label_to_reg(LABEL_REGISTER, line[idx])

                line[idx] = LABEL_REGISTER
                processed_program.append(line)

            # substituting label to jump
            elif line[0] in mem_jump_commmands and line[1] not in registers:
                if line[1] in jump_labels:
                    for label in jump_labels:
                        if jump_labels[label] > instr_counter:
                            jump_labels[label] += 2
                    instr_counter += 3
                else:
                    raise ValueError("Unknown label: " + str(line[1]))
                processed_program += label_to_reg(LABEL_REGISTER,
                                                         line[1])  # write label address to reg5
                line[1] = LABEL_REGISTER  # programmer has to save content of reg5 before jumping to label
                processed_program.append(line)
            else:
                processed_program.append(line)
                instr_counter += 1

        return processed_program

    def __nop_inserter(self, program, jump_labels):
        # update labels
        processed_program = []
        instr_counter = 0

        for line in program:

            # regular nop
            if line[0] == "nop":
                processed_program.append(self.NOP_)
                instr_counter += 1
                continue

            # current instruction is one of the jumps label
            cur_label = list(filter(lambda x: x[1] == instr_counter, list(jump_labels.items())))
            if len(cur_label) > 0:
                # insert nop before jump label if its odd
                if instr_counter % 2:
                    processed_program.append(self.NOP_)

                    # update all labels below current and current
                    for label in jump_labels:
                        if jump_labels[label] >= instr_counter:
                            jump_labels[label] += 1
                    instr_counter += 1  # because of NOP

            # insert NOP before movl / movh if instruction's number is odd
            if line[0] in mem_only_num_command_unprocessed or \
                    line[0][:-2] in mem_only_num_command_unprocessed:
                delta = 0
                if instr_counter % 2:
                    processed_program.append(self.NOP_)
                    delta += 1

                delta += 1  # movl/movh is 32 bit
                for label in jump_labels:
                    if jump_labels[label] > instr_counter:
                        jump_labels[label] += delta
                instr_counter += delta

            # insert NOP after jump if jump's ip is even number.
            if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
                processed_program.append(self.NOP_)
                for label in jump_labels:
                    if jump_labels[label] > instr_counter:
                        jump_labels[label] += 1
                instr_counter += 1

            processed_program.append(line)
            instr_counter += 1
        return processed_program

    @staticmethod
    def __insert_labels(program, labels):
        for label in labels:
            labels[label] //= 2  # remeber that instructions are 16 bit when mem 32

        def to_bin(number):
            binary = bin(number)[2:]
            binary = "0" * (32 - len(binary)) + binary
            return str(int(binary[16:], 2)), str(int(binary[:16], 2))

        for idx, line in enumerate(program):
            if line[-1] in labels or line[-2] in labels:
                i = -1 if line[-1] in labels else -2
                first_half, second_half = to_bin(labels[line[i]])
                line[i] = first_half
                program[idx+1][i] = second_half
        return program

    @staticmethod
    def __coding_related_prep(program):
        for line in program:
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
        return program
