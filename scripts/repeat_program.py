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
    clear_interrupt = "memtool -8 0xFF200001=0x0 > tmp"
    start = "memtool -8 0xFF200000=0x1 > tmp"

    prg = sys.argv[1]
    cores = sys.argv[2]
    times = 500

    # # filling memory
    # if len(sys.argv) == 4:
    #     mem = sys.argv[3]
    #     subprocess.call("./mem {} 0xC0000000".format(mem), shell=True)
    # else:
    #     print("Warning: didn't fill memory")
    # # compile
    # subprocess.call("python2 assembler/pure_assembler.py -s assembler/programs/{}.mccp -ap -v -o {}.out > disassemble".format(prg, prg), shell=True)
    #
    # # fill ROM
    # subprocess.call("./mem {}.out 0xC0040000".format(prg), shell=True)

    # setup cores
    subprocess.call("./scripts/activate_cores.sh {}".format(cores), shell=True)
    subprocess.call(clear_interrupt, shell=True)
    subprocess.call("memtool -8 0xFF200000 8", shell=True)
    subprocess.call(start, shell=True)

    counter = 0
    start_ = time.time()
    while counter < times:
        while videocard_finished() != 0:
            pass
        subprocess.call(clear_interrupt, shell=True)
        subprocess.call(start, shell=True)
        counter += 1
    end = time.time()
    print("Time elapsed: {}s".format(end - start_))
