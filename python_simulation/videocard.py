from core_modules import *
from mem_modules import *
from instruction_modules import *


class VideoCard:
    def __init__(self):
        self.__memory_manager = MemoryManager()
        self.__inst_processor = InstructionProc()

    def CPU_read(self, address):
        if self.__inst_processor.flags["work_flag"]:
            self.__memory_manager.read_data(address)

    def CPU_write(self, address):
        self.__memory_manager.write_data()