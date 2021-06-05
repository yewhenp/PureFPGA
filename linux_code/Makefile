#

OBJ1 = write
OBJ2 = print
OBJ3 = time_test
OBJ4 = mem_write
TARGET = $(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4)

#
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-none-linux-gnueabihf-
CFLAGS = -std=c11 -g -Wall   -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/ -I.
LDFLAGS = -g -Wall
CC = $(CROSS_COMPILE)gcc
ARCH= arm

#all: $(TARGET)
#
#$(TARGET) : $(OBJ)
#	$(CC) $(LDFLAGS)   $^ -o $@
#%.o : %.c
#	$(CC) $(CFLAGS) -c $< -o $@
#
#.PHONY: clean
#clean:
#	rm -f $(TARGET) *.a *.o *~


SOURCES=$(wildcard *.c)
DEPENDENCY = utility.o
OBJECTS=$(SOURCES:.c=.o)

.PHONY: all
all: $(OBJECTS) $(TARGET)

$(OBJ1): $(addsuffix .o,$(OBJ1)) $(DEPENDENCY)
	$(CC) $(LDFLAGS)   $^ -o $@

$(OBJ2): $(addsuffix .o,$(OBJ2)) $(DEPENDENCY)
	$(CC) $(LDFLAGS)   $^ -o $@

$(OBJ3): $(addsuffix .o,$(OBJ3)) $(DEPENDENCY)
	$(CC) $(LDFLAGS)   $^ -o $@

$(OBJ4): $(addsuffix .o,$(OBJ4)) $(DEPENDENCY)
	$(CC) $(LDFLAGS)   $^ -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	-@ $(RM) *.o
	-@ $(RM) $(TARGET)