from core_modules import *
from mem_modules import *
from instruction_modules import *


class VideoCard:
    def __init__(self, program_file, number_of_cores):
        self.__memory_manager = MemoryManager(number_of_cores)
        self.__sm = self.__memory_manager.get_sm()
        self.__inst_processor = InstructionProc(program_file, self.__sm)


    def CPU_read(self, address):
        if not self.__inst_processor.flags["work_flag"]:
            return self.__memory_manager.read_data(address)

    def CPU_write(self, address, data):
        if not self.__inst_processor.flags["work_flag"]:
            self.__memory_manager.write_data(address, data)

    def call_shaders(self, arg0, arg1, arg2, arg3, ip):
        pass

    def execute_next_instruction(self):
        pass

    def execute_instructions(self, num):
        pass

    def toString(self):
        pass

