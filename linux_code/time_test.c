#include "utility.h"
#include <stdlib.h>


int main(int argc, char **argv) {
    if(argc < 2){
        printf("ERROR: invalid number of arguments");
        exit(1);
    }
    char write_call[100];
    sprintf(write_call, "memtool %s %s", argv[1], argv[2]);
    printf("%s", write_call);
    int status = system(write_call);
    printf("%d", status);
    return 0;


//    int fd;
//    char * filename = argv[1];
//    size_t offset = atoi(argv[2]);
//    uint32_t* onchip_ptr = (uint32_t*)(connect(&fd));
//    onchip_ptr += offset;
//    array32_t array = read_file_to_array(filename);
//    write_array_to_memory(&array, onchip_ptr);
//    destruct(&array);
//    close(fd);


//    return 0;
}

