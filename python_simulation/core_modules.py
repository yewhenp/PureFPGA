from mem_modules import RAM, Buffer, Register16, Register1
from instructions import *


class Core:
    def __init__(self):
        self.ram = RAM(2 ** 16)
        self.buffers = [Buffer(2 ** 14), Buffer(2 ** 14)]
        self.registers = {"reg0": Register16(),
                          "reg1": Register16(),
                          "reg2": Register16(),
                          "reg3": Register16(),
                          "buffer_flag": Register1(),
                          "mode_flag": Register1(),
                          "carry_flag": Register1()
                          }

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

    def execute(self, function, source_0, source_1):
        """
        Executes function
        :param function:
        :param source_0:
        :param source_1:
        :return:
        """
        if function == load_to_mem:
            function(self._read_source(source_0), self._read_source(source_1), self._get_ram(), self._get_carry())
            if self._get_buffer_use():
                function(self._read_source(source_0), self._read_source(source_1), self._get_buffer(), self._get_carry())
        else:
            function(self._read_source(source_0), self._read_source(source_1), self._get_carry())

    def _read_source(self, source):
        """
        Checks source and returns register or number
        :param source:
        :return:
        """
        try:
            return self.registers.get(source)
        except KeyError:
            return source

    def _get_buffer_register(self):
        """
        Returns buffer flag register
        :return:
        """
        return self.registers["buffer_flag"]

    def _get_buffer(self):
        """
        Returns current buffer
        :return:
        """
        return self.buffers[self._get_buffer_register().read()]

    def _get_buffer_use_register(self):
        """
        Returns mode flag register
        :return:
        """
        return self.registers["mode_flag"]

    def _get_buffer_use(self):
        """
        Returns mode flag register value
        :return:
        """
        return self._get_buffer_use_register().read()

    def _get_ram(self):
        """
        Returns ram
        :return:
        """
        return self.ram

    def _get_carry(self):
        """
        Returns carry flag register
        :return:
        """
        return self.registers["carry_flag"]


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


class MemoryManager:
    def __init__(self):
        self.sm = SM(64)

    def write_data(self, address, data):
        """
        Writes data into core`s memory
        :param address:
        :param data:
        :return:
        """
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
