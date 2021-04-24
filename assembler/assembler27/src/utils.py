from .lists_and_dicts import *


def label_to_reg(reg, label):
    return ["movl", reg, label], \
           ["movh", reg, label]


def set_stacks_size(self, line):
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

        result.append(["coreidxal", "reg6"])
        result.append(["xoral", "reg3", "reg3"])
        result.append(["movlal", "reg4", str(i)])
        result.append(["cmpal", "reg6", "reg3"])
        result.append(self.NOP_)
        # write number to LABEL_REGISTER (reg5) if this is core with index {i}
        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_begin[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_begin[:16], 2))])
        result.append(["msbeq", LABEL_REGISTER])
        result.append(["moveq", "reg6", LABEL_REGISTER])

        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_end[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_end[:16], 2))])
        result.append(["mseeq", LABEL_REGISTER])
        result.append(self.NOP_)
        result.append(["movleq", LABEL_REGISTER, str(int(binary_stack_begin[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_stack_begin[:16], 2))])
        result.append(["sbeq", LABEL_REGISTER])
        result.append(self.NOP_)

        my_stack_begin = my_stack_end

    return result, 24 * len(sizes)


def push_macros(self, line):
    return [["store", line[1], "sp"], ["inc", "sp"]], 2


def pop_macro(self, line):
    return [["dec", "sp"], ["load", line[1], "sp"]], 2


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

        result.append(["coreidxal", "reg6"])
        result.append(["xoral", "reg3", "reg3"])
        result.append(["movlal", "reg4", str(i)])
        result.append(["cmpal", "reg6", "reg3"])
        # write number to LABEL_REGISTER (reg5) if this is core with index {i}
        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_begin[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_begin[:16], 2))])
        result.append(["msbeq", LABEL_REGISTER])
        result.append(["moveq", "reg6", LABEL_REGISTER])

        result.append(["movleq", LABEL_REGISTER, str(int(binary_my_stack_end[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_my_stack_end[:16], 2))])
        result.append(["mseeq", LABEL_REGISTER])
        result.append(["movleq", LABEL_REGISTER, str(int(binary_stack_begin[16:], 2))])
        result.append(["movheq", LABEL_REGISTER, str(int(binary_stack_begin[:16], 2))])
        result.append(["sbeq", LABEL_REGISTER])

        my_stack_begin = my_stack_end

    return result, 21 * len(sizes)


MACROSES = {
    "push": push_macros,
    "pop": pop_macro,
    "stack_size": set_stacks_size_macro
}