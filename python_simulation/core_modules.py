from ../Memory import RAM, Buffer

class Core:
    def init(self):
        self.ram = RAM()
        self.buffer_0 = Buffer()
        self.buffer_1 = Buffer()
        self.registers = [0, 0, 0, 0]

    def write_data(self, address, data):
        self.ram.write(address, data)

    def read_data(self, address):
        return self.ram.read(address)

    def execute(self, function, source_0, source_1, destination):
        if destination.type == "ram":
            self.ram.write(destination, function(self.ram.read(source_0), self.ram.read(source_1)))

    def _write_registet(self, number, data):
        self.registers[number] = data

    def _read_registers(self, number):
        return self.registers[number]

    def _read_source(self, source):
        if source["type"] == "ram":
            return self.read_data(source["address"])
        return self._read_registers(source["address"])

    def _write_destination(self, destination, data):
        pass


class SM:
    def init(self, core_num):
        self.core_num = core_num
        self.cores = []
        for _ in range(core_num):
            self.cores.append(Core())


class MemoryManager:
    def init(self):
        pass