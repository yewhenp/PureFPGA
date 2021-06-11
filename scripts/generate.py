if __name__ == '__main__':
    with open("data.txt", 'w') as out_file:
        res = ""
        for _ in range(10000):
            res += "255 "
        out_file.write(res)
        print("done")
