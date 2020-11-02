from mem_modules import *
from instructions import *
from core_modules import SM


NUMBER_OF_CORES = 64

class InstructionProc:
    instructions_2_args = {"add_reg": add_reg, "sub_reg": sub_reg, "and_reg": and_reg, "or_reg": or_reg,
                           "xor_reg": xor_reg, "rshift_reg": rshift_reg, "lshift_reg": lshift_reg,
                           "mul_reg": mul_reg, "mov_reg": mov_reg, "mov_num_low": mov_num_low,
                           "mov_num_high": mov_num_high, "load_to_mem": load_to_mem}
    instructions_0_args = {"nop": nop, "ch_mod": ch_mod, "ch_buf": ch_buf}
    self_instructions = {"add_i": add_i, "sub_i": sub_i, "je": je, "mov_num_i": mov_num_i}
    regs = {"reg0": Register16(0), "reg1": Register16(0), "reg2": Register16(0), "reg3": Register16(0),
                  "ip": Register16(0)}
    flags = {"work_flag": Register1(0), "carry_flag": Register1(0), "neg_flag": Register1(0), "zero_flag": Register1(0)}

    def __init__(self, program_file: str, sm: SM):
        self.ROM_SIZE = 65536
        program = self.read_program_from_file(program_file)
        self.__ROM = ROM(self.ROM_SIZE, program)
        self.__cores = sm.cores

    def execute(self, instruction):
        if instruction[3] in self.self_instructions:
            if instruction[3] == "nop":
                self.flags["work_flag"].write(0)
            else:
                # if instruction is mov_num_i (instruction[2] is num)
                if instruction[2] not in self.regs:
                    instruction[0](self.regs[instruction[1]], instruction[2], self.flags)
                else:
                    instruction[0](self.regs[instruction[1]], self.regs[instruction[2]], self.flags)
        else:
            for core in self.__cores:
                core.execute(instruction[0], instruction[1], instruction[2])

    def fetch_instruction(self):
        instruction = self.__ROM.read(self.regs["ip"].read())
        self.regs["ip"].inc()
        return instruction

    def change_ip(self, address):
        self.regs["ip"].write(address)
        self.flags["work"].write(1)

    def read_program_from_file(self, program_file: str):
        res = []
        with open(program_file, "r") as prg:
            for idx, line in enumerate(prg):
                parsed = line.strip().split(" ")
                if len(parsed) != 3:
                    typ = parsed[0].lower()
                    if len(parsed) == 1:
                        if typ == "ch_mod":
                            res.append([self.instructions_0_args[typ], "mode_flag", "mode_flag", parsed[0]])
                        elif typ == "ch_buf":
                            res.append([self.instructions_0_args[typ], "buffer_flag", "buffer_flag", parsed[0]])
                        else:
                            res.append([self.instructions_0_args[typ], "", "", parsed[0]])
                    else:
                        raise AssertionError(f"line: {idx+1}. Bad number of arguments!")

                elif parsed[0] in self.instructions_2_args:
                    res.append([self.instructions_2_args[parsed[0].lower()], parsed[1], parsed[2], parsed[0]])
                elif parsed[0] in self.self_instructions:
                    res.append([self.self_instructions[parsed[0].lower()], parsed[1], parsed[2], parsed[0]])
                else:
                    raise KeyError(f"line: {idx+1}. Unknown instruction {parsed[0]}")

        return res

class Z80:
    def __init__(self):
        pass

