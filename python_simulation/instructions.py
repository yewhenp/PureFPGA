from python_simulation.mem_modules import Memory, Register


CARRY_FLAG = 0

# ALU
def add_(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def addc_(reg1, reg2, flag):
    pass

def sub_(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def subc_(reg1, reg2, flag):
    pass

def mul_(reg1, reg2, flag):
    pass

def mulc_(reg1, reg2, flag):
    val = reg1.read() * reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def and_(reg1, reg2, flag):
    val = reg1.read() & reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def or_(reg1, reg2, flag):
    val = reg1.read() | reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def xor_(reg1, reg2, flag):
    val = reg1.read() ^ reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def not_(reg1, reg2, flag):
    pass

def rsh_(reg1, reg2, flag):
    val = reg1.read() >> reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def lsh_(reg1, reg2, flag):
    val = reg1.read() << reg2.read()
    flag["carry_flag"].write(reg1.write(val))

def cmp(reg1, reg2, flag):
    pass

def inc_(reg1, reg2, flag):
    pass

def dec_(reg1, reg2, flag):
    pass


# MEMORY
def movl_(reg1, num, flag):
    reg1.write(int(num))

def movh_(reg1, num, flag):
    reg1.write((int(num) << 8) + reg1.read())

def movf_(reg1, reg2, flag):
    pass

def mov_(reg1, reg2, flag):
    reg1.write(reg2.read())

def store_(reg1: Register, reg2: Register, memory: Memory, flag):
    memory.write(address=reg2.read(), data=reg1.read())

def load_(reg1: Register, reg2: Register, memory: Memory, flag):
    reg1.write(data=memory.read(address=reg2.read()))

def ch_mod(reg1, reg2, flag):
    flag["mode_flag"].inc_()

def ch_buf(reg1, reg2, flag):
    flag["buffer_flag"].inc_()

#######################################################################
# Instruction processor
######################################################################
# ALU
def addi_(reg1, reg2, flag):
    val = reg1.read() + reg2.read()
    flag["zero_flag"] = 1 if not val else 0
    flag["neg_flag"] = 1 if val < 0 else 0
    flag["carry_flag"].write(reg1.write(val))

def addci_(reg1, reg2, flag):
    pass

def subi_(reg1, reg2, flag):
    val = reg1.read() - reg2.read()
    flag["zero_flag"] = 1 if not val else 0
    flag["neg_flag"] = 1 if val < 0 else 0
    flag["carry_flag"].write(reg1.write(val))

def subci_(reg1, reg2, flag):
    pass

def muli_(reg1, reg2, flag):
    pass

def mulci_(reg1, reg2, flag):
    pass

def andi_(reg1, reg2, flag):
    pass

def ori_(reg1, reg2, flag):
    pass

def xori_(reg1, reg2, flag):
    pass

def noti_(reg1, reg2, flag):
    pass

def rshi_(reg1, reg2, flag):
    pass

def lshi_(reg1, reg2, flag):
    pass

def cmpi(reg1, reg2, flag):
    pass

def inci_(reg1, reg2, flag):
    pass

def deci_(reg1, reg2, flag):
    pass

# MEMORY
def movli_(reg1, num, flag):
    reg1.write(int(num))

def movhi_(reg1, num, flag):
    reg1.write((int(num) << 8) + reg1.read())

def movfi_(reg1, reg2, flag):
    pass

def movi_(reg1, reg2, flag):
    reg1.write(reg2.read())

def storei_(reg1: Register, reg2: Register, memory: Memory, flag):
    memory.write(address=reg2.read(), data=reg1.read())

def loadi_(reg1: Register, reg2: Register, memory: Memory, flag):
    reg1.write(data=memory.read(address=reg2.read()))

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
