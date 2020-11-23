import sys


class Assembler:
    def __init__(self, source_name: str=None, dest_name: str=None):
        self.source_name = source_name
        self.dest_name = dest_name


    def assemble_preprocessed(self, processed_file: str, verbose=False):
        with open(self.dest_name, "w") as dest_file:
            result = ""
            line_n = 0
            for line in open(processed_file, "r"):
                line = line.strip()
                encoded = self.encode_command(line)
                result += encoded + "\n"
                if verbose:
                    print(f"Processed line #{line_n}: {encoded}")
                    line_n += 1
            dest_file.write(result)


    def encode_command(self, parsed_command: str):
        result = ""
        command_list = parsed_command.split()

        # suffixes
        if command_list[0][-2:] in self.suffixes:
            command_clear = command_list[0][:-2]
            suffix = command_list[0][-2:]
        else:
            command_clear = command_list[0]
            suffix = ""

        # four command types
        if command_clear in self.commands['core']['alu']:
            command_type = "core_alu"
        elif command_clear in self.commands['core']['memory']:
            command_type = "core_memory"
        elif command_clear in self.commands['instruction processor']['alu']:
            command_type = "processor_alu"
        elif command_clear in self.commands['instruction processor']['memory']:
            command_type = "processor_memory"
        else:
            raise KeyError(f"Unknown command: {command_clear}")         # TODO: move this check to preprocessor

        # first two bits of command
        result += self.command_types[command_type]

        if command_type == "core_alu":
            result += self.commands["core"]["alu"][command_clear]   # 4 bits - command
            result += self.suffixes[suffix]                         # 4 bits - suffix
            result += self.registers["core"][command_list[1]]       # 2 bits - dest reg
            result += self.registers["core"][command_list[2]]       # 2 bits - first operand
            result += self.registers["core"][command_list[3]]       # 2 bits - second operand

        elif command_type == "processor_alu":
            result += self.commands["processor"]["alu"][command_clear]  # 4 bits
            result += self.suffixes[suffix]                             # 4 bits
            result += self.registers["processor"][command_list[1]]      # 3 bits - dest reg and first operand
            result += self.registers["processor"][command_list[2]]      # 3 bits - second operand

        elif command_type == "core_memory":
            result += self.commands["core"]["memory"][command_clear]    # 5 bits - command

            if command_clear in self.mem_suffix_commands:
                result += self.suffixes[suffix][1:]                     # 3 bits - suffix (why 3 not 4 - read documentation)
                result += self.registers["core"][command_list[1]]       # 3 bits - dest reg
                result += self.registers["core"][command_list[2]]       # 3 bits - source reg
                result += "0"*2                                         # TODO: unused bits
            elif command_clear in self.mem_number_commands:
                bin_num =  bin(int(command_list[-1]))[2:]
                if len(bin_num) > 8:
                    raise ValueError(f"Can't move number to register: {command_list[-1]}")
                bin_num = "0"*(8-len(bin_num)) + bin_num
                result += bin_num                                       # 8 bit number
                result += "0"                                           # unused bit TODO: do something with this
            else:
                result += "0"*9                                         # unsued bits TODO:

        else: # commandt_type == "processor_memory"
            result += self.commands["processor"]["memory"][command_clear]  # 5 bits - command

            if command_clear in self.mem_suffix_commands:
                result += self.suffixes[suffix][1:]  # 3 bits - suffix (why 3 not 4 - read documentation)
                result += self.registers["processor"][command_list[1]]  # 3 bits - dest reg
                result += self.registers["processor"][command_list[2]]  # 3 bits - source reg
            elif command_clear in self.mem_number_commands:
                bin_num = bin(int(command_list[-1]))[2:]
                if len(bin_num) > 8:
                    raise ValueError(f"Can't move number to register: {command_list[-1]}")
                bin_num = "0" * (8 - len(bin_num)) + bin_num
                result += bin_num  # 8 bit number
                result += "0"  # unused bit TODO: do something with this
            else:
                result += "0" * 9  # unsued bits TODO:

        return result

    command_types = {
        "core_alu": "11",
        "core_memory": "10",
        "processor_alu": "01",
        "processor_memory": "00"
    }

    commands = {
        'core': {
            'alu': {
                'add': '0000',
                'addc':'0001',
                'sub': '0010',
                'subc':'0011',
                'mul': '0100',
                'mulc':'0101',
                'and': '0110',
                'or':  '0111',
                'xor': '1000',
                'lsh': '1001',
                'rsh': '1010',
                'not': '1011',
                'cmp': '1100',
                'inc': '1101',
                'dec': '1110'
            },
            'memory': {
                'load0': '00000',
                'load1': '00001',
                'store0':'00010',
                'store1':'00011',
                'mov0':  '00100',
                'mov1':  '00101',
                'movh0': '00110',
                'movh1': '00111',
                'movh2': '01000',
                'movh3': '01001',
                'movl0': '01010',
                'movl1': '01011',
                'movl2': '01100',
                'movl3': '01101',
                'movf0': '01110',
                'movf1': '01111',
                'movf2': '10000',
                'movf3': '10001',
                'chmod': '10010',
                'chbuf': '10011'
            }
        },
        'instruction processor': {
            'alu': {
                'addi': '0000',
                'addci':'0001',
                'subi': '0010',
                'subci':'0011',
                'muli': '0100',
                'mulci':'0101',
                'andi': '0110',
                'ori':  '0111',
                'xori': '1000',
                'lshi': '1001',
                'rshi': '1010',
                'noti': '1011',
                'cmpi': '1100',
                'inci': '1101',
                'deci': '1110'
            },
            'memory': {
                'load0i' :'00000',
                'store0i':'00001',
                'mov0i' : '00010',
                'load1i': '00011',
                'store1i':'00100',
                'mov1i' : '00101',
                'movh0i': '00110',
                'movh1i': '00111',
                'movh2i': '01000',
                'movh3i': '01001',
                'movh4i': '01010',
                'movh5i': '01011',
                'movl0i': '01100',
                'movl1i': '01101',
                'movl2i': '01110',
                'movl3i': '01111',
                'movl4i': '10000',
                'movl5i': '10001',
                'movf0i': '10010',
                'movf1i': '10011',
                'movf2i': '10100',
                'movf3i': '10101',
                'movf4i': '10110',
                'movf5i': '10111',
                'jmp': '11000',
                'jne': '11001',
                'jgt': '11010',
                'jge': '11011',
                'jlt': '11100',
                'jle': '11101'
            }
        }
    }

    suffixes = {
        'eq': '0000',
        'ne': '0001',
        'gt': '0010',
        'lt': '0011',
        'ge': '0100',
        'le': '0101',
        'cs': '0110',
        'cc': '0111',
        'mi': '1000',
        'pl': '1001',
        'al': '1010',
        'nv': '1011',
        'vs': '1100',
        'vc': '1101',
        'hi': '1110',
        'ls': '1111',
    }

    registers = {
        'core': {
            'reg0': '00',
            'reg1': '01',
            'reg2': '10',
            'reg3': '11'
        },
        'instruction processor': {
            'reg0': '000',
            'reg1': '001',
            'reg2': '010',
            'reg3': '011',
            'reg4': '100',
            'reg5': '101',
            'reg6': '110',
            'reg7': '111'
        }
    }

    mem_suffix_commands = [
        "mov0", "mov1", "load0", "load1", "store0", "store1",
        "mov0i", "mov1i", "load0i", "load1i", "store0i", "store1i"
    ]
    mem_number_commands = [
        'movh0', 'movh1', 'movh2', 'movh3',
        'movl0', 'movl1', 'movl2', 'movl3',
        'movf0', 'movf1', 'movf2', 'movf3',
        'movh0i', 'movh1i', 'movh2i', 'movh3i',
        'movl0i', 'movl1i', 'movl2i', 'movl3i',
        'movf0i', 'movf1i', 'movf2i', 'movf3i'
                           ]

if __name__ == '__main__':
    if len(sys.argv) == 2:
        source = sys.argv[1]
        dest = "a.out"
    elif len(sys.argv) == 4 and sys.argv[2] == "o":
        source = sys.argv[1]
        dest = sys.argv[3]
    else:
        raise AttributeError("Bad options!")
    assembler = Assembler(source_name=source, dest_name=dest)
    assembler.assemble_preprocessed(source, True)
