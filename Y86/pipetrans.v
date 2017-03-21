module pipetrans (resetn,clock,mem_clock, pc,inst,eAlu,mAlu,wAlu,
	clrn,out_port0,out_port1,in_port0,in_port1,mOut_data,in_data);//added line
	
	//IO
	input clrn;
	input [31:0] in_port0,in_port1;
	output [31:0] out_port0,out_port1;
	output [31:0] mOut_data;
	output [31:0] in_data;
	//added part
	
	input resetn, clock, mem_clock;
	output [31:0] pc,inst,eAlu,mAlu,wAlu;
	wire [31:0] bpc,jpc,npc,pc4,ins, inst;
	wire [31:0] dpc4,da,db,dimm;
	wire [31:0] epc4,ea,eb,eimm;
	wire [31:0] mB,mmo;
	wire [31:0] wmo,wdi;
	wire [4:0] drn,eRn0,ern,mrn,wrn;
	wire [3:0] daluc,eAluc;
	wire [1:0] pcsource;
	wire wpcir;
	wire dwreg,dm2reg,dwmem,daluimm,dshift,djal; // id stage
	wire ewreg,em2reg,ewmem,eAluimm,eshift,ejal; // exe stage
	wire mwreg,mm2reg,mwmem; // mem stage
	wire wwreg,wm2reg; // wb stage
	pipepc prog_cnt ( npc,wpcir,clock,resetn,pc );
	pipeif if_stage ( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock ); // IF stage
	pipeir inst_reg ( pc4,ins,wpcir,clock,resetn,dpc4,inst ); // IF/ID 流水线寄存器
	pipeid id_stage ( mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,
							wrn,wdi,eAlu,mAlu,mmo,wwreg,clock,resetn,
							bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
							daluimm,da,db,dimm,drn,dshift,djal ); // ID stage
	pipedereg de_reg ( dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,drn,dshift,
							djal,dpc4,clock,resetn,ewreg,em2reg,ewmem,eAluc,eAluimm,
							ea,eb,eimm,eRn0,eshift,ejal,epc4 ); // ID/EXE 流水线寄存器
	pipeexe exe_stage ( eAluc,eAluimm,ea,eb,eimm,eshift,eRn0,epc4,ejal,ern,eAlu ); // EXE stage
	pipeemreg em_reg ( ewreg,em2reg,ewmem,eAlu,eb,ern,clock,resetn,
							mwreg,mm2reg,mwmem,mAlu,mB,mrn); // EXE/MEM 流水线寄存器
	//pipemem mem_stage ( mwmem,mAlu,mB,clock,mem_clock,mmo ); // MEM stage
	pipemem mem_stage ( mwmem,mAlu,mB,clock,mem_clock,mmo, 
		clrn,out_port0,out_port1,in_port0,in_port1,mOut_data,in_data);//added line
	
	pipemwreg mw_reg ( mwreg,mm2reg,mmo,mAlu,mrn,clock,resetn,
							wwreg,wm2reg,wmo,wAlu,wrn); // MEM/WB 流水线寄存器
	mux2x32 wb_stage ( wAlu,wmo,wm2reg,wdi ); // WB stage
endmodule