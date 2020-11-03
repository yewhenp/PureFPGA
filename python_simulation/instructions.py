from mem_modules import Memory, Register


CARRY_FLAG = 0


def add_reg(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def sub_reg(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def and_reg(reg1, reg2, flag):
    val = reg1.read() & reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def or_reg(reg1, reg2, flag):
    val = reg1.read() | reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def xor_reg(reg1, reg2, flag):
    val = reg1.read() ^ reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def rshift_reg(reg1, reg2, flag):
    val = reg1.read() >> reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def lshift_reg(reg1, reg2, flag):
    val = reg1.read() << reg2.read()
    flag["carry_flag"].write(reg1.write(val))

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

def mov_num_i(reg1, num, flag):
    reg1.write(int(num))


def nop(reg1, reg2, flag):
    pass
