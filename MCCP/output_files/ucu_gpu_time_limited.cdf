/* Quartus Prime Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEBA6U23) Path("/home/yevhen/Downloads/UCU_4_semestr/aks/release/videocard/aaaa/PureFPGA/MCCP/output_files/") File("ucu_gpu_time_limited.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
