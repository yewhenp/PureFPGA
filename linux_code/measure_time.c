// 1 - program, 2 - ram, 3 - number of cores
#include <stdlib.h>
#include <time.h>
#include <stdio.h>
#include <stddef.h>

int videocard_finished() {
    char ch;
    FILE *fp = popen("memtool -8 0xFF200001 1", "r");
    if (fp == NULL) {
        printf("Failed to read control memory\n" );
        return -1;
    }
    while((ch = fgetc(fp)) != EOF)
        if (ch == ':') {
            while ((ch = fgetc(fp)) != EOF) {
                if (ch == '0') {
                    if (fgetc(fp)=='1') {
                        return 0;
                    }
                }
            }
        }
    return -2;
}

int main(int argc, char **argv) {
    if (argc != 4) {
        printf("Wrong number of arguments (should be 3)");
        return 1;
    }
    char execute_buffer[200];
    sprintf(execute_buffer, "python2 assembler/pure_assembler.py -s assembler/programs/%s.mccp -ap -v -o %s.out > disassemble",
            argv[1], argv[1]);
    int status = system(execute_buffer);
    if (status != 0) {
        printf("Error occured while compiling...");
        return status;
    }

    sprintf(execute_buffer, "./mem %s 0xC0000000", argv[2]);
    status = system(execute_buffer);
    if (status != 0) {
        printf("Error occured while filling RAM...");
        return status;
    }

    sprintf(execute_buffer, "./mem %s.out 0xC0040000", argv[1]);
    status = system(execute_buffer);
    if (status != 0) {
        printf("Error occured while filling ROM...");
        return status;
    }

    sprintf(execute_buffer, "./scripts/activate_cores.sh %s", argv[3]);
    status = system(execute_buffer);
    if (status != 0) {
        printf("Error occured while setting up number of cores...");
        return status;
    }

    sprintf(execute_buffer, "memtool -8 0xFF200000=0x1");

    clock_t start = clock();

    status = 0;
    while ((status = videocard_finished()) == -2) {}
    if (status < 0) {
        printf("Error occured while wating on videocard...");
        return 1;
    }

    clock_t end = clock();
    float seconds = (float)(end - start) / CLOCKS_PER_SEC;
    sprintf(execute_buffer, "time elapsed %fs\n", seconds);
    printf(execute_buffer);
    return 0;
}