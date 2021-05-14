// Packet: follow video packet of "Avalon-ST Video Protocol" defined VIP spec.



module gpu_interface(
	clk,
	reset_n,
	
	// streaming source interface
	st_data,
	st_valid,
	st_sop,
	st_eop,
	st_ready,
	
	// mm master
	address,
	readdata,
	readdatavalid,
	waitrequest,
	read_data,
	
	ctrl_address,
	ctrl_data,
	ctrl_write,
	ctrl_chep,
	
	pixclk
);



input		clk;
input 	reset_n;


output	  [23:0]	st_data;
output				st_valid;
output				st_sop;
output		 		st_eop;
input				st_ready;

input			[31:0] readdata;
output		[31:0] address;
input					readdatavalid;
input					waitrequest;
output				read_data;

input					 ctrl_address;
input			[31:0] ctrl_data;
input					 ctrl_write;
input					ctrl_chep;


input					pixclk;

////////////////////////////////////////////////
/*  ##lou mod
parameter VIDEO_W	= 800;
parameter VIDEO_H	= 600;
*/

//parameter VIDEO_W	= 1280;
//parameter VIDEO_H	= 720;
parameter VIDEO_W	= 1024;
parameter VIDEO_H	= 768;
//parameter VIDEO_W	= 1280;
//parameter VIDEO_H	= 1024;
//parameter START_ADDRESS	= 16711680;
reg [31:0] START_ADDRESS = 32'b0;
reg main_status = 1'b0;
//`define VIDEO_PIX_NUM	(VIDEO_W * VIDEO_H)

////////////////////////////////////////////////


reg clk_div_reg = 0;
reg read_status = 1'b1;
assign read_data = read_status;


//reg [7:0] RGB_R,RGB_G, RGB_B;
wire [7:0] RGB_R, RGB_G, RGB_B;

reg RGB_VALID = 1;
wire pixclk;
//wire pixclk_read;
//reg [3:0] pix_clk_cnt = 0; 
reg pix_clk_cnt = 0; 
reg change_status = 0; 
//reg ssstttaaatttuuusss = 1'b1;

//assign pixclk = (pix_clk_cnt & 2)?1:0;
//assign pixclk = (pix_clk_cnt & 1)?1:0;
//assign pixclk = clk;
//assign pixclk = (pix_clk_cnt & 15)?1:0;
//assign pixclk_read = pix_clk_cnt;
//assign pixclk = pix_clk_cnt;
//assign pixclk_read = clk;

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n) begin
		pix_clk_cnt <= 0;
		clk_div_reg <= 0;
	end else begin
//		pix_clk_cnt <= pix_clk_cnt + 1;
		pix_clk_cnt <= ~pix_clk_cnt;
		clk_div_reg <= ~clk_div_reg;
	end
end


// Control interface

always @ (posedge clk)
begin
	if (ctrl_chep) begin
		if (ctrl_write) begin
			if (ctrl_address) begin
				main_status <= ctrl_data[0];
			end else begin
				START_ADDRESS <= ctrl_data;
			end
		end
	end
end


//////////////////////
// XY count, color simulation
reg [11:0] RGB_X;
reg [11:0] RGB_Y;
reg [31:0] main_address = 0;

assign address = main_address;

assign RGB_R = readdata[7:0];
assign RGB_G = readdata[15:8];
assign RGB_B = readdata[23:16];

always @ (posedge pixclk or negedge reset_n)
begin
	if (~reset_n)
	begin
		RGB_X = 0;
		RGB_Y = 0;
		main_address = START_ADDRESS;
	end
	else if (main_status) begin
	if (~fifo_w_full) begin
			if (~waitrequest) begin
	//			ssstttaaatttuuusss <= 0;
				if (RGB_X >= VIDEO_W) begin
					RGB_X <= 0;
					if (RGB_Y > VIDEO_H) begin
			//			if (eop == 1) begin
						RGB_Y = 0;
						main_address = START_ADDRESS;
					end else begin
						RGB_Y = RGB_Y + 1;
//						change_status = ~change_status;
//						if (change_status) begin
							main_address = main_address + 1;
//						end
					end
				end else begin
					RGB_X = RGB_X + 1;	
//					change_status = ~change_status;
//					if (change_status) begin
						main_address = main_address - 1;
