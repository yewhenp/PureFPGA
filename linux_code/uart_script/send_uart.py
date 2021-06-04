from serial import Serial
import sys
import os

if len(sys.argv) != 3:
    print ("USAGE: python" + sys.argv[0] + "<port> <file_to_send>")
    exit()

tty = sys.argv[1]
f = sys.argv[2]

os.system("base64 " + f + " > decoded")
s = Serial(tty, 115200)
s.write(open("decoded", "r").read().encode("ascii"))
os.system("rm decoded")
