module sc_datamem (addr,datas,dataout,we,clock,memCLK,dmemCLK,
	clrn,out_port0,out_port1,in_port0,in_port1,mem_dataout,in_data);
	input [31:0] addr;
	input [31:0] datas;
	input we, clock,memCLK,clrn;
	input [31:0] in_port0,in_port1;
	output [31:0] dataout;
	output dmemCLK;
	output [31:0] out_port0,out_port1;
	output [31:0] mem_dataout;
	output [31:0] in_data;
	wire [31:0] dataout;
	wire dmemCLK;
	wire write_enable;
	wire write_datamem_enable;
	wire [31:0] mem_dataout;
	assign dmemCLK = memCLK & ( ~ clock) ; //注意
	assign write_enable = we & ~clock; //注意
	assign write_datamem_enable = write_enable & ( ~ addr[7]); //注意
	assign write_io_output_reg_enable = write_enable & ( addr[7]); //注意
	mux2x32 mem_io_dataout_mux(mem_dataout,in_data,addr[7],dataout);
	// module mux2x32 (a0,a1,s,y);
	// when address[7]=0, means the access is to the datamem.
	// that is, the address space of datamem is from 000000 to 011111 word(4 bytes)
	lpm_ram_dq_dram dram(addr[6:2],dmemCLK,datas,write_datamem_enable,mem_dataout );
	// when address[7]=1, means the access is to the I/O space.
	// that is, the address space of I/O is from 100000 to 111111 word(4 bytes)
	io_output_reg io_output_regx2 (addr,datas,write_io_output_reg_enable,dmemCLK,clrn,out_port0,out_port1);
	// module io_output_reg (addr,datas,write_io_enable,io_clk,clrn,out_port0,out_port1 );
	io_input_reg io_input_regx2(addr,dmemCLK,in_data,in_port0,in_port1);
	// module io_input_reg (addr,io_clk,in_data,in_port0,in_port1);
endmodule
