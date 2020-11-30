from python_simulation.mem_modules import Memory, Register


CARRY_FLAG = 0


def add_reg(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def add_reg_c(reg1, reg2, flag):
    pass

def sub_reg(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def sub_reg_c(reg1, reg2, flag):
    pass

def and_reg(reg1, reg2, flag):
    val = reg1.read() & reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def or_reg(reg1, reg2, flag):
    val = reg1.read() | reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def xor_reg(reg1, reg2, flag):
    val = reg1.read() ^ reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def not_(reg1, reg2, flag):
    pass

def rshift_reg(reg1, reg2, flag):
    val = reg1.read() >> reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def lshift_reg(reg1, reg2, flag):
    val = reg1.read() << reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def inc(reg1, reg2, flag):
    pass

def dec(reg1, reg2, flag):
    pass

def wait():
    pass

def movf(reg1, reg2, flag):
    pass

def mul_reg(reg1, reg2, flag):
    val = reg1.read() * reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def mov_reg(reg1, reg2, flag):
    reg1.write(reg2.read())

def mov_num_low(reg1, num, flag):
    reg1.write(int(num))

def mov_num_high(reg1, num, flag):
    reg1.write((int(num) << 8) + reg1.read())

def load_to_mem(reg1: Register, reg2: Register, memory: Memory, flag):
    memory.write(address=reg2.read(), data=reg1.read())

def load_from_mem(reg1: Register, reg2: Register, memory: Memory, flag):
    reg1.write(data=memory.read(address=reg2.read()))

def cmp(reg1, reg2, flag):
    pass

def ch_mod(reg1, reg2, flag):
    flag["mode_flag"].inc()

def ch_buf(reg1, reg2, flag):
    flag["buffer_flag"].inc()

#######################################################################

def add_i(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag["zero_flag"] = 1 if not val else 0
    flag["neg_flag"] = 1 if val < 0 else 0
    flag["carry_flag"].write(reg1.write(val))

def sub_i(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag["zero_flag"] = 1 if not val else 0
    flag["neg_flag"] = 1 if val < 0 else 0
    flag["carry_flag"].write(reg1.write(val))

def je(reg1, reg2, flag):
    """
    :param reg1: instruction pointer
    :param reg2: new position of instruction pointer
    :param flag: Zero Flag
    :return:
    """
    if flag["zero_flag"]:
        reg1.write(reg2.read())

def jne(reg1, reg2, flag):
    pass

def jgt(reg1, reg2, flag):
    pass

def jge(reg1, reg2, flag):
    pass

def jlt(reg1, reg2, flag):
    pass

def jle(reg1, reg2, flag):
    pass

def jmp(reg1, reg2, flag):
    pass

def cmp_i(reg1, reg2, flag):
    pass

def mov_num_i_low(reg1, num, flag):
    reg1.write(int(num))

def mov_num_i_high(reg1, num, flag):
    reg1.write(int(num))


def nop(reg1, reg2, flag):
    pass
