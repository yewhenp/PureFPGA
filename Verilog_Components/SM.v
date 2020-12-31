module SM 
#(parameter DATA_WIDTH=16,
				ADDRESS_WIDTH=16,
				BUFFER_ADDRESS_WIDTH=19,
				INSTRUCTION_WIDTH=15,
				CORE_NUM=64,
				CORE_BUFFER_WIDTH=13)
   (	
	inout [DATA_WIDTH - 1:0]data, 
	input [ADDRESS_WIDTH - 1:0]address,
	input [INSTRUCTION_WIDTH - 1:0]instruction,
	input [BUFFER_ADDRESS_WIDTH - 1:0]bufferAddress,
	input wren,
	input [CORE_NUM - 1:0]coreEnable,
	input clk,
	output [DATA_WIDTH - 1:0]bufferData
	);
	
	wire [DATA_WIDTH - 1:0] bufferData0;
	wire [DATA_WIDTH - 1:0] bufferData1;
	wire [DATA_WIDTH - 1:0] bufferData2;
	wire [DATA_WIDTH - 1:0] bufferData3;
	wire [DATA_WIDTH - 1:0] bufferData4;
	wire [DATA_WIDTH - 1:0] bufferData5;
	wire [DATA_WIDTH - 1:0] bufferData6;
	wire [DATA_WIDTH - 1:0] bufferData7;
	wire [DATA_WIDTH - 1:0] bufferData8;
	wire [DATA_WIDTH - 1:0] bufferData9;
	wire [DATA_WIDTH - 1:0] bufferData10;
	wire [DATA_WIDTH - 1:0] bufferData11;
	wire [DATA_WIDTH - 1:0] bufferData12;
	wire [DATA_WIDTH - 1:0] bufferData13;
	wire [DATA_WIDTH - 1:0] bufferData14;
	wire [DATA_WIDTH - 1:0] bufferData15;
	wire [DATA_WIDTH - 1:0] bufferData16;
	wire [DATA_WIDTH - 1:0] bufferData17;
	wire [DATA_WIDTH - 1:0] bufferData18;
	wire [DATA_WIDTH - 1:0] bufferData19;
	wire [DATA_WIDTH - 1:0] bufferData20;
	wire [DATA_WIDTH - 1:0] bufferData21;
	wire [DATA_WIDTH - 1:0] bufferData22;
	wire [DATA_WIDTH - 1:0] bufferData23;
	wire [DATA_WIDTH - 1:0] bufferData24;
	wire [DATA_WIDTH - 1:0] bufferData25;
	wire [DATA_WIDTH - 1:0] bufferData26;
	wire [DATA_WIDTH - 1:0] bufferData27;
	wire [DATA_WIDTH - 1:0] bufferData28;
	wire [DATA_WIDTH - 1:0] bufferData29;
	wire [DATA_WIDTH - 1:0] bufferData30;
	wire [DATA_WIDTH - 1:0] bufferData31;
	wire [DATA_WIDTH - 1:0] bufferData32;
	wire [DATA_WIDTH - 1:0] bufferData33;
	wire [DATA_WIDTH - 1:0] bufferData34;
	wire [DATA_WIDTH - 1:0] bufferData35;
	wire [DATA_WIDTH - 1:0] bufferData36;
	wire [DATA_WIDTH - 1:0] bufferData37;
	wire [DATA_WIDTH - 1:0] bufferData38;
	wire [DATA_WIDTH - 1:0] bufferData39;
	wire [DATA_WIDTH - 1:0] bufferData40;
	wire [DATA_WIDTH - 1:0] bufferData41;
	wire [DATA_WIDTH - 1:0] bufferData42;
	wire [DATA_WIDTH - 1:0] bufferData43;
	wire [DATA_WIDTH - 1:0] bufferData44;
	wire [DATA_WIDTH - 1:0] bufferData45;
	wire [DATA_WIDTH - 1:0] bufferData46;
	wire [DATA_WIDTH - 1:0] bufferData47;
	wire [DATA_WIDTH - 1:0] bufferData48;
	wire [DATA_WIDTH - 1:0] bufferData49;
	wire [DATA_WIDTH - 1:0] bufferData50;
	wire [DATA_WIDTH - 1:0] bufferData51;
	wire [DATA_WIDTH - 1:0] bufferData52;
	wire [DATA_WIDTH - 1:0] bufferData53;
	wire [DATA_WIDTH - 1:0] bufferData54;
	wire [DATA_WIDTH - 1:0] bufferData55;
	wire [DATA_WIDTH - 1:0] bufferData56;
	wire [DATA_WIDTH - 1:0] bufferData57;
	wire [DATA_WIDTH - 1:0] bufferData58;
	wire [DATA_WIDTH - 1:0] bufferData59;
	wire [DATA_WIDTH - 1:0] bufferData60;
	wire [DATA_WIDTH - 1:0] bufferData61;
	wire [DATA_WIDTH - 1:0] bufferData62;
	wire [DATA_WIDTH - 1:0] bufferData63;

	
	reg [DATA_WIDTH - 1:0] bufferDataResult;
	assign bufferData= bufferDataResult;
	
	wire [DATA_WIDTH - 1:0] data0 = (coreEnable[0]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data1 = (coreEnable[1]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data2 = (coreEnable[2]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data3 = (coreEnable[3]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data4 = (coreEnable[4]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data5 = (coreEnable[5]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data6 = (coreEnable[6]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data7 = (coreEnable[7]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data8 = (coreEnable[8]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data9 = (coreEnable[9]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data10 = (coreEnable[10]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data11 = (coreEnable[11]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data12 = (coreEnable[12]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data13 = (coreEnable[13]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data14 = (coreEnable[14]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data15 = (coreEnable[15]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data16 = (coreEnable[16]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data17 = (coreEnable[17]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data18 = (coreEnable[18]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data19 = (coreEnable[19]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data20 = (coreEnable[20]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data21 = (coreEnable[21]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data22 = (coreEnable[22]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data23 = (coreEnable[23]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data24 = (coreEnable[24]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data25 = (coreEnable[25]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data26 = (coreEnable[26]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data27 = (coreEnable[27]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data28 = (coreEnable[28]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data29 = (coreEnable[29]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data30 = (coreEnable[30]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data31 = (coreEnable[31]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data32 = (coreEnable[32]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data33 = (coreEnable[33]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data34 = (coreEnable[34]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data35 = (coreEnable[35]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data36 = (coreEnable[36]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data37 = (coreEnable[37]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data38 = (coreEnable[38]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data39 = (coreEnable[39]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data40 = (coreEnable[40]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data41 = (coreEnable[41]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data42 = (coreEnable[42]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data43 = (coreEnable[43]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data44 = (coreEnable[44]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data45 = (coreEnable[45]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data46 = (coreEnable[46]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data47 = (coreEnable[47]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data48 = (coreEnable[48]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data49 = (coreEnable[49]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data50 = (coreEnable[50]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data51 = (coreEnable[51]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data52 = (coreEnable[52]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data53 = (coreEnable[53]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data54 = (coreEnable[54]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data55 = (coreEnable[55]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data56 = (coreEnable[56]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data57 = (coreEnable[57]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data58 = (coreEnable[58]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data59 = (coreEnable[59]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data60 = (coreEnable[60]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data61 = (coreEnable[61]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data62 = (coreEnable[62]) ? data : 16'bZ;
	wire [DATA_WIDTH - 1:0] data63 = (coreEnable[63]) ? data : 16'bZ;
	
	core core0(
	  .data(data0),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[0]),
	  .clk(clk),
	  .bufferData(bufferData0)
	  );
	core core1(
	  .data(data1),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[1]),
	  .clk(clk),
	  .bufferData(bufferData1)
	  );
	core core2(
	  .data(data2),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[2]),
	  .clk(clk),
	  .bufferData(bufferData2)
	  );
	core core3(
	  .data(data3),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[3]),
	  .clk(clk),
	  .bufferData(bufferData3)
	  );
	core core4(
	  .data(data4),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[4]),
	  .clk(clk),
	  .bufferData(bufferData4)
	  );
	core core5(
	  .data(data5),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[5]),
	  .clk(clk),
	  .bufferData(bufferData5)
	  );
	core core6(
	  .data(data6),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[6]),
	  .clk(clk),
	  .bufferData(bufferData6)
	  );
	core core7(
	  .data(data7),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[7]),
	  .clk(clk),
	  .bufferData(bufferData7)
	  );
	core core8(
	  .data(data8),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[8]),
	  .clk(clk),
	  .bufferData(bufferData8)
	  );
	core core9(
	  .data(data9),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[9]),
	  .clk(clk),
	  .bufferData(bufferData9)
	  );
	core core10(
	  .data(data10),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[10]),
	  .clk(clk),
	  .bufferData(bufferData10)
	  );
	core core11(
	  .data(data11),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[11]),
	  .clk(clk),
	  .bufferData(bufferData11)
	  );
	core core12(
	  .data(data12),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[12]),
	  .clk(clk),
	  .bufferData(bufferData12)
	  );
	core core13(
	  .data(data13),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[13]),
	  .clk(clk),
	  .bufferData(bufferData13)
	  );
	core core14(
	  .data(data14),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[14]),
	  .clk(clk),
	  .bufferData(bufferData14)
	  );
	core core15(
	  .data(data15),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[15]),
	  .clk(clk),
	  .bufferData(bufferData15)
	  );
	core core16(
	  .data(data16),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[16]),
	  .clk(clk),
	  .bufferData(bufferData16)
	  );
	core core17(
	  .data(data17),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[17]),
	  .clk(clk),
	  .bufferData(bufferData17)
	  );
	core core18(
	  .data(data18),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[18]),
	  .clk(clk),
	  .bufferData(bufferData18)
	  );
	core core19(
	  .data(data19),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[19]),
	  .clk(clk),
	  .bufferData(bufferData19)
	  );
	core core20(
	  .data(data20),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[20]),
	  .clk(clk),
	  .bufferData(bufferData20)
	  );
	core core21(
	  .data(data21),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[21]),
	  .clk(clk),
	  .bufferData(bufferData21)
	  );
	core core22(
	  .data(data22),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[22]),
	  .clk(clk),
	  .bufferData(bufferData22)
	  );
	core core23(
	  .data(data23),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[23]),
	  .clk(clk),
	  .bufferData(bufferData23)
	  );
	core core24(
	  .data(data24),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[24]),
	  .clk(clk),
	  .bufferData(bufferData24)
	  );
	core core25(
	  .data(data25),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[25]),
	  .clk(clk),
	  .bufferData(bufferData25)
	  );
	core core26(
	  .data(data26),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[26]),
	  .clk(clk),
	  .bufferData(bufferData26)
	  );
	core core27(
	  .data(data27),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[27]),
	  .clk(clk),
	  .bufferData(bufferData27)
	  );
	core core28(
	  .data(data28),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[28]),
	  .clk(clk),
	  .bufferData(bufferData28)
	  );
	core core29(
	  .data(data29),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[29]),
	  .clk(clk),
	  .bufferData(bufferData29)
	  );
	core core30(
	  .data(data30),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[30]),
	  .clk(clk),
	  .bufferData(bufferData30)
	  );
	core core31(
	  .data(data31),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[31]),
	  .clk(clk),
	  .bufferData(bufferData31)
	  );
	core core32(
	  .data(data32),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[32]),
	  .clk(clk),
	  .bufferData(bufferData32)
	  );
	core core33(
	  .data(data33),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[33]),
	  .clk(clk),
	  .bufferData(bufferData33)
	  );
	core core34(
	  .data(data34),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[34]),
	  .clk(clk),
	  .bufferData(bufferData34)
	  );
	core core35(
	  .data(data35),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[35]),
	  .clk(clk),
	  .bufferData(bufferData35)
	  );
	core core36(
	  .data(data36),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[36]),
	  .clk(clk),
	  .bufferData(bufferData36)
	  );
	core core37(
	  .data(data37),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[37]),
	  .clk(clk),
	  .bufferData(bufferData37)
	  );
	core core38(
	  .data(data38),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[38]),
	  .clk(clk),
	  .bufferData(bufferData38)
	  );
	core core39(
	  .data(data39),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[39]),
	  .clk(clk),
	  .bufferData(bufferData39)
	  );
	core core40(
	  .data(data40),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[40]),
	  .clk(clk),
	  .bufferData(bufferData40)
	  );
	core core41(
	  .data(data41),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[41]),
	  .clk(clk),
	  .bufferData(bufferData41)
	  );
	core core42(
	  .data(data42),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[42]),
	  .clk(clk),
	  .bufferData(bufferData42)
	  );
	core core43(
	  .data(data43),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[43]),
	  .clk(clk),
	  .bufferData(bufferData43)
	  );
	core core44(
	  .data(data44),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[44]),
	  .clk(clk),
	  .bufferData(bufferData44)
	  );
	core core45(
	  .data(data45),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[45]),
	  .clk(clk),
	  .bufferData(bufferData45)
	  );
	core core46(
	  .data(data46),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[46]),
	  .clk(clk),
	  .bufferData(bufferData46)
	  );
	core core47(
	  .data(data47),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[47]),
	  .clk(clk),
	  .bufferData(bufferData47)
	  );
	core core48(
	  .data(data48),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[48]),
	  .clk(clk),
	  .bufferData(bufferData48)
	  );
	core core49(
	  .data(data49),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[49]),
	  .clk(clk),
	  .bufferData(bufferData49)
	  );
	core core50(
	  .data(data50),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[50]),
	  .clk(clk),
	  .bufferData(bufferData50)
	  );
	core core51(
	  .data(data51),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[51]),
	  .clk(clk),
	  .bufferData(bufferData51)
	  );
	core core52(
	  .data(data52),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[52]),
	  .clk(clk),
	  .bufferData(bufferData52)
	  );
	core core53(
	  .data(data53),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[53]),
	  .clk(clk),
	  .bufferData(bufferData53)
	  );
	core core54(
	  .data(data54),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[54]),
	  .clk(clk),
	  .bufferData(bufferData54)
	  );
	core core55(
	  .data(data55),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[55]),
	  .clk(clk),
	  .bufferData(bufferData55)
	  );
	core core56(
	  .data(data56),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[56]),
	  .clk(clk),
	  .bufferData(bufferData56)
	  );
	core core57(
	  .data(data57),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[57]),
	  .clk(clk),
	  .bufferData(bufferData57)
	  );
	core core58(
	  .data(data58),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[58]),
	  .clk(clk),
	  .bufferData(bufferData58)
	  );
	core core59(
	  .data(data59),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[59]),
	  .clk(clk),
	  .bufferData(bufferData59)
	  );
	core core60(
	  .data(data60),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[60]),
	  .clk(clk),
	  .bufferData(bufferData60)
	  );
	core core61(
	  .data(data61),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[61]),
	  .clk(clk),
	  .bufferData(bufferData61)
	  );
	core core62(
	  .data(data62),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[62]),
	  .clk(clk),
	  .bufferData(bufferData62)
	  );
	core core63(
	  .data(data63),
	  .address(address),
	  .instruction(instruction),
	  .bufferAddress(bufferAddress[CORE_BUFFER_WIDTH-1:0]),
	  .wren(wren),
	  .cpen(coreEnable[63]),
	  .clk(clk),
	  .bufferData(bufferData63)
	  );


	always @(posedge clk) begin
		case(bufferAddress[BUFFER_ADDRESS_WIDTH-1:CORE_BUFFER_WIDTH-1])
			6'b000000: bufferDataResult = bufferData0;
			6'b000001: bufferDataResult = bufferData1;
			6'b000010: bufferDataResult = bufferData2;
			6'b000011: bufferDataResult = bufferData3;
			6'b000100: bufferDataResult = bufferData4;
			6'b000101: bufferDataResult = bufferData5;
			6'b000110: bufferDataResult = bufferData6;
			6'b000111: bufferDataResult = bufferData7;
			6'b001000: bufferDataResult = bufferData8;
			6'b001001: bufferDataResult = bufferData9;
			6'b001010: bufferDataResult = bufferData10;
			6'b001011: bufferDataResult = bufferData11;
			6'b001100: bufferDataResult = bufferData12;
			6'b001101: bufferDataResult = bufferData13;
			6'b001110: bufferDataResult = bufferData14;
			6'b001111: bufferDataResult = bufferData15;
			6'b010000: bufferDataResult = bufferData16;
			6'b010001: bufferDataResult = bufferData17;
			6'b010010: bufferDataResult = bufferData18;
			6'b010011: bufferDataResult = bufferData19;
			6'b010100: bufferDataResult = bufferData20;
			6'b010101: bufferDataResult = bufferData21;
			6'b010110: bufferDataResult = bufferData22;
			6'b010111: bufferDataResult = bufferData23;
			6'b011000: bufferDataResult = bufferData24;
			6'b011001: bufferDataResult = bufferData25;
			6'b011010: bufferDataResult = bufferData26;
			6'b011011: bufferDataResult = bufferData27;
			6'b011100: bufferDataResult = bufferData28;
			6'b011101: bufferDataResult = bufferData29;
			6'b011110: bufferDataResult = bufferData30;
			6'b011111: bufferDataResult = bufferData31;
			6'b100000: bufferDataResult = bufferData32;
			6'b100001: bufferDataResult = bufferData33;
			6'b100010: bufferDataResult = bufferData34;
			6'b100011: bufferDataResult = bufferData35;
			6'b100100: bufferDataResult = bufferData36;
			6'b100101: bufferDataResult = bufferData37;
			6'b100110: bufferDataResult = bufferData38;
			6'b100111: bufferDataResult = bufferData39;
			6'b101000: bufferDataResult = bufferData40;
			6'b101001: bufferDataResult = bufferData41;
			6'b101010: bufferDataResult = bufferData42;
			6'b101011: bufferDataResult = bufferData43;
			6'b101100: bufferDataResult = bufferData44;
			6'b101101: bufferDataResult = bufferData45;
			6'b101110: bufferDataResult = bufferData46;
			6'b101111: bufferDataResult = bufferData47;
			6'b110000: bufferDataResult = bufferData48;
			6'b110001: bufferDataResult = bufferData49;
			6'b110010: bufferDataResult = bufferData50;
			6'b110011: bufferDataResult = bufferData51;
			6'b110100: bufferDataResult = bufferData52;
			6'b110101: bufferDataResult = bufferData53;
			6'b110110: bufferDataResult = bufferData54;
			6'b110111: bufferDataResult = bufferData55;
			6'b111000: bufferDataResult = bufferData56;
			6'b111001: bufferDataResult = bufferData57;
			6'b111010: bufferDataResult = bufferData58;
			6'b111011: bufferDataResult = bufferData59;
			6'b111100: bufferDataResult = bufferData60;
			6'b111101: bufferDataResult = bufferData61;
			6'b111110: bufferDataResult = bufferData62;
			6'b111111: bufferDataResult = bufferData63;
		endcase
   end
endmodule