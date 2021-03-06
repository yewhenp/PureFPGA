##################################################################
# DICTS AND LISTS FOR ASSEMBLING
##################################################################
command_types = {
    "core_alu": "11",
    "core_memory": "10",
    "processor_alu": "01",
    "processor_memory": "00"
}

commands = {
    'alu': {
        'add': '0000',
        'addc': '0001',
        'sub': '0010',
        'subc': '0011',
        'mul': '0100',
        'div': '0101',
        'and': '0110',
        'or': '0111',
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

        'store0': '00010',
        'store1': '00011',

        'mov0': '00100',
        'mov1': '00101',

        'movh': '00110',
        'movl': '00111',
        'movf': '01000',

        'je':  '01001',
        'jne': '01010',
        'jgt': '01011',
        'jge': '01100',
        'jlt': '01101',
        'jle': '01110',
        'jmp': '01111',

        'coreidx': '10000',
        'int'    : '10001'

        # 'chmod': '11110',
        # 'chbuf': '11111',
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
    'reg0': '000',
    'reg1': '001',
    'reg2': '010',
    'reg3': '011',
    'reg4': '100',
    'reg5': '101',
    'reg6': '110',
    'reg7': '111',
    "sp": "110",
    "ip": "111"
}

alu_one_dest_commands = [
    "not", "inc", "dec",
]

mem_suffix_commands = [
    "mov0", "mov1", "load0", "load1", "store0", "store1",
]

# mem_number_commands = [
#     'movh0', 'movh1', 'movh2', 'movh3', 'movh4', 'movh5',
#     'movl0', 'movl1', 'movl2', 'movl3', 'movl4', 'movl5'
# ]

# mem_movf_commands = [
#     "movf0", "movf1", "movf2", "movf3", "movf4", "movf5"
# ]

mem_jump_commmands = [
    'je', 'jne', 'jgt', 'jge', 'jlt', 'jle', 'jmp'
]

not_suffix_commands = [
    'je', 'jne', 'jgt', 'jge', 'jlt', 'jle', 'jmp', 'movf' # , "chbuf", "chmod"
]

coreidx = [
    "coreidx"
]

##################################################################
# DICTS AND LISTS FOR PREPROCESSING
##################################################################
mem_suffix_commands_unprocessed = [
    "mov", "load", "store"
]

mem_number_commands_unprocessed = [
    'movh', 'movl', 'movf',
]

mem_only_num_command_unprocessed = [
    "movh", "movl"
]

suffixes_0 = {
    'eq', 'ne', 'gt', 'lt',
    'ge', 'le', 'cs', 'cc'
}