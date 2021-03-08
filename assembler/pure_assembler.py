import sys
from src.AssemblerClass import Assembler


if __name__ == '__main__':
    PREPROCESS_VEBOSE = True
    ASSEMBLE_VERBOSE = True
    if len(sys.argv) == 2:
        source = sys.argv[1]
        prep = "a.prep"
        dest = "a.out"
        assembler = Assembler(source_file=source, prep_file=prep, dest_file=dest)
        assembler.preprocess_source(PREPROCESS_VEBOSE)
        assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
    elif len(sys.argv) == 4:
        # assemblng
        if sys.argv[2] == "a":
            prep = sys.argv[1]
            dest = sys.argv[3]
            assembler = Assembler(source_file="", prep_file=prep, dest_file=dest)
            assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
        # preprocessing
        elif sys.argv[2] == "p":
            source = sys.argv[1]
            prep = sys.argv[3]
            assembler = Assembler(source_file=source,prep_file=prep, dest_file="")
            assembler.preprocess_source(PREPROCESS_VEBOSE)
        elif sys.argv[2] == "ap":
            source = sys.argv[1]
            prep = "a.prep"
            dest = sys.argv[3]
            assembler = Assembler(source_file=source, prep_file=prep, dest_file=dest)
            assembler.preprocess_source(PREPROCESS_VEBOSE)
            assembler.assemble_preprocessed(ASSEMBLE_VERBOSE)
        # binary assembling
        elif sys.argv[2] == "ab":
            prep = sys.argv[1]
            dest = sys.argv[3]
            assembler = Assembler(source_file="", prep_file=prep, dest_file=dest)
            assembler.assemble_preprocessed(ASSEMBLE_VERBOSE, mode="bin")
        else:
            raise AttributeError("Bad options!")
    else:
        raise AttributeError("Bad options!")
