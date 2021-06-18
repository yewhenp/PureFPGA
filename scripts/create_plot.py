import matplotlib.pyplot as plt

if __name__ == '__main__':
    with open("time.txt", 'r') as file:
        time = file.read().split(" ")
        time = list(map(lambda x: float(x), time))

    with open("config.txt", 'r') as file:
        x = file.read().split(" ")
        x = list(map(lambda k: float(k), x))

    plt.figure()
    # time = time[::-1]
    time_theoretical = [time[0]]
    # for k in range(len(time)-1, 0, -1):
    #     time_theoretical.append(time_theoretical[-1] * (x[k-1] / x[k]) ** 3)
    for k in range(1, len(time)):
        time_theoretical.append(time_theoretical[-1] * (x[k] / x[k-1]) ** 3)
    # x = x[::-1]

    print(time)
    print(time_theoretical)

    plt.plot(x, time, linewidth=4)
    plt.plot(x, time_theoretical, '--', linewidth=4)
    # plt.legend()
    plt.title("Matrix multiplication")
    plt.xlabel("size of matrix")
    plt.ylabel("Time (s)")
    plt.savefig("plot.png")
