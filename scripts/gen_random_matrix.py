from random import randint
import sys


if __name__ == '__main__':
    res = "5 10005 100 20005 100"
    if len(sys.argv) == 1:
        h, w = 100, 100
    else:
        h, w = int(sys.argv[1]), int(sys.argv[2])
    for k in range(2):
        for i in range(h):
            for j in range(w):
                res += " " + str(randint(1, 10))
    with open("matrices.txt", 'w') as result_file:
        result_file.write(res)
