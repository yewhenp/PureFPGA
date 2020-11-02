from instruction_modules import *
from core_modules import *
from pprint import pprint


if __name__ == '__main__':
    mem_man = MemoryManager()
    sm = mem_man.get_sm()
    instr = InstructionProc("tmp_program", sm)
    core = sm.get_core(0)
    # pprint(instr.)


    for i in range(7):
        instruction = instr.fetch_instruction()
        instr.execute(instruction)

        print(f"reg1 = {core.registers['reg1'].read()}  reg2 = {core.registers['reg2'].read()} ")






    core = Core()


