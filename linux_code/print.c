#include "utility.h"


int main(int argc, char **argv) {
    if(argc < 2){
        printf("ERROR: invalid number of arguments");
        exit(1);
    }
    int fd;
    size_t offset = atoi(argv[1]);
    int print = atoi(argv[2]);
    uint32_t* onchip_ptr = (uint32_t*)(connect(&fd)) + offset;
    print_memory(onchip_ptr, (print <= 0) ? 0 : print);
    close(fd);
    return 0;
}

