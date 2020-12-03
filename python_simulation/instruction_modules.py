from python_simulation.mem_modules import *
from python_simulation.instructions import *
from python_simulation.disassembler import Disassembler
# from core_modules import SM


class InstructionProc:
    # size of ROM: 2**16-1
    MEM_SIZE = 65535
    disassembler = Disassembler()

    # [carry_flag, sign_flag, overflowe_flag, zero_flag]
    # those dictionaries represent instruction processor registers and flags
    regs = {"reg0": Register16(0), "reg1": Register16(0), "reg2": Register16(0), "reg3": Register16(0),
            "reg4": Register16(0), "reg5": Register16(0), "reg6": Register16(0), "reg7": Register16(0),
            "flags": Register16(0)}

    suffixes_condition = {
        "eq": lambda: get_bit(InstructionProc.regs["flags"], ZERO) == 1,
        "ne": lambda: get_bit(InstructionProc.regs["flags"], ZERO) == 0,
        "gt": lambda: get_bit(InstructionProc.regs["flags"], ZERO) == 0 and  get_bit(InstructionProc.regs["flags"], SIGN) ==  get_bit(InstructionProc.regs["flags"], OVERFLOW),
        "lt": lambda: get_bit(InstructionProc.regs["flags"], SIGN) != get_bit(InstructionProc.regs["flags"], OVERFLOW),
        "ge": lambda: get_bit(InstructionProc.regs["flags"], SIGN) == get_bit(InstructionProc.regs["flags"], OVERFLOW),
        "le": lambda: get_bit(InstructionProc.regs["flags"], ZERO) == 1 or  get_bit(InstructionProc.regs["flags"], SIGN) !=  get_bit(InstructionProc.regs["flags"], OVERFLOW),
        "cs": lambda: get_bit(InstructionProc.regs["flags"], CARRY) == 1,
        "cc": lambda: get_bit(InstructionProc.regs["flags"], CARRY) == 0,
        "mi": lambda: get_bit(InstructionProc.regs["flags"], SIGN) == 1,
        "pl": lambda: get_bit(InstructionProc.regs["flags"], SIGN) == 0,
        "al": lambda: True,
        "nv": lambda : False,
        "vs": lambda: get_bit(InstructionProc.regs["flags"], OVERFLOW) == 1,
        "vc": lambda: get_bit(InstructionProc.regs["flags"], OVERFLOW) == 0,
        "hi": lambda: get_bit(InstructionProc.regs["flags"], CARRY) == 1 and get_bit(InstructionProc.regs["flags"], SIGN) == 0,
        "ls": lambda: get_bit(InstructionProc.regs["flags"], CARRY) == 0 or get_bit(InstructionProc.regs["flags"], SIGN) == 0,
        None: lambda: True
    }

    def __init__(self, program_file: str, sm) -> None:
        # parse program from file
        program = self.load_program_from_file(program_file)
        # create ROM with given program and RAM
        self.__ROM = ROM(self.MEM_SIZE, program)
        self.__RAM = RAM(self.MEM_SIZE)
        # cores are taken from SM
        self.__cores = sm.cores

        # aliases
        self.regs["ip"] = self.regs["reg6"]
        self.regs["sp"] = self.regs["reg7"]

    def execute(self, i: dict) -> None:
        """
        Executes given parsed instruction
        :param i: format of instruction: [instruction, "arg1", "arg2", "instruction"]
            if instruction is nop, then arg1=arg2=""
            if instruction is ch_mod, then arg1=arg2="mode_flag"
            if instruction is ch_buf, then arg1=arh2="buffer_flag"
            else arg1="reg0-3", arg2="arg0-3/8-bit number"
        :return: None
        """
        # execute instruction for instruction processor
        if i["recipient"] == "proc":
            if self.suffixes_condition["suf"]:
                if i["type"] == "proc_mem_number" or i["type"] == "proc_mem_flags" or i["func"] == movi_:
                    i["func"](self.regs[i["dest"]], self.regs[i["op1"]],  self.regs["flags"])
                elif i["type"] == "proc_mem_suffix":
                    i["func"](self.regs[i["dest"]], self.regs[i["op1"]], self.__RAM, self.regs["flags"])
                elif i["type"] == "jumps":
                    i["func"](self.regs["ip"], self.regs[i["dest"]], self.regs["flags"])
        else:
            for core in self.__cores:
                core.execute(i["func"], i["dest"], i["op1"], i["op2"], i["suf"])

    def fetch_instruction(self) -> dict:
        """fetches instruction from ROM, increases IP and returns instruction"""
        instruction = self.__ROM.read(self.regs["ip"].read())
        self.regs["ip"].inc()
        return self.disassembler.decode_instruction(instruction)

    def change_ip(self, address: int) -> None:
        """If IP is changed by CPU"""
        self.regs["ip"].write(address)

    def load_program_from_file(self, program_file: str) -> list:
        """
        Parses program from file and returns list of parsed instructions
        :param program_file: string - path to file with program written on assembler
        :return:
        """
        res = []
        with open(program_file, "r") as prg:
            for line in prg:
                line = line.strip()
                res.append(line)
        return res

    def regs_to_string(self):
        r = self.regs
        return f"   reg0: {r['reg0'].to_string()}, reg1: {r['reg1'].to_string()}, reg2: {r['reg2'].to_string()}, reg3: {r['reg3'].to_string()}" \
               f"   reg4: {r['reg4'].to_string()}, reg5: {r['reg5'].to_string()}, IP: {r['ip'].to_string()}, sp: {r['sp'].to_string()}"

    def flags_to_string(self):
        v = self.regs["flags"].read()
        return f"    carry_flag: {get_bit(v, CARRY)}, sign_flag: {get_bit(v, SIGN)}, overflow_flag: {get_bit(v, OVERFLOW)}, zero_flag: {get_bit(v, ZERO)}"

    def ROM_to_string(self, size, mode=""):
        return self.__ROM.to_string(size, mode)
