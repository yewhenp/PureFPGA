from python_simulation.Memory.mem_modules import *

class InstructionProc:
    instructions = {"add": add, "mov_reg": mov}
    def __init__(self, program_file):
        self.read_program_from_file(program_file)
        self.__ROM = ROM(65536, )

    def read_program_from_file(self, program_file):
        res = []
        with open(program_file, "r") as prg:
            for line in prg:

def add(reg1, reg2):
    pass

def mov(reg1, reg2)

class Z80:
    def __init__(self):
        pass

