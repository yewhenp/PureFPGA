// megafunction wizard: %LPM_DECODE%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_DECODE 

// ============================================================
// File Name: decoder64.v
// Megafunction Name(s):
// 			LPM_DECODE
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 20.1.0 Build 711 06/05/2020 SJ Lite Edition
// ************************************************************

//Copyright (C) 2020  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and any partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details, at
//https://fpgasoftware.intel.com/eula.

module decoder64 (
	data,
	eq63);

	input	[5:0]  data;
	output	  eq63;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: BaseDec NUMERIC "1"
// Retrieval info: PRIVATE: EnableInput NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: eq0 NUMERIC "0"
// Retrieval info: PRIVATE: eq1 NUMERIC "0"
// Retrieval info: PRIVATE: eq10 NUMERIC "0"
// Retrieval info: PRIVATE: eq11 NUMERIC "0"
// Retrieval info: PRIVATE: eq12 NUMERIC "0"
// Retrieval info: PRIVATE: eq13 NUMERIC "0"
// Retrieval info: PRIVATE: eq14 NUMERIC "0"
// Retrieval info: PRIVATE: eq15 NUMERIC "0"
// Retrieval info: PRIVATE: eq16 NUMERIC "0"
// Retrieval info: PRIVATE: eq17 NUMERIC "0"
// Retrieval info: PRIVATE: eq18 NUMERIC "0"
// Retrieval info: PRIVATE: eq19 NUMERIC "0"
// Retrieval info: PRIVATE: eq2 NUMERIC "0"
// Retrieval info: PRIVATE: eq20 NUMERIC "0"
// Retrieval info: PRIVATE: eq21 NUMERIC "0"
// Retrieval info: PRIVATE: eq22 NUMERIC "0"
// Retrieval info: PRIVATE: eq23 NUMERIC "0"
// Retrieval info: PRIVATE: eq24 NUMERIC "0"
// Retrieval info: PRIVATE: eq25 NUMERIC "0"
// Retrieval info: PRIVATE: eq26 NUMERIC "0"
// Retrieval info: PRIVATE: eq27 NUMERIC "0"
// Retrieval info: PRIVATE: eq28 NUMERIC "0"
// Retrieval info: PRIVATE: eq29 NUMERIC "0"
// Retrieval info: PRIVATE: eq3 NUMERIC "0"
// Retrieval info: PRIVATE: eq30 NUMERIC "0"
// Retrieval info: PRIVATE: eq31 NUMERIC "0"
// Retrieval info: PRIVATE: eq32 NUMERIC "0"
// Retrieval info: PRIVATE: eq33 NUMERIC "0"
// Retrieval info: PRIVATE: eq34 NUMERIC "0"
// Retrieval info: PRIVATE: eq35 NUMERIC "0"
// Retrieval info: PRIVATE: eq36 NUMERIC "0"
// Retrieval info: PRIVATE: eq37 NUMERIC "0"
// Retrieval info: PRIVATE: eq38 NUMERIC "0"
// Retrieval info: PRIVATE: eq39 NUMERIC "0"
// Retrieval info: PRIVATE: eq4 NUMERIC "0"
// Retrieval info: PRIVATE: eq40 NUMERIC "0"
// Retrieval info: PRIVATE: eq41 NUMERIC "0"
// Retrieval info: PRIVATE: eq42 NUMERIC "0"
// Retrieval info: PRIVATE: eq43 NUMERIC "0"
// Retrieval info: PRIVATE: eq44 NUMERIC "0"
// Retrieval info: PRIVATE: eq45 NUMERIC "0"
// Retrieval info: PRIVATE: eq46 NUMERIC "0"
// Retrieval info: PRIVATE: eq47 NUMERIC "0"
// Retrieval info: PRIVATE: eq48 NUMERIC "0"
// Retrieval info: PRIVATE: eq49 NUMERIC "0"
// Retrieval info: PRIVATE: eq5 NUMERIC "0"
// Retrieval info: PRIVATE: eq50 NUMERIC "0"
// Retrieval info: PRIVATE: eq51 NUMERIC "0"
// Retrieval info: PRIVATE: eq52 NUMERIC "0"
// Retrieval info: PRIVATE: eq53 NUMERIC "0"
// Retrieval info: PRIVATE: eq54 NUMERIC "0"
// Retrieval info: PRIVATE: eq55 NUMERIC "0"
// Retrieval info: PRIVATE: eq56 NUMERIC "0"
// Retrieval info: PRIVATE: eq57 NUMERIC "0"
// Retrieval info: PRIVATE: eq58 NUMERIC "0"
// Retrieval info: PRIVATE: eq59 NUMERIC "0"
// Retrieval info: PRIVATE: eq6 NUMERIC "0"
// Retrieval info: PRIVATE: eq60 NUMERIC "0"
// Retrieval info: PRIVATE: eq61 NUMERIC "0"
// Retrieval info: PRIVATE: eq62 NUMERIC "0"
// Retrieval info: PRIVATE: eq63 NUMERIC "1"
// Retrieval info: PRIVATE: eq7 NUMERIC "0"
// Retrieval info: PRIVATE: eq8 NUMERIC "0"
// Retrieval info: PRIVATE: eq9 NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "6"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_DECODES NUMERIC "64"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_DECODE"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "6"
// Retrieval info: USED_PORT: @eq 0 0 64 0 OUTPUT NODEFVAL "@eq[63..0]"
// Retrieval info: USED_PORT: data 0 0 6 0 INPUT NODEFVAL "data[5..0]"
// Retrieval info: USED_PORT: eq63 0 0 0 0 OUTPUT NODEFVAL "eq63"
// Retrieval info: CONNECT: @data 0 0 6 0 data 0 0 6 0
// Retrieval info: CONNECT: eq63 0 0 0 0 @eq 0 0 1 63
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL decoder64_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
