from argparse import ArgumentParser
import subprocess
import sys


if __name__ == '__main__':
    parser = ArgumentParser("generate testbench and modelsim scripts from .mccp file")
    parser.add_argument("-p", "--program", help="path to .mccp file", required=True, type=str)
    # parser.add_argument("-s", "--sim", help="path sim folder", required=True, type=str)
    parser.add_argument("-v", "--verbose", help="verbose", action="store_const", const=True, required=False)
    args = parser.parse_args()

    # 1. assemmble program
    assembling_script = "python2 assembler/assembler27/pure_assembler.py -s {} -ap -o tmp.out"
    if args.verbose:
        assembling_script += " -v"
        print("Assembling...")
    subprocess.call(assembling_script.format(args.program), shell=True)

    # 2. generate testbench
    if args.verbose:
        print("generating testbech...")
    name = args.program.split("/")[-1].split(".")[0]
    tb_name = name + "_tb"
    tb_gen_script = "python3 scripts/generate_testbench.py --binary tmp.out --out {}.v"
    subprocess.call(tb_gen_script.format(tb_name), shell=True)
    subprocess.call("mv {}.v MCCP/test_benches".format(tb_name), shell=True)

    # 3. generate modelsim scripts
    if args.verbose:
        print("Creating modelsim scripts...")
    with open("MCCP/sims/stack_sim.do", 'r') as stack_sim_do_file:
        sim_do_script = stack_sim_do_file.read()
    sim_do_script = sim_do_script.replace("stack", name)
    with open("MCCP/sims/{}_sim.do".format(name), 'w') as sim_do_file:
        sim_do_file.write(sim_do_script)

    with open("MCCP/sims/stack_wave.do", 'r') as stack_wave_do_file:
        wave_do_script = stack_wave_do_file.read()
    wave_do_script = wave_do_script.replace("stack", name)
    with open("MCCP/sims/{}_wave.do".format(name), 'w') as wave_do_file:
        wave_do_file.write(wave_do_script)

    # 4. cleaning up
    if args.verbose:
        print("Cleaning up tmp files")
    subprocess.call("rm a.prep tmp.out", shell=True)
