from python_simulation.mem_modules import RAM, Buffer, Register16, Register1
from python_simulation.instructions import *
from python_simulation.instruction_modules import InstructionProc


class Core:
    def __init__(self):
        self.ram = RAM(2 ** 16)
        self.buffers = [Buffer(2 ** 14), Buffer(2 ** 14)]
        self.registers = {"reg0": Register16(),
                          "reg1": Register16(),
                          "reg2": Register16(),
                          "reg3": Register16(),
                          "flags": Register16()
                          }
        self.suffixes_condition = {
            "eq": lambda: get_bit(self.registers["flags"], ZERO) == 1,
            "ne": lambda: get_bit(self.registers["flags"], ZERO) == 0,
            "gt": lambda: get_bit(self.registers["flags"], ZERO) == 0 and get_bit(self.registers["flags"], SIGN) == get_bit(self.registers["flags"], OVERFLOW),
            "lt": lambda: get_bit(self.registers["flags"], SIGN) != get_bit(self.registers["flags"], OVERFLOW),
            "ge": lambda: get_bit(self.registers["flags"], SIGN) == get_bit(self.registers["flags"], OVERFLOW),
            "le": lambda: get_bit(self.registers["flags"], ZERO) == 1 or get_bit(self.registers["flags"], SIGN) != get_bit(self.registers["flags"], OVERFLOW),
            "cs": lambda: get_bit(self.registers["flags"], CARRY) == 1,
            "cc": lambda: get_bit(self.registers["flags"], CARRY) == 0,
            "mi": lambda: get_bit(self.registers["flags"], SIGN) == 1,
            "pl": lambda: get_bit(self.registers["flags"], SIGN) == 0,
            "al": lambda: True,
            "nv": lambda: False,
            "vs": lambda: get_bit(self.registers["flags"], OVERFLOW) == 1,
            "vc": lambda: get_bit(self.registers["flags"], OVERFLOW) == 0,
            "hi": lambda: get_bit(self.registers["flags"], CARRY) == 1 and get_bit(self.registers["flags"], SIGN) == 0,
            "ls": lambda: get_bit(self.registers["flags"], CARRY) == 0 or get_bit(self.registers["flags"], SIGN) == 0,
            None: lambda: True
        }

        # self.flags ={"buffer_flag": Register1(),
        #              "mode_flag": Register1(),
        #              "carry_flag": Register1()}


    def write_data(self, address, data):
        """
        Writes data to core memory
        :param address:
        :param data:
        :return:
        """
        self.ram.write(address, data)

    def read_data(self, address):
        """
        Reads data from core memory
        :param address:
        :return:
        """
        return self.ram.read(address)

    def execute(self, i):
        """
        Executes function
        :param function:
        :param op1:
        :param op2:
        :return:
        """
        if self.suffixes_condition[i["suf"]]:
            if i["type"] == "core_alu":
                i["func"](self.registers[i["op1"]], self.registers[i["op2"]], self.registers[i["dest"]], self.registers["flags"])
            elif i["type"] == "core_mem_suffix":
                i["func"](self.registers[i["dest"]], self.registers[i["op1"]], self.ram, self.registers["flags"])
            else:
                i["func"](self.registers[i["dest"]], self.registers[i["op1"]], self.registers["flags"])
        # if function == store_ or function == load_:
        #     function(self._read_source(op1), self._read_source(op2), self._get_ram(), self._get_flags())
        #     if self._get_buffer_use() and not function == load_:
        #         function(self._read_source(op1), self._read_source(op2), self._get_buffer(), self._get_flags())
        # else:
        #     function(self._read_source(op1), self._read_source(op2), self._get_flags())

    # def _read_source(self, source):
    #     """
    #     Checks source and returns register or number
    #     :param source:
    #     :return:
    #     """
    #     try:
    #         return self.registers[source]
    #     except KeyError:
    #         return source
    #
    # def _get_buffer_register(self):
    #     """
    #     Returns buffer flag register
    #     :return:
    #     """
    #     return self.flags["buffer_flag"]
    #
    # def _get_buffer(self):
    #     """
    #     Returns current buffer
    #     :return:
    #     """
    #     return self.buffers[self._get_buffer_register().read()]
    #
    # def _get_buffer_use_register(self):
    #     """
    #     Returns mode flag register
    #     :return:
    #     """
    #     return self.flags["mode_flag"]
    #
    # def _get_buffer_use(self):
    #     """
    #     Returns mode flag register value
    #     :return:
    #     """
    #     return self._get_buffer_use_register().read()
    #
    # def _get_ram(self):
    #     """
    #     Returns ram
    #     :return:
    #     """
    #     return self.ram
    #
    # def _get_carry(self):
    #     """
    #     Returns carry flag register
    #     :return:
    #     """
    #     return self.flags["carry_flag"]
    #
    # def _get_flags(self):
    #     """
    #     Returns flag register
    #     :return:
    #     """
    #     return self.flags

    def to_string(self, mem_size):
        """
        Prints core RAM and Registers
        :return:
        """
        str_to_return = ""
        str_to_return += f"\n\tRAM: {self.ram.to_string(mem_size)}"
        str_to_return += "\n\t" + " ".join(list(map(lambda x: "{}: {}".format(x[0], x[1].to_string()), self.flags.items())))
        str_to_return += "\n\tRegisters:"
        for reg in self.registers.keys():
            str_to_return += f" {reg}: {self.registers[reg].to_string()}"
        str_to_return += "\n"
        return str_to_return


