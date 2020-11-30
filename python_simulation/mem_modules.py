class Memory:
    def __init__(self, size: int) -> None:
        self.size = size
        self.container = [0 for _ in range(size)]

    def write(self, address, data):
        raise NotImplementedError

    def read(self, address):
        raise NotImplementedError

    def to_string(self, size=0, mod=""):
        if not size:
            size = self.size
        if mod == "hex":
            return str(map(hex, self.container[:size]))
        elif mod == "bin":
            return str(map(bin,self.container[:size]))
        return str(self.container[:size])


class ROM(Memory):
    def __init__(self, size: int, data: list):
        super().__init__(size)
        for i in range(len(data)):
            self.container[i] = data[i]

    def read(self, address: int):
        if self.size < address:
            raise AttributeError
        return self.container[address]

    def write(self, address, data):
        return 0


class RAM(ROM):
    def __init__(self, size: int, data: list=[]):
        super().__init__(size, data)

    def write(self, address, data):
        if self.size < address:
            raise AttributeError
        self.container[address] = data


class Buffer(RAM):
    def __init__(self, size: int, data: list=[]):
        super().__init__(size, data)


class Register:
    def __init__(self, size=16, val=0):
        self.__capacity = 2**size
        self.__size = size
        self.__value = val

    def read(self):
        return self.__value

    # returns true if overflow occured else false
    def write(self, data):
        self.__value = data % self.__capacity
        return data > self.__capacity

    # returns true if overflow occured else false
    def inc(self):
        self.__value = (self.__value + 1) % self.__capacity
        return self.__value == 0

    def get_capacity(self):
        return self.__capacity

    def to_string(self, mod=""):
        if mod == "hex":
            return str(hex(self.__value))
        elif mod == "bin":
            return str(bin(self.__value))
        return str(self.__value)

class Register16(Register):
    def __init__(self, val=0):
        super().__init__(16, val)

class Register1(Register):
    def __init__(self, val=0):
        super().__init__(1, val)