from mem_modules import RAM, Buffer, Register16, Register1
from instructions import *


class Core:
    def __init__(self):
        self.ram = RAM(2**16)
        self.buffers = [Buffer(2**14), Buffer(2**14)]
        self.registers = [Register16(), Register16(), Register16(), Register16()]
        self.buffer_register = Register1()
        self.buffer_use = Register1()

    def write_data(self, address, data):
        self.ram.write(address, data)

    def read_data(self, address):
        return self.ram.read(address)

    def execute(self, function, source_0, source_1):
        if function == load_to_mem:
            function(self._read_source(source_0), self._read_source(source_1), self._get_ram())
            if self._get_buffer_use():
                function(self._read_source(source_0), self._read_source(source_1), self._get_buffer())
        else:
            function(self._read_source(source_0), self._read_source(source_1))

    def _get_register(self, number):
        return self.registers[number]

    def _read_source(self, source):
        if "reg" in source:
            return self._get_register(int(source[-1]))
        return source

    def _get_buffer_register(self):
        return self.buffer_register

    def _get_buffer(self):
        return self.buffers[self._get_buffer_register().read()]

    def _get_buffer_use_register(self):
        return self.buffer_use

    def _get_buffer_use(self):
        return self._get_buffer_use_register().read()

    def _get_ram(self):
        return self.ram


class SM:
    def __init__(self, core_num):
        self.core_num = core_num
        self.cores = []
        for _ in range(core_num):
            self.cores.append(Core())

    def get_core(self, number):
        if number >= self.core_num:
            raise IndexError("No core with that index")
        return self.cores[number]


class MemoryManager:
    def __init__(self):
        self.sm = SM(64)

    def write_data(self, address, data):
        core = address - (self.sm.core_num * (address // self.sm.core_num))
        self.sm.get_core(core).write_data(address // self.sm.core_num, data)

    def read_data(self, address):
        core = address - (self.sm.core_num * (address // self.sm.core_num))
        return self.sm.get_core(core).read_data(address // self.sm.core_num)
