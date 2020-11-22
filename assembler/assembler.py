def read_file(path):
    with open(path) as filee:
        data = filee.read().split("\n")
    return data


commands = {
    'cores': {
        'alu': {
            'add': '0000',
            'addc': '0001',
            'sub': '0010',
            'subc': '0011',
            'and': '0100',
            'or': '0101',
            'xor': '0110',
            'mul': '0111',
            'cmp': '1000',
            'lsh': '1010',
            'rsh': '1011',
            'not': '1100',
            'inc': '1101',
            'dec': '1110'
        },
        'other': {
            'load0': '00000',
            'load1': '00001',
            'store0': '00010',
            'store1': '00011',
            'mov0': '00100',
            'mov1': '00101',
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
            'addic': '0001',
            'subi': '0010',
            'subic': '0011',
            'andi': '0100',
            'ori': '0101',
            'xori': '0110',
            'muli': '0111',
            'cmpi': '1000',
            'lshi': '1010',
            'rshi': '1011',
            'noti': '1100',
            'inci': '1101',
            'deci': '1110'
        },
        'other': {
            'load0i': '00000',
            'load1i': '00001',
            'store0i': '00010',
            'store1i': '00011',
            'mov0i': '00100',
            'mov1i': '00101',
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

registers = {
    'cores': {
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


def encode_command(command):
    result = ""
    command_list = command.split()

    if command_list[0] in commands['cores']['alu'].keys():
        result += "11"
    elif command_list[0] in commands['cores']['other'].keys():
        result += "10"
    elif command_list[0] in commands['instruction processor']['alu'].keys():
        result += "01"
    elif command_list[0] in commands['instruction processor']['other'].keys():
        result += "00"
    else:
        raise KeyError("Unknown command")

    if result[1] == "1":
        if result[0] == "1":
            result += commands['cores']['alu'][command_list[0]]
        else:
            result += commands['instruction processor']['alu'][command_list[0]]

        #TODO: Implement suffixes
        result += "0000"

        if result[0] == "1":
            result += registers['cores'][command_list[1]]
            result += registers['cores'][command_list[2]]
            result += registers['cores'][command_list[3]]

        else:
            result += registers['instruction processor'][command_list[1]]
            result += registers['instruction processor'][command_list[2]]


    else:
        if result[0] == "1":
            result += commands['cores']['other'][command_list[0]]
        else:
            result += commands['instruction processor']['other'][command_list[0]]


