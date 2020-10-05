# GPU for Z80 based on FPGA

## Idea of project
Tha main purpose of this project is to create general purpose video card using FPGA techs. 
This project is part of bigger project - computer based on Z80. 
In this project is used DE10-nano Cyclone V FPGA.

## Product requirements
- compatible with Z80
- general purpose (capability to program it)
- cuda-like architecture
- video output to VGA or\and hdmi
- 64 16 bit simple cores
- special simple assembler

## Details on realization
### memory
- "memory remapping" - data distribution between cores
   (number of core that will get i piece of data - i%{number of used cores}) + plus devide array into smaller with len = number of cores)
- 
