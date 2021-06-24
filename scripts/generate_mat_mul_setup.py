import sys


template = "address <= {};\ndata_in <= {};\n#40"
import numpy as np
def main(m, k, n):
    if len(sys.argv) == 5:

        out_filename = sys.argv[4]
        with open(out_filename, 'w') as out_file:
            ARGS_OFFSET = 6
            def write(value):
                output.append(template.format(len(output), value))
            
            out_file.write(str(ARGS_OFFSET) + " ")
            out_file.write(str(ARGS_OFFSET + m * k) + " ")
            out_file.write(str(k) + " ")
            out_file.write(str(ARGS_OFFSET + m * k + k * n) + " ")
            out_file.write(str(n) + " ")
            out_file.write(str(m) + " ")
            for i in range(1, m * k + 1):
                out_file.write(str(i) + " ")
            for i in np.arange(1, n * k + 1).reshape((k, n)).T.flatten():
                out_file.write(str(i) + " ")
            return "done"
    else:

        output = []
        ARGS_OFFSET = 6
        def write(value):
            output.append(template.format(len(output), value))
        
        write(ARGS_OFFSET)
        write(ARGS_OFFSET + m * k)
        write(k)
        write(ARGS_OFFSET + m * k + k * n)
        write(n)
        write(m)
        for i in range(1, m * k + 1):
            write(i)
        print(np.arange(1, n * k + 1).reshape((k, n)).T.flatten())
        for i in np.arange(1, n * k + 1).reshape((k, n)).T.flatten():
            write(i)
        return "\n".join(output)
    


if __name__ == "__main__":
    print(main(int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])))