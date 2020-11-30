from python_simulation.videocard import VideoCard

if __name__ == '__main__':
    videocard = VideoCard("tmp_program", number_of_cores=4)
    videocard.parse_VM("tmp_memory")
    videocard.get_inst_processor().change_ip(0)
    print(f"VM: {videocard.get_memory_manager().scan(4).to_string(16)}")

    for i in range(7):
        instruction = videocard.execute_next_instruction()
        print(f"Current instruction: {instruction[3]} {instruction[1]} {instruction[2]}\n")
        print(f"{videocard.to_string()}\n")
        input(">>> ")
        print('\033c')
        print('\x1bc')

    print(f"VM: {videocard.get_memory_manager().scan(4).to_string(16)}")


