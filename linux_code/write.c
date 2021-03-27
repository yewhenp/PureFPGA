#include "utility.h"

int main(int argc, char **argv) {
    if(argc < 2){
        printf("ERROR: invalid number of arguments");
        exit(1);
    }
    int fd;
    char * filename = argv[1];
    size_t offset = atoi(argv[2]);
    int print = atoi(argv[3]);
    uint32_t* onchip_ptr = (uint32_t*)(connect(&fd));
    onchip_ptr += offset;
    array32_t array = read_file_to_array(filename);
    write_array_to_memory(&array, onchip_ptr);
    print_memory(onchip_ptr, (print < 0) ? array.size : MIN(array.size, print));
    destruct(&array);
    close(fd);
    return 0;
}

