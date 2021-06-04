#ifndef UCU_HPS_GPU_COPY_UTILITY_H
#define UCU_HPS_GPU_COPY_UTILITY_H
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <time.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "hps_0.h"
#define MIN(a,b) (((a)<(b))?(a):(b))
// ======================================
#define MAX_CAPACITY          65536
#define H2F_AXI_MASTER_BASE   0xC0000000
// #define FPGA_ONCHIP_BASE      H2F_AXI_MASTER_BASE + VIDEOCARD_NEW_0_MEMORY_MAIN_BASE
// #define FPGA_ONCHIP_SPAN      VIDEOCARD_NEW_0_MEMORY_MAIN_SPAN
#define FPGA_ONCHIP_BASE      H2F_AXI_MASTER_BASE + VIDEO_BUFFER_BASE
#define FPGA_ONCHIP_SPAN      2 * VIDEOCARD_NEW_0_MEMORY_MAIN_SPAN
#define INSTRUCTION_SIZE 32
typedef struct {
    int32_t * ptr;
    size_t size;
} array32_t;

typedef struct {
    int16_t * ptr;
    size_t size;
} array16_t;

typedef struct {
    int8_t * ptr;
    size_t size;
} array8_t;
void destruct(array32_t* array);
array32_t read_file_to_array(const char *filename);
array32_t read_memory_to_array(size_t* mem, size_t size);
void print_memory(size_t* mem, size_t size);
void write_array_to_memory(array32_t* array, size_t* mem);
void* connect(int* fd);
int ends_with(const char *str, const char *suffix);
size_t convert(char* source);


#endif //UCU_HPS_GPU_COPY_UTILITY_H
