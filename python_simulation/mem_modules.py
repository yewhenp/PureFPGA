class Memory:
    def __init__(self, size: int) -> None:
        self.__size = size
        self.__container = [0 for _ in range(size)]

    def write(self, address, data):
        raise NotImplementedError

    def read(self, address):
        raise NotImplementedError


class ROM(Memory):
    def __init__(self, size: int, data: list[int]):
        super().__init__(size)
        for i in range(len(data)):
            self.__container[i] = data[i]

    def read(self, address: int):
        if self.__size < address:
            raise AttributeError
        return self.__container[address]

    def write(self, address, data):
        return 0


class RAM(ROM):
    def __init__(self, size: int, data: list[int]=[]):
        super().__init__(size, data)

    def write(self, address, data):
        if self.__size < address:
            raise AttributeError
        self.__container[address] = data


class Buffer(RAM):
    def __init__(self, size: int, data: list[int]):
        super().__init__(size, data)


class Register:
    def __init__(self):
        self.__value = 0

    def read(self):
        return self.__value

    def write(self, data):
        self.__value = data

    def inc(self):
        self.__value += 1