class SM:
    def __init__(self, core_num):
        self.core_num = core_num
        self.cores = []
        for _ in range(core_num):
            self.cores.append(Core())

    def get_core(self, number):
        """
        Returns current core
        :param number:
        :return:
        """
        if number >= self.core_num:
            raise IndexError("No core with that index")
        return self.cores[number]

    def to_string(self,mem_size, num_cores):
        """
        Prints core
        :return:
        """
        str_to_return = "=" * (len(self.cores[0].to_string(mem_size)) // 3) + "\n"
        for i in range(num_cores):
            str_to_return += f"Core {i}: "
            str_to_return += self.cores[i].to_string(mem_size)
        str_to_return += "=" * (len(self.cores[0].to_string(mem_size)) // 3) + "\n"
        return str_to_return


class MemoryManager:
    def __init__(self, program_file, number_of_cores=64):
        self.number_of_cores = number_of_cores
        self.sm = SM(self.number_of_cores)
        self.instruction_processor = InstructionProc(program_file, self.sm)

    def write_data(self, address, data):
        """
        Writes data into core`s memory
        :param address:
        :param data:
        :return:
        """
        if address > 4194304:
            if address == 4194305:
                self.instruction_processor.change_ip(data)
            elif address == 4194306:
                self.instruction_processor.regs["reg0"].write(data)
            elif address == 4194307:
                self.instruction_processor.regs["reg1"].write(data)
            elif address == 4194308:
                self.instruction_processor.regs["reg2"].write(data)
            elif address == 4194309:
                self.instruction_processor.regs["reg3"].write(data)
            else:
                raise IndexError("Memory out of range")

        else:
            core = address - (self.sm.core_num * (address // self.sm.core_num))
            self.sm.get_core(core).write_data(address // self.sm.core_num, data)

    def read_data(self, address):
        """
        Reads data form core`s memory
        :param address:
        :return:
        """
        core = address - (self.sm.core_num * (address // self.sm.core_num))
        return self.sm.get_core(core).read_data(address // self.sm.core_num)

    def get_sm(self):
        """
        Returns SM
        :return:
        """
        return self.sm

    def get_instruction_processor(self):
        """
        Returns Instruction Processors
        :return:
        """
        return self.instruction_processor

    def scan(self, number_to_scan):
        """
        Returns virtual ram that CPU see
        :param number_to_scan:
        :return:
        """
        virtual_ram = RAM(number_to_scan * self.number_of_cores)
        for i in range(number_to_scan * self.number_of_cores):
            virtual_ram.write(i, self.read_data(i))
        return virtual_ram
