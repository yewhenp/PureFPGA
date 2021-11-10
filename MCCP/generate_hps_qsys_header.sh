#!/bin/bash
/home/phile/intelFPGA_lite/20.1/quartus/sopc_builder/bin/sopc-create-header-files \
"./soc_system.sopcinfo" \
--single hps_0.h \
--module ARM_A9_HPS
