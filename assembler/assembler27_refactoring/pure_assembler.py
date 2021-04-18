import sys
from src.AssemblerClass import Assembler
from argparse import ArgumentParser


if __name__ == '__main__':
    parser = ArgumentParser(description='MCCP assembler')
    parser.add_argument('-s', help='Source file', type=str, required=True)
    parser.add_argument('-o', help='Output file', type=str, required=False)
    parser.add_argument('-ap', help='Preprocess source then assemble', action='store_const', const=True,
                        default=False, required=False)
    parser.add_argument('-a', help='Assemble preprocessed', action='store_const', const=True,
                        default=False, required=False)
    parser.add_argument('-p', help='Preprocess source', action='store_const', const=True,
                        default=False, required=False)
    parser.add_argument('-v', help='Verbose', action='store_const', const=True,
                        default=False, required=False)

    args = parser.parse_args()
    PREPROCESS_VERBOSE = args.v
    ASSEMBLE_VERBOSE = args.v

    if args.ap:
        output = "a.out" if args.o is None else args.o
        source = args.s
        assembler = Assembler(source_file=source, prep_file="a.prep", dest_file=output)
        assembler.preprocess_source(PREPROCESS_VERBOSE)
        assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)

    elif args.p:
        source = args.s
        output = "a.prep" if args.o is None else args.o
        assembler = Assembler(source_file=source, prep_file=output, dest_file="")
        assembler.preprocess_source(PREPROCESS_VERBOSE)

    elif args.a:
        prep = args.s
        output = "a.out" if args.o is None else args.o
        assembler = Assembler(source_file="undefined", prep_file=prep, dest_file=output)
        assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
    else:
        raise AttributeError("Specify -ap or -a or -p")