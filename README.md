# MCCP - MultiCore CoProcessor. GPGPU for Z80 based computer
### first presentation
[here](https://docs.google.com/presentation/d/e/2PACX-1vQRQlCamovF6Binl2SsoKEvrqsEsJz2ccPZm9A6kuHSVUr-em4yzhscMbtGglOLyyb3eJqYMeQPTMkx/pub?start=false&loop=false&delayms=3000)
### second presentation 
[here](https://docs.google.com/presentation/d/e/2PACX-1vTUkK01aqt_vz5_lOJwjbPODXsyEMpyrtoSjEdmuw4ukz_GMbEvGKHjo9ceVAkxTsElBvFuRDRA0aLD/pub?start=false&loop=false&delayms=3000)
### third presentation
[here](https://docs.google.com/presentation/d/e/2PACX-1vTVfOXb5rheupiz6Ob63Culg5LiFyZjbOxZ8CyO_Lo17noED1dXoVwQrShWZQk1yA/pub?start=false&loop=false&delayms=3000)
### fourth presentation
[here](https://docs.google.com/presentation/d/e/2PACX-1vTFs381pHR2PLveAYBrA2p2wrEo3RzpDv-Db8mIF7FAq5vMPitggd6w6WqDNGU7Ubs-PCCUC5ojlRXD/pub?start=false&loop=false&delayms=3000)

## Idea of project
Tha main purpose of this project is to create general purpose video card using FPGA technology.
This project is part of bigger project - computer based on Z80.
In this project is used DE10-nano Cyclone V FPGA.

## Product requirements
- general purpose (capability to program it)
- cuda-like architecture
- video output to VGA or\and hdmi
- 32 bit simple cores
- simple RISC ISA
- each core is mostly independent and can support branches
- using HPS component to prepare data for videocard

## Prerequisites
For usage:
- [Quartus Prime](https://fpgasoftware.intel.com/?edition=lite), version 18+
- [minicom](https://archlinux.org/packages/community/x86_64/minicom/) / [putty](https://wiki.archlinux.org/index.php/PuTTY) or other serial port communication software
- python 3
- DE10 nano cyclone V FPGA board
- Linux on HPS component (download [here](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=165&No=1046&PartNo=4))

Additional (for development):
- [ARM development studio & SoC EDS](https://rocketboards.org/foswiki/Documentation/SoCEDS)
- [hwlib](https://rocketboards.org/foswiki/Documentation/HWLib)

## Usage
- Open project in Quartus Prime (project file - ./MCCP/ucu_gpu.qpf)
- Connect DE10-nano board to power and USB Blaster
- Open Programmer. Choose board in Hardware Setup, Add .sof file, press Auto-Detect, tick Program/Configure, press Start
- Connect board to uart to USB port. Open minicom/putty, set bit rate 115200, login to linux.
- Memory of videocard is mapped to \[0xC0000000 - 0xC003fffc\].
```bash
# write to memory
memtool address=value
# read 
memtool address number_of_words #(word has 32 bits)
```
- To start videocard, send interrupt to 0xFF200000 - 
```bash
memtool 0xFF200000=1
```

## Details on realization
### memory
- Videocard can address only 64Kb of FPGA memory. 
- Videocard's memory is mapped to address space of linuz through hps-to-fpga interface
- Special module reads starting interrupts on 0xFF200000 through lightweight interface. Also after work is done, videocard sends interrupt on 0xFF200001. Carefully, in 60 ticks, this module clears interrupt
- Each core can access any address in this 64Kb memory. 
- There is arbiter that has clock with higher freq, it manages all requests to access memory from cores. 
- There is FPGA ROM memory, where program lives. Program is hardcoded and cannot be changed during runtime. In ./assembler there is extremenly simple bootloader, that allows to chooce address of starting program for each core. So it is possible to make each core run different programs.

## instruction execution cycle
### ISA documentation [here](./assembler/ISA_DOCUMENTATION.md)

- Each core can be interpreted as individual core.
- After finishing work, core sends interrupt with number 1, that is passed to interrupt controller, that counts interrupts. After all cores sent finishing signal, interrupt controler writes to 0xFF200001 (read usage), which is signal to linux that work is done.
