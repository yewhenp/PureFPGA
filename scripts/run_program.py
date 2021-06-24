# first argument - program 
# second - number of cores 
# fourth - ram file
# third - measure time or not

clear_finish_interrupt = "memtool -8 0xFF200001=0x0 > tmp"
start = "memtool -8 0xFF200000=0x1 > tmp"
assembling_script = "python2 assembler/pure_assembler.py -ap -v -o tmp.out -s {}"
RAM = "0xC0000000"
ROM = "0xC0040000"

import sys
import subprocess
import time


def videocard_finished():
    output = subprocess.check_output("memtool -8 0xFF200001 1", shell=True)
    for i in range(len(output)):
        if output[i] == ":":
            k = i
            while output[k] != "0":
                k += 1
            if output[k+1] == "1":
                return 0
            else:
                return -2
    return -2



if __name__ == '__main__':
    if len(sys.argv) != 5:
        print("USAGE: python run_program.txt ./path_to_mccp_file ./number_of_cores ./path_to_ram ./measure_time(1 if yes else 0)")
        sys.exit(1)

    program = sys.argv[1]
    cores = sys.argv[2]
    ram = sys.argv[3]
    measure = sys.argv[4] == '1'

   

    # 1. assemmble program
    print("Assembling...")
    subprocess.call(assembling_script.format(program), shell=True)

    # 2. fill ROM
    subprocess.call("./mem tmp.out {}".format(ROM), shell=True)
    subprocess.call("rm tmp.out a.prep", shell=True)
    

    # 3. filling memory
    subprocess.call("./mem {} {}".format(mem, RAM), shell=True)

    # setup cores
    subprocess.call("./scripts/activate_cores.sh {}".format(cores), shell=True)
    subprocess.call(clear_finish_interrupt, shell=True)
    subprocess.call(start, shell=True)

    if measure:
        start_ = time.time()
        while videocard_finished() != 0:
            pass
        end = time.time()
        print("Time elapsed: {}s".format(end - start_))
    
    print("Done")
