import serial
import sys
import os


def main():
    if len(sys.argv) == 2:
        tty = "/dev/ttyUSB0"
        f = sys.argv[1]

    elif len(sys.argv) == 3:
        tty = sys.argv[1]
        f = sys.argv[2]

    else:
        print ("USAGE: python" + sys.argv[0] + "<port> <file_to_send>")
        return 1

    os.system("base64 " + f + " > decoded")
    s = serial.Serial(tty, 115200)
    s.write(open("decoded", "r").read().encode("ascii"))
    os.system("rm decoded")
    return 0


if __name__ == '__main__':
    sys.exit(main())
