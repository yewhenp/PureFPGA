# def get(n, i):
#     return "" if (n >> i) & 1 else "~"
# template = "assign eq63[{}] = {}data[5] & {}data[4] & {}data[3] & {}data[2] & {}data[1] & {}data[0];\n"
# with open("C:\FPGAProjects\ALU_plus_MM\decoder.txt", "w", encoding="utf-8") as f:
#     for i in range(64):
#         f.write(template.format(i, get(i, 5), get(i, 4), get(i, 3), get(i, 2), get(i, 1), get(i, 0)))
def get(n, i):
    return "" if (n >> i) & 1 else "~"
template = "assign eq7[{}] = {}data[2] & {}data[1] & {}data[0];\n"
with open("C:\FPGAProjects\ALU_plus_MM\decode8r.txt", "w", encoding="utf-8") as f:
    for i in range(8):
        f.write(template.format(i, get(i, 2), get(i, 1), get(i, 0)))