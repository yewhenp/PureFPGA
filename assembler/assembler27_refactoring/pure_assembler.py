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
    parser.add_argument('-v', help='Vebose', action='store_const', const=True,
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


    # if len(sys.argv) == 2:
    #     source = sys.argv[1]
    #     prep = "a.prep"
    #     dest = "a.out"
    #     assembler = Assembler(source_file=source, prep_file=prep, dest_file=dest)
    #     assembler.preprocess_source(PREPROCESS_VERBOSE)
    #     assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
    # elif len(sys.argv) == 4:
    #     # assemblng
    #     if sys.argv[2] == "a":
    #         prep = sys.argv[1]
    #         dest = sys.argv[3]
    #         assembler = Assembler(source_file="", prep_file=prep, dest_file=dest)
    #         assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
    #     # preprocessing
    #     elif sys.argv[2] == "p":
    #         source = sys.argv[1]
    #         prep = sys.argv[3]
    #         assembler = Assembler(source_file=source,prep_file=prep, dest_file="")
    #         assembler.preprocess_source(PREPROCESS_VERBOSE)
    #     elif sys.argv[2] == "ap":
    #         source = sys.argv[1]
    #         prep = "a.prep"
    #         dest = sys.argv[3]
    #         assembler = Assembler(source_file=source, prep_file=prep, dest_file=dest)
    #         assembler.preprocess_source(PREPROCESS_VERBOSE)
    #         assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
    #     else:
    #         raise AttributeError("Bad options!")
    # else:
    #     raise AttributeError("Bad options!")
