/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (resetn,clock,memCLK,pc,inst,aluout,memout,imemCLK,dmemCLK,
	clrn,out_port0,out_port1,in_port0,in_port1,mem_dataout,in_data);
   
   input resetn,clock,memCLK;
   output [31:0] pc,inst,aluout,memout;
   output        imemCLK,dmemCLK;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   
   //I/O
   input clrn;
   input [31:0] in_port0,in_port1;
   output [31:0] out_port0,out_port1;
   output [31:0] mem_dataout;
   output [31:0] in_data;
   
   sc_cpu cpu (clock,1,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,memCLK,imemCLK);                  // instruction memory.
   sc_datamem  dmem (aluout,data,memout,wmem,clock,memCLK,dmemCLK ,1,out_port0,out_port1,in_port0,in_port1,mem_dataout,in_data); // data memory.

endmodule



