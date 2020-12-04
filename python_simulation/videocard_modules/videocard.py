from python_simulation.videocard_modules.core_modules import *


class VideoCard:
    def __init__(self, program_file, number_of_cores):
        self.__memory_manager = MemoryManager(program_file, number_of_cores)
        self.__sm = self.__memory_manager.get_sm()
        self.__inst_processor = self.__memory_manager.get_instruction_processor()

    def get_inst_processor(self):
        return self.__inst_processor

    def get_memory_manager(self):
        return self.__memory_manager

    def CPU_read(self, address):
        return self.__memory_manager.read_data(address)

    def CPU_write(self, address, data):
        self.__memory_manager.write_data(address, data)

    def call_shaders(self, arg0, arg1, arg2, arg3, ip):
        pass

    def execute_next_instruction(self, verbose=False):
        instruction = self.__inst_processor.fetch_instruction()
        if verbose:
            print(f"Current instruction: {instruction}")
        self.__inst_processor.execute(instruction)
        return instruction

    def execute_instructions(self, num):
        for i in range(num):
            self.execute_next_instruction()

    def parse_VM(self, file):
        with open(file, "r") as mem_file:
            address = 0
            for line in mem_file:
                line = line.strip()
                try:
                    num = int(line)
                except ValueError:
                    continue
                self.CPU_write(address, num)
                address += 1

    def to_string(self):
        res = ""
        res += "Instruction Processor: \n"
        res += self.__inst_processor.regs_to_string()
        res += '\n'
        res += self.__inst_processor.flags_to_string()
        res += '\n'
        # res += self.__inst_processor.ROM_to_string(10)
        # res += '\n'
        res += self.__memory_manager.get_sm().to_string(12, 4)
        return res


