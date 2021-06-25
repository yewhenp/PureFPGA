import re
from pprint import pprint
from .utils import *
import sys


class Assembler:
    NOP_ = ["addnv", "reg0", "reg0"]
    RAM_SIZE = 65535

    def __init__(self, source_file=None, prep_file=None, dest_file=None):
        self.source_file = source_file
        self.prep_file = prep_file
        self.dest_file = dest_file
        self.COMMAND_TYPE_ENCODE = {"alu": self.__alu_encode, "mem": self.__mem_encode}

    def assemble_preprocessed(self, verbose=False):
        with open(self.dest_file, "w") as dest_file:
            result = ""
            temp = ""
            counter = 0
            for line_n, line in enumerate(open(self.prep_file, "r")):
                line = line.strip()
                try:
                    encoded = self.__encode_command(line)
                except Exception:
                    print(str(line))
                    print("Error occured during assembling in line {}".format(str(line)))
                    sys.exit(1)

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

    def __encode_command(self, parsed_instruction):
        """
        Encodes one preprocessed instruction.
        :param parsed_instruction: string, one strippeed line of prep file
            For example: 'movleq reg0 12'
        :return: string, 16/32 zeros and ones
        """
        result = ""
        command_list = parsed_instruction.split()

        # extract suffixes and clear command from parsed instruction
        if command_list[0][-2:] in suffixes and command_list[0] not in not_suffix_commands:
            command_clear = command_list[0][:-2]
            suffix = command_list[0][-2:]
        else:
            command_clear = command_list[0]
            suffix = ""

        # two instruction types opcode
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
    def __alu_encode(instruction_clear, suffix, instruction_list):
        """
        Encodes one alu instruction
        :param instruction_clear: string, instruction without suffix
        :param suffix: string, suffix of the command if no suffix, then empty string
        :param instruction_list: list, whole splitted instruction by space
        :return: string, 14 0/1s encoding this instruction
        """
        result = commands["alu"][instruction_clear]         # 4 bits - opcode
        result += suffixes[suffix]                          # 4 bits - suffix
        result += registers[instruction_list[1]]            # 3 bits - dest reg
        if instruction_clear not in alu_one_dest_commands:  # if not inc/dec/not (1 operand instructions)
            result += registers[instruction_list[2]]        # 3 bits - second operand
        else:
            result += "0" * 3                               # unused bits
        return result

    @staticmethod
    def __mem_encode(instruction_clear, suffix, instruction_list):
        """
        Encodes one memory instruction
        :param instruction_clear: string, instruction without suffix
        :param suffix: string, suffix of the command if no suffix, then empty string
        :param instruction_list: list, whole splitted instruction by space
        :return: string, 14/30 0/1s encoding this instruction
        """
        result = commands["memory"][instruction_clear]     # 5 bits - opcode

        # load / store / mov
        if instruction_clear in mem_suffix_commands:
            result += suffixes[suffix][1:]                  # 3 bits - suffix
            result += registers[instruction_list[1]]        # 3 bits - first reg
            result += registers[instruction_list[2]]        # 3 bits - second reg

        # movl/movh
        elif instruction_clear in mem_only_num_command_unprocessed:
            result += suffixes[suffix]                      # 4 bits - suffix
            result += registers[instruction_list[1]]        # 3 bits - register
            bin_num = bin(int(instruction_list[-1]))[2:]
            if len(bin_num) > 16:
                raise ValueError("Can't move number to register: " + str(instruction_list[-1]))
            bin_num = "0" * (16 - len(bin_num)) + bin_num
            result += "0" * 2                           # unused bits
            result += bin_num                           # 16 bit number

        # jumps / movf
        elif instruction_clear in not_suffix_commands:
            result += registers[instruction_list[1]]        # 3 bits - first reg
            result += "0" * 6                               # 6 bits unused

        # coreidx / stack commands
        elif instruction_clear in suffix_reg_commands:
            result += suffixes[suffix]                  # 4 bits - suffix
            result += registers[instruction_list[1]]    # 3 bites - register
            result += "0" * 2                           # 2 bits - unused

        # int
        elif instruction_clear == "int":
            result += suffixes[suffix]                  # 4 bits suffix
            bin_num = bin(int(instruction_list[-1]))[2:]
            bin_num = "0" * (3 - len(bin_num)) + bin_num
            result += bin_num                           # 3 bits interrupt number
            result += "0" * 2                           # 2 bits 0 unused
        else:
            raise ValueError("Unknow command: " + str(instruction_list))
        return result

    ##################################
    # PREPROCESSING RELATED METHODS
    ##################################

    def preprocess_source(self, verbose=False):
        """
        Preprocessed source file, and saves result to self.prep_file
        What is preprocessing:
            - find value/jump labels and trace their values during preprocessing (that increases number of isntructions)
            - expand macroses
            - insert nopes, where needed (due to isa implementation details)
            - replace some instructions with actual (add suffixes, mov/load/store -> mov0/1 / load0/1 / store0/1
            - inser labels

        :param verbose:
        :return: None
        """
        with open(self.prep_file, "w") as prep_file:
            # detect labels and remove comments
            val_labels, jump_labels, stripped_program = self.__find_labels_and_strip(self.source_file, verbose=verbose)

            # replace core_num and insert movl and movh for labels where needed
            program = self.__extract_labels_macroses(stripped_program, jump_labels=jump_labels, value_labels=val_labels)
            if verbose:
                print("After labels and macros extraction:")
                print("Jump labels: " + str(jump_labels))
                pprint(program)

            # insert everywhere where needed nops
            program, instr_counter = self.__nop_inserter(program, jump_labels)
            if verbose:
                print("After nop_inserter:")
                print("Jump labels: " + str(jump_labels))
                pprint(program)

            # add 'al' suffix where needed and handle '0'-'1' memory opcode hell
            program = self.__coding_related_prep(program)

            for label in jump_labels:
                jump_labels[label] //= 2  # remeber that instructions are 16 bit when mem 32

            # merge labels
            labels = val_labels
            labels.update(jump_labels)

            # replace all labels with corresponding numbers
            program = self.__insert_labels(program, labels)
            if verbose:
                print("After labels insertion:")
                print("Jump labels: " + str(jump_labels))
                pprint(program)

            # program should be alligned on 32 bits
            if instr_counter % 2:
                program.append(self.NOP_)

            if verbose:
                print("Preprocessed:")
                pprint(program)

            for line in program:
                prep_file.write(" ".join(line) + "\n")

    @staticmethod
    def __find_labels_and_strip(source_filename, verbose):
        """
        Initial preprocessing of source file.
            - 'maps' program in file to list of lists, that other parts of preprocessing works with
            - detects all labels and setups initial values
        :param source_filename: name of source file
        :param verbose: 
        :return: list[list], dict, dict - program, jump labels, value labels
        """
        instr_counter = 0
        stripped_program = []
        val_labels = {}
        jump_labels = {}
        return_from_call_counter = 0

        # now find values of labels
        for line in open(source_filename, "r"):
            # comments and empty lines
            if line.strip().startswith("//") or line.strip() == "":
                continue
            line = re.sub("//(.)*", "", line).strip().lower()

            # jump label
            if re.match(r"\s*\w+\s*(:)\s*", line):
                label_name = re.findall(r"\w+", line)[0]
                jump_labels[label_name] = instr_counter
                if verbose:
                    print "Found new jump label: " + str(label_name) + "=" + str(instr_counter)
                continue

            # value label
            if re.match(r"\s*\w+\s*(=)\s*-?\d+\s*", line):
                label_name = re.findall(r"\w+", line)[0]
                # if '-' in line:
                value = re.findall(r"(=-?\d+)", line)[0]
                print(value)
                value = int(value.replace("=", ""))
                val_labels[label_name] = value
                if verbose:
                    print "Found new value label: " + str(label_name) + "=" + str(value)
                continue

            line = line.split()

            if instr_counter == 0 and line[0] != "stack_size":
                stripped_program.append(['stack_size', '1000', '1000', '1000', '1000'])
                instr_counter += 1

            # insert label below funtion call to return from it
            if "call" in line[0]:
                label_name = "__return_" + str(return_from_call_counter)
                line.append(label_name)
                jump_labels[label_name] = instr_counter + 1
                if verbose:
                    print("Add new return label: " + label_name + "=" + str(jump_labels[label_name]))
                return_from_call_counter += 1

            stripped_program.append(line)
            instr_counter += 1

        # early substitute to label, after $ sign
        for line in stripped_program:
            if len(line) > 2 and "core_num" in line[2]:
                line[2] = CORE_NUM
            else:
                for k in (1, 2):
                    if len(line) > k:
                        if '$' in line[k]:
                            label_name = line[k][line[k].index('$')+1:]
                            line[k] = line[k][:line[k].index('$')]
                            line[k] += str(val_labels[label_name])
        return val_labels, jump_labels, stripped_program

    def __extract_labels_macroses(self, program, jump_labels, value_labels):
        """
        Extracts macroses, and expanda  atomic usage of labels
        :param program: list[list]
        :param jump_labels: dict
        :return: list[list], updated program
        """

        processed_program = []
        instr_counter = 0

        for line in program:
            pure_instr = line[0] if not line[0][-2:] in suffixes else line[0][:-2]
            suffix = line[0][-2:] if line[0][-2:] in suffixes else ""

            # macros extraction
            if line[0] in MACROSES or pure_instr in MACROSES:
                if line[0] in MACROSES:
                    extracted = MACROSES[line[0]](self, line)
                else:
                    extracted = MACROSES[pure_instr](self, line)

                processed_program += extracted
                delta = len(extracted) - 1
                # update all jump labels below, since now there are more instructions above them
                self.__update_jump_labels(jump_labels, delta=delta, instr_counter=instr_counter)
                instr_counter += delta + 1

            # arithmetics + immediate
            elif pure_instr in commands["alu"] and pure_instr not in alu_one_dest_commands \
                    and line[-1].isdigit():
                processed_program += arith_macro(self, line)
                # update all jump labels below, since now there are more instructions above them
                self.__update_jump_labels(jump_labels, delta=2, instr_counter=instr_counter)
                instr_counter += 3

            # mov regi label = movl regi label[16:] + movh regi label[:16]
            elif pure_instr == "mov" and line[2] not in registers:
                if line[2] in value_labels or line[2] in jump_labels:
                    self.__update_jump_labels(jump_labels, delta=1, instr_counter=instr_counter)
                    instr_counter += 2
                else:
                    raise ValueError("Unknown label: " + str(line[2]))
                processed_program += label_to_reg(line[1], line[2], suffix)

            # substitute label to load / store
            # load regi label / store regi label
            # load label regi / store label regi
            elif pure_instr in load_store and \
                    (line[2] not in registers or line[1] not in registers):
                # detect if label is first or second operand
                if line[1] in jump_labels or line[1] in value_labels:
                    idx = 1
                elif line[2] in jump_labels or line[1] in value_labels:
                    idx = 2
                else:
                    raise ValueError("Unknown label here: " + str(line))
                self.__update_jump_labels(jump_labels, delta=2, instr_counter=instr_counter)
                instr_counter += 3

                processed_program += label_to_reg(LABEL_REGISTER, line[idx], suffix)

                line[idx] = LABEL_REGISTER
                processed_program.append(line)

            # substituting label to jump
            elif line[0] in mem_jump_commmands and line[1] not in registers:
                if line[1] in jump_labels or line[1] in value_labels:
                    self.__update_jump_labels(jump_labels, delta=2, instr_counter=instr_counter)
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
        """
        Inserts NOP, everywhere, where needed, also updates jump labels
        :param program: list[list]
        :param jump_labels: dict
        :return: list[list], updated program
        """
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
                # insert nop before jump label if ip is odd
                if instr_counter % 2:
                    processed_program.append(self.NOP_)
                    # update all labels below current and current
                    self.__update_jump_labels(jump_labels, delta=1, instr_counter=instr_counter-1) # -1 because this label should also be changed
                    instr_counter += 1  # because of NOP

            # insert NOP before movl / movh if instruction's number is odd
            if line[0] in mem_only_num_command_unprocessed or \
                    line[0][:-2] in mem_only_num_command_unprocessed:
                delta = 0
                if instr_counter % 2:
                    processed_program.append(self.NOP_)
                    delta += 1

                delta += 1  # movl/movh is 32 bit
                self.__update_jump_labels(jump_labels, delta=delta, instr_counter=instr_counter)
                instr_counter += delta

            # insert NOP before jump if jump's ip is even number.
            # if line[0] in mem_jump_commmands and instr_counter % 2 == 0:
            #     processed_program.append(self.NOP_)
            #     self.__update_jump_labels(jump_labels, delta=1, instr_counter=instr_counter)
            #     instr_counter += 1

            processed_program.append(line)
            instr_counter += 1
        return processed_program, instr_counter

    @staticmethod
    def __insert_labels(program, labels):
        """
        Goes through program, and fills labels, where needed
        :param program: list[list]
        :param labels: dict
        :return: updated program
        """
        # for label in labels:
        #     labels[label] //= 2  # remeber that instructions are 16 bit when mem 32

        for idx, line in enumerate(program):
            if len(line) >= 2 and (line[-1] in labels or line[-2] in labels):
                i = -1 if line[-1] in labels else -2
                first_half, second_half = to_bin(labels[line[i]])
                line[i] = first_half
                program[idx+1][i] = second_half
        return program

    @staticmethod
    def __coding_related_prep(program):
        """
        replaces preprocessed instructions with actual instructions
            - adds 'al' suffix, if no suffix provided
            - replaces mov/load/store with mov0/1 / load0/1 / store0/1
        :param program:
        :return:
        """
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

    @staticmethod
    def __update_jump_labels(labels, delta, instr_counter):
        for label in labels:
            if labels[label] > instr_counter:
                labels[label] += delta
