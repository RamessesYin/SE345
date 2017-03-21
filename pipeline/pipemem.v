module pipemem( mwmem,mAlu,mB,clock,mem_clock,mmo, 
	clrn,out_port0,out_port1,in_port0,in_port1,mOut_data,in_data); // MEM stage
	input mwmem,clock,mem_clock;
	input [31:0] mAlu,mB;
	
	output [31:0] mmo;
	
	wire write;
	
	//lpm_ram_dq_dram  dram(mAlu[6:2],mem_clock,mB,write,mmo );
	input clrn;
	input [31:0] in_port0,in_port1;
	output [31:0] out_port0,out_port1;
	output [31:0] mOut_data;
	output [31:0] in_data;
	wire [31:0] mmo;
	wire write_datamem_enable,write_io_output_reg_enable;
	//wire dmem_clock;
	wire [31:0] mOut_data;
	
	assign write=mwmem&(~clock);
	//assign dmem_clock=mem_clock&(~clock);
	assign write_datamem_enable = write & ( ~ mAlu[7]); //æ³¨æ
	assign write_io_output_reg_enable = write & ( mAlu[7]); //æ³¨æ
	mux2x32 mem_io_dataout_mux(mOut_data,in_data,mAlu[7],mmo);
	// module mux2x32 (a0,a1,s,y);
	// when address[7]=0, means the access is to the datamem.
	// that is, the address space of datamem is from 000000 to 011111 word(4 bytes)
	lpm_ram_dq_dram dram(mAlu[6:2],mem_clock,mB,write_datamem_enable,mOut_data );
	// when address[7]=1, means the access is to the I/O space.
	// that is, the address space of I/O is from 100000 to 111111 word(4 bytes)
	io_output_reg io_output_regx2 (mAlu,mB,write_io_output_reg_enable,mem_clock,1,out_port0,out_port1);
	// module io_output_reg (addr,datain,write_io_enable,io_clk,clrn,out_port0,out_port1 );
	io_input_reg io_input_regx2(mAlu,mem_clock,in_data,in_port0,in_port1);
	// module io_input_reg (addr,io_clk,in_data,in_port0,in_port1);
endmodule