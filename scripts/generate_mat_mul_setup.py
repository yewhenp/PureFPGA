template = "address <= {};\ndata_in <= {};\n#40"
import numpy as np
def main(m, n, k):
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
    for i in np.arange(1, n * k + 1).reshape((k, n)).T.flatten():
        write(i)
    return "\n".join(output)
    


if __name__ == "__main__":
    print(main(2, 3, 2))