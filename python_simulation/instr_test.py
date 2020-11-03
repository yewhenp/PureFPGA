from videocard import VideoCard

if __name__ == '__main__':
    videocard = VideoCard("tmp_program", number_of_cores=4)

    for i in range(7):
        print(videocard.to_string())
        videocard.execute_next_instruction()


