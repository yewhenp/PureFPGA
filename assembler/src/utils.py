from .lists_and_dicts import *

############################
# Useful functions
############################


def label_to_reg(reg, label, suffix=""):
    return ["movl" + suffix, reg, label], \
           ["movh" + suffix, reg, label]


# returns lower 16 bits of number, higher 16 bits of number
def to_bin(number):
    binary = bin(number)[2:]
    binary = "0" * (32 - len(binary)) + binary
    return str(int(binary[16:], 2)), str(int(binary[:16], 2))

############################
# Macroses
############################


# push regi
def push_macro(self, line):
    return [["store", line[1], "sp"], ["inc", "sp"]]


# pop regi
def pop_macro(self, line):
    return [["dec", "sp"], ["load", line[1], "sp"]]


# stack_size size0 size1 size2 size3
def set_stacks_size_macro(self, line):
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

        result.append(["coreidxal", "reg3"])
        result.append(["xoral", "reg4", "reg4"])
        result.append(["movlal", "reg4", str(i)])
        result.append(["cmpal", "reg3", "reg4"])
        # write number to LABEL_REGISTER (reg5) if this is core with index {i}
        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_begin[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_begin[:16], 2))])
        result.append(["msbeq", LABEL_REGISTER])
        result.append(["moveq", "reg6", LABEL_REGISTER])

        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_end[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_end[:16], 2))])
        result.append(["mseeq", LABEL_REGISTER])

        my_stack_begin = my_stack_end
    result.append(["movlal", LABEL_REGISTER, str(int(binary_stack_begin[16:], 2))])
    result.append(["movhal", LABEL_REGISTER, str(int(binary_stack_begin[:16], 2))])
    result.append(["sbal", LABEL_REGISTER])

    return result


# exception_addresses addr0 addr1 addr2 addr3
def set_excl_macro(self, line):
    result = []
    for i in range(len(line) - 1):
        address = line[i + 1]
        result.append(["coreidx", "reg6"])
        result.append(["xoral", "reg4", "reg4"])
        result.append(["movlal", "reg4", str(i)])
        result.append(["cmpal", "reg6", "reg4"])

        # number
        try:
            binary_addr = bin(int(address))[2:]
            binary_addr = "0" * (32 - len(binary_addr)) + binary_addr
            result.append(["movleq", LABEL_REGISTER, str(int(binary_addr[16:], 2))])
            result.append(["movheq", LABEL_REGISTER, str(int(binary_addr[:16], 2))])
        # label
        except ValueError:
            result.append(["movleq", LABEL_REGISTER, address])
            result.append(["movheq", LABEL_REGISTER, address])

        result.append(["excl", LABEL_REGISTER])

    return result


# call function_label return_label
def call_macro(self, line):
    suffix = "al" if line[0] == "call" else line[0][-2:]
    if suffix not in suffix_jump_correspondance:
        raise ValueError("Suffix " + str(suffix) + " is not supported for call")
    return [
        ["movl" + suffix, LABEL_REGISTER, line[2]],    # move return address to reg5
        ["movh" + suffix, LABEL_REGISTER, line[2]],
        ["store" + suffix, LABEL_REGISTER, "sp"],        # store it
        ["inc" + suffix, "sp"],
        ["movl" + suffix, LABEL_REGISTER, line[1]],    # move functin address to reg5
        ["movh" + suffix, LABEL_REGISTER, line[1]],
        [suffix_jump_correspondance[suffix], LABEL_REGISTER]
    ]                # jump there


# load to regi from stack based on reg4 and shift
def load_macro(self, line):
    op1 = "sub" if line[2].startswith("-") else "add"
    first, second = to_bin(int(line[2].strip("-")))
    return [
        ["movl", LABEL_REGISTER, first],
        ["movh", LABEL_REGISTER, second],
        ["mov", line[1], "reg4"],
        [op1, line[1], LABEL_REGISTER],
        ["load", line[1], line[1]]
    ]


# store to regi from stack based on reg4 and shift
def store_macro(self, line):
    first, second = to_bin(int(line[2].strip("-")))
    return [
        ["movl", LABEL_REGISTER, first],
        ["movh", LABEL_REGISTER, second],
        ["add", LABEL_REGISTER, "reg4"],
        ["store", line[1], LABEL_REGISTER]
    ]


# ret
def ret_macro(self, line):
    return [
        ["dec", "sp"],
        ["load", LABEL_REGISTER, "sp"],
        ["jmp", LABEL_REGISTER]
    ]


# movimm reg immediate
def movimm_macro(self, line):
    suffix = line[0][-2:] if line[0][-2:] in suffixes else "al"
    first, second = to_bin(int(line[2]))
    return ["movl" + suffix, line[1], first], \
           ["movh" + suffix, line[1], second]


MACROSES = {
    "push": push_macro,
    "pop": pop_macro,
    "stack_size": set_stacks_size_macro,
    "exception_addresses": set_excl_macro,
    "call": call_macro,
    "ret": ret_macro,
    "load_macro": load_macro,
    "store_macro": store_macro,
    "movimm": movimm_macro
}

############################
# SPECIAL MACROSES
############################


# arith[suffix] reg num
def arith_macro(self, line):
    first, second = to_bin(int(line[2]))
    suffix = line[0][-2:] if line[0][-2:] in suffixes else ""

    return [
        ["movl" + suffix, LABEL_REGISTER, first],
        ["movh" + suffix, LABEL_REGISTER, second],
        [line[0], line[1], LABEL_REGISTER]
    ]