from python_simulation.mem_modules import *
from python_simulation.instructions import *
# from core_modules import SM


class InstructionProc:
    # size of ROM: 2**16-1
    ROM_SIZE = 65535
    # those dictionaries are needed for instructions parsing - "instr": instr
    instructions_2_args = {"add_reg": add_reg, "sub_reg": sub_reg, "and_reg": and_reg, "or_reg": or_reg,
                           "xor_reg": xor_reg, "rshift_reg": rshift_reg, "lshift_reg": lshift_reg,
                           "mul_reg": mul_reg, "mov_reg": mov_reg, "mov_num_low": mov_num_low,
                           "mov_num_high": mov_num_high, "load_to_mem": load_to_mem, "load_from_mem": load_from_mem}
    instructions_0_args = {"nop": nop, "ch_mod": ch_mod, "ch_buf": ch_buf}
    self_instructions = {"add_i": add_i, "sub_i": sub_i, "je": je, "mov_num_i": mov_num_i}

    # those dictionaries represent instruction processor registers and flags
    regs = {"reg0": Register16(0), "reg1": Register16(0), "reg2": Register16(0), "reg3": Register16(0),
                  "ip": Register16(0)}
    flags = {"work_flag": Register1(0), "carry_flag": Register1(0), "neg_flag": Register1(0), "zero_flag": Register1(0)}

    def __init__(self, program_file: str, sm) -> None:
        # parse program from file
        program = self.read_program_from_file(program_file)
        # create ROM with given program
        self.__ROM = ROM(self.ROM_SIZE, program)
        # cores are taken from SM
        self.__cores = sm.cores

    def execute(self, instruction: list) -> None:
        """
        Executes given parsed instruction
        :param instruction: format of instruction: [instruction, "arg1", "arg2", "instruction"]
            if instruction is nop, then arg1=arg2=""
            if instruction is ch_mod, then arg1=arg2="mode_flag"
            if instruction is ch_buf, then arg1=arh2="buffer_flag"
            else arg1="reg0-3", arg2="arg0-3/8-bit number"
        :return: None
        """
        # execute instruction for instruction processor
        if not instruction:
            raise AttributeError("Empty instruction!")
        if instruction[3] in self.self_instructions:
            # if nop then videocard is not working, so set prop flag
            if instruction[3] == "nop":
                self.flags["work_flag"].write(0)
            else:
                # if instruction is mov_num_i (instruction[2] is num)
                if instruction[2] not in self.regs:
                    instruction[0](self.regs[instruction[1]], instruction[2], self.flags)
                # else execute normally
                else:
                    instruction[0](self.regs[instruction[1]], self.regs[instruction[2]], self.flags)
        # if instruction for cores, execute on cores
        else:
            for core in self.__cores:
                core.execute(instruction[0], instruction[1], instruction[2])


    def fetch_instruction(self) -> list:
        """fetches instruction from ROM, increases IP and returns instruction"""
        instruction = self.__ROM.read(self.regs["ip"].read())
        self.regs["ip"].inc()
        return instruction

    def change_ip(self, address: int) -> None:
        """If IP is changed by CPU"""
        self.regs["ip"].write(address)
        self.flags["work_flag"].write(1)

    def read_program_from_file(self, program_file: str) -> list:
        """
        Parses program from file and returns list of parsed instructions
        :param program_file: string - path to file with program written on assembler
        :return:
        """
        res = []
        with open(program_file, "r") as prg:
            for idx, line in enumerate(prg):
                line = line.strip()
                if line.startswith("//") or line == "":
                    continue
                parsed = line.split(" ")
                # if there are more or less then 3 arguments in line
                if len(parsed) != 3:
                    # name of instruction
                    typ = parsed[0].lower()
                    if len(parsed) == 1:
                        # special if for each instruction without arguments
                        if typ == "ch_mod":
                            res.append([self.instructions_0_args[typ], "mode_flag", "mode_flag", parsed[0]])
                        elif typ == "ch_buf":
                            res.append([self.instructions_0_args[typ], "buffer_flag", "buffer_flag", parsed[0]])
                        # else - this is nop
                        else:
                            res.append([self.instructions_0_args[typ], "", "", parsed[0]])
                    # There are only 2 argument and 0 argument instructions, so raise error
                    else:
                        raise AssertionError(f"line: {idx+1}. Bad number of arguments!")

                # special parse for instructions for cores
                elif parsed[0] in self.instructions_2_args:
                    res.append([self.instructions_2_args[parsed[0].lower()], parsed[1], parsed[2], parsed[0]])
                # instruction for instructio processor
                elif parsed[0] in self.self_instructions:
                    res.append([self.self_instructions[parsed[0].lower()], parsed[1], parsed[2], parsed[0]])
                else:
                    raise KeyError(f"line: {idx+1}. Unknown instruction {parsed[0]}")

        return res

    def regs_to_string(self):
        r = self.regs
        return f"    IP: {r['ip'].to_string()}, reg0: {r['reg0'].to_string()}, reg1: {r['reg1'].to_string()}, reg2: {r['reg2'].to_string()}, reg3: {r['reg3'].to_string()}"

    def flags_to_string(self):
        f = self.flags
        return f"    work_flag: {f['work_flag'].to_string()}, carry_flag: {f['carry_flag'].to_string()}, zero_flag: {f['zero_flag'].to_string()}, neg_flag: {f['neg_flag'].to_string()}"

    def ROM_to_string(self, size, mode=""):
        return self.__ROM.to_string(size, mode)
