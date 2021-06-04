#include "utility.h"


int main(int argc, char **argv) {
    if(argc < 2){
        printf("ERROR: invalid number of arguments");
        exit(1);
    }
    int fd;
    size_t offset = strtol(argv[1], NULL, 16) - FPGA_ONCHIP_BASE;
    if(offset < 0 || offset > FPGA_ONCHIP_SPAN){
        printf("ERROR: invalid address");
        exit(1);
    }
    int print = strtol(argv[2], NULL, 10);
    uint32_t* onchip_ptr = (uint32_t*)((uint8_t*)(connect(&fd)) + offset);
    print_memory(onchip_ptr, (print <= 0) ? 0 : print);
    close(fd);
    return 0;
}

