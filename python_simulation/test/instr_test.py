from python_simulation.videocard_modules.videocard import VideoCard

if __name__ == '__main__':
    videocard = VideoCard("python_simulation/test/filter_res", number_of_cores=4)
    videocard.parse_VM("python_simulation/test/tmp_memory")
    videocard.get_inst_processor().change_ip(0)
    print(f"VM: {videocard.get_memory_manager().scan(4).to_string(16)}")

    for i in range(100):
        instruction = videocard.execute_next_instruction(True)
        # print(f"Current instruction: {instruction}\n")
        print(f"{videocard.to_string()}\n")
        input(">>> ")
        print('\033c')
        print('\x1bc')

    print(f"VM: {videocard.get_memory_manager().scan(4).to_string(16)}")

