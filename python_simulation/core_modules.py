from mem_modules import RAM, Buffer

class Core:
    def __init__(self):
        self.ram = RAM(2**16)
        self.buffer_0 = Buffer()
        self.buffer_1 = Buffer()
        self.registers = [Register(), Register(), Register(), Register()]
        self.buffer_register = 0

    def write_data(self, address, data):
        self.ram.write(address, data)

    def read_data(self, address):
        return self.ram.read(address)

    def execute(self, function, source_0, source_1):
        function(source_0, source_1)

    def _write_register(self, number, data):
        self.registers[number].value = data

    def _get_register(self, number):
        return self.registers[number]

    # def _read_register(self, number):
    #     return self.registers[number].value
    #
    def _read_source(self, source):
        if "reg" in source:
            return self._get_register(int(source[-1]))
        return self.read_data(int(source))
    #
    # def _write_destination(self, destination, data):
    #     if "reg" in destination:
    #         return self._write_register(int(destination[-1]), data)
    #     return self.write_data(int(destination), data)


class Register:
    def __init__(self):
        self.value = 0


class SM:
    def __init__(self, core_num):
        self.core_num = core_num
        self.cores = []
        for _ in range(core_num):
            self.cores.append(Core())


class MemoryManager:
    def __init__(self):
        self.sm = SM(64)

    def write_data(self, address, data):
        core = address - (self.sm.core_num * (address // self.sm.core_num))
        self.sm.cores[core].write_data(address // self.sm.core_num, data)

    def read_data(self, address):
        core = address - (self.sm.core_num * (address // self.sm.core_num))
        return self.sm.cores[core].read_data(address // self.sm.core_num)