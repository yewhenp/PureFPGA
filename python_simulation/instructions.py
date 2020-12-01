from python_simulation.mem_modules import Memory, Register, Register16

# ALU
SIZE = 16
CARRY = 0
SIGN = 1
OVERFLOW = 2
ZERO = 3
CH_MODE = 4
CH_BUFF = 5


def set_bit(num, bit, pos):
    return num ^ (-bit ^ num) & (1 << pos)


def get_bit(num, pos):
    return (num >> pos) & 1


def set_flags(val, f):
    carry = get_bit(val, SIZE)
    sign = get_bit(val, SIZE - 1)
    overflow = carry ^ sign
    zero = val == 0
    flag = f.read()
    flag = set_bit(flag, carry, CARRY)
    flag = set_bit(flag, sign, SIGN)
    flag = set_bit(flag, overflow, OVERFLOW)
    flag = set_bit(flag, zero, ZERO)
    f.write(flag)


def add_(r1, r2, dst, f):
    val = r1.read() + r2.read()
    set_flags(val, f)
    dst.write(val)


def addc_(r1, r2, dst, f):
    val = r1.read() + r2.read() + get_bit(f.read(), CARRY)
    set_flags(val, f)
    dst.write(val)


def sub_(r1, r2, dst, f):
    val = r1.read() - r2.read()
    set_flags(val, f)
    dst.write(val)


def subc_(r1, r2, dst, f):
    val = r1.read() - r2.read() - get_bit(f.read(), CARRY)
    set_flags(val, f)
    dst.write(val)


def mul_(r1, r2, dst, f):
    val = r1.read() * r2.read()
    set_flags(val, f)
    dst.write(val)


def mulc_(r1, r2, dst, f):
    pass


def and_(r1, r2, dst, f):
    val = r1.read() & r2.read()
    dst.write(val)


def or_(r1, r2, dst, f):
    val = r1.read() | r2.read()
    dst.write(val)


def xor_(r1, r2, dst, f):
    val = r1.read() ^ r2.read()
    dst.write(val)


def not_(r1, r2, dst, f):
    val = ~r1.read()
    dst.write(val)


def rsh_(r1, r2, dst, f):
    val = r1.read() >> r2.read()
    dst.write(val)


def lsh_(r1, r2, dst, f):
    val = r1.read() << r2.read()
    dst.write(val)


def cmp_(r1, r2, dst, f):
    sub_(r1, r2, Register16(), f)


def inc_(r1, r2, dst, f):
    add_(r1, Register16(1), r1, f)


def dec_(r1, r2, dst, f):
    sub_(r1, Register16(1), r1, f)


# MEMORY
def movl_(reg1, num, flag):
    reg1.write(int(num))


def movh_(reg1, num, flag):
    reg1.write((int(num) << 8) + reg1.read())


def movf_(reg1, reg2, flag):
    mov_(reg1, flag, reg2)


def mov_(reg1, reg2, flag):
    reg1.write(reg2.read())


def store_(reg1: Register, reg2: Register, memory: Memory, flag):
    memory.write(address=reg2.read(), data=reg1.read())


def load_(reg1: Register, reg2: Register, memory: Memory, flag):
    reg1.write(data=memory.read(address=reg2.read()))


def chmod_(r1, r2, f):
    f.write(f.read() ^ 1 << CH_MODE)


def chbuf_(r1, r2, f):
    f.write(f.read() ^ 1 << CH_BUFF)


#######################################################################
# Instruction processor
######################################################################
# ALU
def addi_(r1, r2, dst, f):
    add_(r1, r2, dst, f)


def addci_(r1, r2, dst, f):
    addc_(r1, r2, dst, f)


def subi_(r1, r2, dst, f):
    sub_(r1, r2, dst, f)


def subci_(r1, r2, dst, f):
    subc_(r1, r2, dst, f)


def muli_(r1, r2, dst, f):
    mul_(r1, r2, dst, f)


def mulci_(r1, r2, dst, f):
    pass


def andi_(r1, r2, dst, f):
    and_(r1, r2, dst, f)


def ori_(r1, r2, dst, f):
    or_(r1, r2, dst, f)


def xori_(r1, r2, dst, f):
    xor_(r1, r2, dst, f)


def noti_(r1, r2, dst, f):
    not_(r1, r2, dst, f)


def rshi_(r1, r2, dst, f):
    rsh_(r1, r2, dst, f)


def lshi_(r1, r2, dst, f):
    lsh_(r1, r2, dst, f)


def cmpi_(r1, r2, dst, f):
    cmp_(r1, r2, dst, f)


def inci_(r1, r2, dst, f):
    inc_(r1, r2, dst, f)


def deci_(r1, r2, dst, f):
    dec_(r1, r2, dst, f)


# MEMORY
def movli_(reg1, num, flag):
    movl_(reg1, num, flag)


def movhi_(reg1, num, flag):
    movh_(reg1, num, flag)


def movfi_(reg1, reg2, flag):
    movf_(reg1, reg2, flag)


def movi_(reg1, reg2, flag):
    mov_(reg1, reg2, flag)


def storei_(reg1: Register, reg2: Register, memory: Memory, flag):
    store_(reg1, reg2, memory, flag)


def loadi_(reg1: Register, reg2: Register, memory: Memory, flag):
    load_(reg1, reg2, memory, flag)


def je_(reg1, reg2, flag):
    """
    :param reg1: instruction pointer
    :param reg2: new position of instruction pointer
    :param flag: flags
    :return:
    """
    if get_bit(flag.read, ZERO):
        movi_(reg1, reg2, flag)


def jne_(reg1, reg2, flag):
    if not get_bit(flag.read, ZERO):
        movi_(reg1, reg2, flag)


def jgt_(reg1, reg2, flag):
    if not get_bit(flag.read, SIGN) and (get_bit(flag.read, SIGN) == get_bit(flag.read, OVERFLOW)):
        movi_(reg1, reg2, flag)


def jge_(reg1, reg2, flag):
    if get_bit(flag.read, SIGN) == get_bit(flag.read, OVERFLOW):
        movi_(reg1, reg2, flag)


def jlt_(reg1, reg2, flag):
    if get_bit(flag.read, SIGN) != get_bit(flag.read, OVERFLOW):
        movi_(reg1, reg2, flag)


def jle_(reg1, reg2, flag):
    if get_bit(flag.read, SIGN) or (get_bit(flag.read, SIGN) != get_bit(flag.read, OVERFLOW)):
        movi_(reg1, reg2, flag)


if __name__ == '__main__':
    a = Register16(- 2 ** 15)
    b = Register16(2 ** 15)
    c = Register16()
    f = Register16()
    print(a.to_string("bin"), b.to_string("bin"))
    sub_(a, b, c, f)
    print(bin(c.read()))
    print(bin(f.read()))
