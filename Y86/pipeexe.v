module pipeexe( eAluc,eAluimm,ea,eb,eimm,eshift,
						eRn0,epc4,ejal,ern,eAlu ); // EXE stage
	input ejal,eAluimm,eshift;
	input [3:0] eAluc;
	input [31:0] epc4,ea,eb,eimm;
	input [4:0] eRn0;
	
	output [31:0] eAlu;
	output [4:0] ern;
	
	wire [31:0] alua,alub,sa,eAlu0,epc8;
	wire z;
	
	assign sa={eimm[5:0],eimm[31:6]};
	exe ret_addr(epc4,32'h4,1'b0,epc8);//epac8<=epc4+4
	mux2x32 alu_ina(ea,sa,eshift,alua);
	mux2x32 alu_inb(eb,eimm,eAluimm,alub);
	mux2x32 save_pc8(eAlu0,epc8,ejal,eAlu);
	assign ern= eRn0 | {5{ejal}}; //清零 或 ern=eRn0
	alu exeAlu(alua,alub,eAluc,eAlu0,z);
	
endmodule