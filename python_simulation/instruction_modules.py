from mem_modules import *
from instructions import *
from core_modules import Core


NUMBER_OF_CORES = 64

class InstructionProc:
    instructions_2_args = {"add_reg": add_reg, "mov_reg": mov_reg}
    instructions_1_args = {}
    registers = {"reg0": 0, "reg1": 0, "reg2": 0, "reg3": 0, "ip": 0}
    flags = {"work": 0, "carry": 0}

    def __init__(self, program_file: str):
        program = self.__read_program_from_file(program_file)
        self.__ROM = ROM(65536, program)

        self.__cores = [Core() for _ in range(NUMBER_OF_CORES)]

    def execute(self, instruction):
        pass

    def fetch_instruction(self):
        pass

    def change_ip(self, address):
        self.registers["ip"] = address
        self.flags["work"] = 1




    def __read_program_from_file(self, program_file: str):
        res = []
        with open(program_file, "r") as prg:
            for idx, line in enumerate(prg):
                parsed = line.split(" ")
                if len(parsed != 3):
                    if parsed[0].lower() == "nop"
                    raise AssertionError(f"line: {idx}. Bad number of arguments!")
                if parsed[0] not in self.instructions_2_args:
                    raise KeyError(f"line: {idx}. Unknown instruction {parsed[0]}!")
                res.append([self.instructions_2_args[parsed[0].lower()], parsed[1], parsed[2]])
        return res

class Z80:
    def __init__(self):
        pass

