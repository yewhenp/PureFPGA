#include "utility.h"

void destruct(array32_t *array) {
    free(array->ptr);
    array->size = 0;
}

array32_t read_file_to_array(const char *filename) {
    int32_t *ptr = (int32_t *) malloc(MAX_CAPACITY * sizeof(int));
    if (ptr == NULL) {
        printf("ERROR: could not allocate memory for file\n");
        exit(1);
    }
    int32_t number;

    FILE *file = fopen(filename, "r");

    if (!file) {
        printf("ERROR: could not open file %s\n", filename);
        exit(1);
    }
    size_t size = 0;
    if(ends_with(filename, "txt")) {
        while ((fscanf(file, "%d", &number) == 1) && (size < MAX_CAPACITY)) {
            *(ptr + size++) = number;
        }
    } else if (ends_with(filename, "out")) {
        char instruction[INSTRUCTION_SIZE + 1];
        char format[32];
        snprintf(format, sizeof(format), "%%%ds", INSTRUCTION_SIZE);
        while(fscanf(file, format, instruction) != EOF){
            *(ptr + size++) = convert(instruction);
        }
    }
    array32_t array = {ptr, size};
    return array;
}

array32_t read_memory_to_array(size_t *mem, size_t size) {
    int32_t *ptr = (int32_t *) malloc(MAX_CAPACITY * sizeof(int));
    if (ptr == NULL) {
        printf("ERROR: could not allocate memory for file\n");
        exit(1);
    }
    memcpy(ptr, mem, size * sizeof(uint32_t));
    array32_t array = {ptr, size};
    return array;
}

void print_memory(size_t *mem, size_t size) {
    size = (size % 4) ? size + (4 - size % 4) : size;
    array32_t array = read_memory_to_array(mem, size);
    for (size_t i = 0; i < size; i += 4) {
        printf("%-8p:    %010d    %010d    %010d    %010d\n", mem + i, *(array.ptr + i), *(array.ptr + 1 + i),
               *(array.ptr + 2 + i), *(array.ptr + 3 + i));
    }
    destruct(&array);

}

size_t convert(char* source){
    size_t instruction = 0;
    for (size_t i = 0; i < strlen(source); i++){
        instruction <<= 1;
        if(source[i] == '1') instruction++;
    }
    return instruction;
}

void write_array_to_memory(array32_t *array, size_t *mem) {
    memcpy(mem, array->ptr, array->size * sizeof(uint32_t));
}

void *connect(int *fd) {
    if ((*fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1) {
        printf("ERROR: could not open \"/dev/mem\"...\n");
        exit(1);
    }
    printf("open /dev/mem: ok\n");

    void *fpga_onchip_ram = mmap(NULL, FPGA_ONCHIP_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, *fd, FPGA_ONCHIP_BASE);

    if (fpga_onchip_ram == MAP_FAILED) {
        printf("ERROR: mmap3() failed...\n");
        close(*fd);
        exit(1);
    }
    return fpga_onchip_ram;
}

int ends_with(const char *str, const char *suffix) {
    if (!str || !suffix)
        return 0;
    size_t lenstr = strlen(str);
    size_t lensuffix = strlen(suffix);
    if (lensuffix > lenstr)
        return 0;
    return strncmp(str + lenstr - lensuffix, suffix, lensuffix) == 0;
}