//					end
				end
			end
		end
	end
end

//always @ (negedge pixclk or negedge reset_n)
//begin
//	RGB_R = readdata[7:0];
//	RGB_G = readdata[15:8];
//	RGB_B = readdata[23:16];
//end

/////////////////////////////
// write rgb to fifo

reg [25:0]	 fifo_w_data;  // 1-bit sop + 1-bit eop + 24-bits data
wire fifo_w_full;
wire sop;
wire eop;
wire in_active_area;

assign sop = (RGB_X == 0 && RGB_Y == 0)?1'b1:1'b0;
assign eop = (((RGB_X+1) == VIDEO_W) && ((RGB_Y+1) == VIDEO_H))?1'b1:1'b0;

assign in_active_area = ((RGB_X < VIDEO_W) && (RGB_Y < VIDEO_H))?1'b1:1'b0;

reg fifo_w_write;
always @ (posedge pixclk or negedge reset_n)
begin
	if (~reset_n)
	begin
		fifo_w_write <= 1'b0;
		//push_fail <= 1'b0;
	end
	else if (~fifo_w_full& readdatavalid & ~waitrequest & main_status) begin
//	else if (~fifo_w_full& main_status) begin
		if (RGB_VALID & in_active_area)
		begin
			if (!fifo_w_full)
			begin
//				change_status = ~change_status;
//				if (change_status) begin
				fifo_w_data <= {sop,eop, RGB_B, RGB_G, RGB_R};
				fifo_w_write <= 1'b1;
//				end else begin
//					fifo_w_write <= 1'b0;
//				end
//				ssstttaaatttuuusss <= 1'b1;
			end
			else
			begin
				fifo_w_write <= 1'b0;
			//	push_fail <= 1'b1; // fifo full !!!!!
			end
		end
		else
			fifo_w_write<= 1'b0;
	end else
		fifo_w_write<= 1'b0;
end



/////////////////////////////
// read from fifo
wire 		fifo_r_empty;
wire [25:0] fifo_r_q;		
wire 		fifo_r_rdreq_ack;





/////////////////////////////
// FIFO
rgb_fifo rgb_fifo_inst(
	// write
	.data(fifo_w_data),
	.wrclk(pixclk),
	.wrreq(fifo_w_write),
	.wrfull(fifo_w_full),
	
	// read
	.rdclk(clk),
//	.rdclk(clk_div_reg),
	.rdreq(fifo_r_rdreq_ack),
	.q(fifo_r_q),
	.rdempty(fifo_r_empty),
	//
	.aclr(~reset_n)
	
	);	
	
	

///////////////////////////////
wire frame_start /* synthesis keep */;
assign frame_start = fifo_r_q[25] & ~fifo_r_empty;
 
//reg first_pix; 
//always @ (posedge clk or negedge reset_n)
//begin
//	if (~reset_n)
//		first_pix <= 1'b0;
//	else //if (in_send_data)
//	begin
//		if (send_packet_id & st_valid)
//			first_pix <= 1'b1;
//		else
//			first_pix <= 1'b0;
//	endssstttaaatttuuusss
//end	
//
//wire send_packet_id /* synthesis keep */;
//assign send_packet_id = in_send_data & frame_start & ~first_pix;

/////////////////////////////
// flag for ready_latency=1
reg pre_ready;
always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
		pre_ready <= 0;
	else
		pre_ready <= st_ready;
end

//reg [31:0] count;
////debug
//always @ (posedge clk or negedge reset_n)
//begin
//  if(~reset_n)
//    count <= 0;
//  else if(fifo_r_rdreq_ack)
//  begin
//    count <= count + 1;
//  end
//  else if(st_sop)
//    count <= 0;
//  //else if(count == VIDEO_W*VIDEO_H)
//    //count[24] = 1'b1;
//  //else
//    //count <= count;
//  
//  
//end

////////////////////////////////////
//assign {st_sop, st_eop, st_data} = (in_send_data || in_wait_frame_start)?(send_packet_id)?{1'b1,1'b0, 24'h000000}:{1'b0,fifo_r_q[24:0]}:control_data;
wire [25:0] video_data;
assign video_data = (send_data_packet_id)?{1'b1,1'b0, 24'h000000}:{1'b0, fifo_r_q[24:0]};


