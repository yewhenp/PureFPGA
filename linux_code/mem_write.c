#include "utility.h"
#include <stdlib.h>


int main(int argc, char **argv) {
    if(argc < 2){
        printf("ERROR: invalid number of arguments");
        exit(1);
    }
    char * filename = argv[1];
    char memtool_call_buffer[100];
    array32_t array = read_file_to_array(filename);

    int program_counter = 0xC0000000 + 196608;
    for (int i = 0; i < array.size; ++i) {
        sprintf(memtool_call_buffer, "memtool %d=%d", program_counter++, array.ptr[i]);
    }

    destruct(&array);
    return 0;
}

