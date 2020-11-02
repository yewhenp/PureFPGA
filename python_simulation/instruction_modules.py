from mem_modules import *
from instructions import *
from core_modules import Core


NUMBER_OF_CORES = 64

class InstructionProc:
    instructions_2_args = {"add_reg": add_reg, "mov_reg": mov_reg}
    instructions_0_args = {"nop": nop}
    self_instructions = {}
    regs = {"reg0": Register16(0), "reg1": Register16(0), "reg2": Register16(0), "reg3": Register16(0),
                  "ip": Register16(0)}
    flags = {"work_flag": Register1(0), "carry_flag": Register1(0), "neg_flag": Register1(0), "zero_flag": Register1(0)}

    def __init__(self, program_file: str):
        self.ROM_SIZE = 65536
        program = self.__read_program_from_file(program_file)
        self.__ROM = ROM(self.ROM_SIZE, program)
        self.__cores = [Core() for _ in range(NUMBER_OF_CORES)]

    def execute(self, instruction):
        if instruction[3] in self.self_instructions:
            if instruction[3] == "nop":
                self.flags["work_flag"].write(0)
            else:
                instruction[0](self.regs[instruction[1]], self.regs[instruction[2]], self.flags)
        else:
            for core in self.__cores:
                core.execute(instruction[0], instruction[1], instruction[2])

    def fetch_instruction(self):
        instruction = self.regs["ip"]
        self.regs["ip"].inc()
        return instruction

    def change_ip(self, address):
        self.regs["ip"].write(address)
        self.flags["work"].write(1)

    def __read_program_from_file(self, program_file: str):
        res = []
        with open(program_file, "r") as prg:
            for idx, line in enumerate(prg):
                parsed = line.split(" ")
                if len(parsed != 3):
                    typ = parsed[0].lower()
                    if len(parsed == 0):
                        if typ == "ch_mod":
                            res.append([self.instructions_0_args[typ], "mode_flag", "mode_flag", parsed[0]])
                        if typ == "ch_buf":
                            res.append([self.instructions_0_args[typ], "buffer_flag", "buffer_flag", parsed[0]])
                        else:
                            res.append([self.instructions_0_args[typ], "", "", parsed[0]])
                    raise AssertionError(f"line: {idx}. Bad number of arguments!")
                if parsed[0] not in self.instructions_2_args:
                    raise KeyError(f"line: {idx}. Unknown instruction {parsed[0]}!")
                res.append([self.instructions_2_args[parsed[0].lower()], parsed[1], parsed[2], parsed[0]])
        return res

class Z80:
    def __init__(self):
        pass