assign {st_sop, st_eop, st_data} =  (in_wait_frame_start)?(fifo_r_q[25:0]): ((in_send_data?video_data:control_data));

//assign {st_sop, st_eop, st_data} = (send_packet_id)?{1'b1,1'b0, 24'h000000}:{1'b0, count};
//assign st_valid = (in_wait_frame_start | in_send_data)?(~fifo_r_empty & pre_ready):(in_send_control & pre_ready); 
assign st_valid = pre_ready & ((in_wait_frame_start)?( ~fifo_r_empty & ~fifo_r_q[25]):((in_send_data)?(send_data_packet_id | ~fifo_r_empty):(in_send_control))); 
assign fifo_r_rdreq_ack = (in_wait_frame_start | (in_send_data & ~send_data_packet_id)) & st_valid;


////////////////////////////////////
////////////////////////////////////
// Packet Type State Control
////////////////////////////////////
////////////////////////////////////


`define ST_WAIT_FRAME_START  	2'h0
`define ST_SEND_CONTROL_PKT	2'h1
`define ST_SEND_DATA_PKT		2'h2

wire 			in_wait_frame_start /* synthesis keep */;
wire 			in_send_control /* synthesis keep */;
wire 			in_send_data /* synthesis keep */;
reg [1:0]	state /*synthesis noprune*/;
reg [2:0] 	control_index /*synthesis noprune*/;

reg			send_data_packet_id/*synthesis noprune*/;
reg [31:0]	pixel_cnt/*synthesis noprune*/;
reg [31:0]	frame_cnt/*synthesis noprune*/;

assign in_wait_frame_start = (state == `ST_WAIT_FRAME_START)?1'b1:1'b0;
assign in_send_control = (state == `ST_SEND_CONTROL_PKT)?1'b1:1'b0;
assign in_send_data = (state == `ST_SEND_DATA_PKT)?1'b1:1'b0;

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
	begin
		state <= `ST_WAIT_FRAME_START;
		frame_cnt <= 0;
	end
	
	//
	else if (in_wait_frame_start)
	begin
		if (frame_start)
		begin
			state <= `ST_SEND_CONTROL_PKT;
			control_index <= 0;
		end
			
	end
	
	//
	else if (in_send_control)
	begin
		if (st_valid)
		begin		
			if (control_index == 3)
			begin
				state <= `ST_SEND_DATA_PKT;
				send_data_packet_id <= 1'b1;
				pixel_cnt <= 0;
			end
			else
				control_index <= control_index + 1;
		end
	end
	
	//
	else if (in_send_data)
	begin
		if (send_data_packet_id)
			send_data_packet_id <= ~st_valid;
		else
		begin
			if (st_valid)
				pixel_cnt <= pixel_cnt + 1;
			if ((st_eop & st_valid) | (frame_start && (pixel_cnt > 0)))// last video pixel is send or new frame start is find
				state <= `ST_WAIT_FRAME_START;
			if (st_eop & st_valid & ((pixel_cnt+1) == (VIDEO_W*VIDEO_H)))
				frame_cnt <= frame_cnt + 1;
		end
	end
	
		
end




///////////////////////////
// prepare control data

wire [15:0] 	width;
wire [15:0] 	height;
wire [3:0]		interlacing;
reg  [25:0]  	control_data;

assign width  = VIDEO_W;
assign height = VIDEO_H;
assign interlacing = 4'h03 /* progress */; //  10 for unknown or 11 for not deinterlaced, 00 for F0 last, and 01 for F1 last.

always @ (*)
begin
	if (in_send_control)
	begin
		case(control_index) // sop, eop, 8-bit, 8-bit, 8-bit = 26 bits
			0: control_data <= {1'b1, 1'b0, 8'h0, 8'h0, 8'd15};
			1: control_data <= {1'b0, 1'b0, {4'h0,width[7:4]},   {4'h0,width[11:8]},   {4'h0,width[15:12]}};
			2: control_data <= {1'b0, 1'b0, {4'h0,height[11:8]}, {4'h0,height[15:12]}, {4'h0,width[3:0]}};
			3: control_data <= {1'b0, 1'b1, {4'h0, interlacing[3:0]}, {4'h0,height[3:0]}, {4'h0,height[7:4]}};
		endcase
	end
		
end


endmodule
