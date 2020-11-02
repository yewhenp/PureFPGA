from mem_modules import Memory, Register


CARRY_FLAG = 0


def add_reg(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag.write(reg1.write(val))

def sub_reg(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag.write(reg1.write(val))

def and_reg(reg1, reg2, flag):
    val = reg1.read() & reg2.read()
    flag.write(reg1.write(val))

def or_reg(reg1, reg2, flag):
    val = reg1.read() | reg2.read()
    flag.write(reg1.write(val))

def xor_reg(reg1, reg2, flag):
    val = reg1.read() ^ reg2.read()
    flag.write(reg1.write(val))

def rshift_reg(reg1, reg2, flag):
    val = reg1.read() >> reg2.read()
    flag.write(reg1.write(val))

def lshift_reg(reg1, reg2, flag):
    val = reg1.read() << reg2.read()
    flag.write(reg1.write(val))

def mul_reg(reg1, reg2, flag):
    val = reg1.read() * reg2.read()
    flag.write(reg1.write(val))

def mov_reg(reg1, reg2, flag):
    reg1.write(reg2.read())

def mov_num_low(reg1, num, flag):
    reg1.write(int(num))

def mov_num_high(reg1, num, flag):
    reg1.write(int(num) << 8)

def load_to_mem(reg1: Register, reg2: Register, memory: Memory, flag):
    memory.write(reg1.read(), reg2.read())

def ch_mod(reg1, reg2, flag):
    flag.inc()

def ch_buf(reg1, reg2, flag):
    flag.inc()

#######################################################################

def add_i(reg1, reg2, flag):
    add_reg(reg1, reg2, flag)

def sub_i(reg1, reg2, flag):
    sub_reg(reg1, reg2, flag)

def je(reg1, reg2, flag):
    """

    :param reg1:
    :param reg2:
    :param flag:
    :return:
    """
    pass

def mov_num_i(reg1, num):
    pass
