module pipeid( mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,
inst,wrn,wdi,eAlu,mAlu,mmo,wwreg,clock,resetn,
bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
daluimm,da,db,dimm,drn,dshift,djal );
	input clock,resetn;
	input[31:0] dpc4,inst,wdi,eAlu,mAlu,mmo;
	input[4:0] ern,mrn,wrn;
	input mwreg,ewreg,em2reg,mm2reg,wwreg;
	
	output[31:0] bpc,jpc,da,db,dimm;
	output[4:0] drn;
	output[3:0] daluc;
	output[1:0] pcsource;
	output wpcir,dwreg,dm2reg,dwmem,daluimm,dshift,djal;
	
	wire[5:0] op,func;
	wire[4:0] rs,rt,rd;
	wire[31:0] q1,q2,br_offset;
	wire[15:0] ext16;
	wire[1:0] fwda,fwdb;
	wire regrt,sext,rertequ,e;
	assign func=inst[5:0];
	assign op=inst[31:26];
	assign rs=inst[25:21];
	assign rt=inst[20:16];
	assign rd=inst[15:11];
	assign jpc={dpc4[31:28],inst[25:0],2'b00};//拼接jpc
	
	id_analysis controlunit(op,func,rs,rt,
	mrn,mm2reg,mwreg,ern,em2reg,ewreg,rsrtequ,
	pcsource,wpcir,dwreg,dm2reg,dwmem,djal,
	daluc,daluimm,dshift,regrt,sext,fwdb,fwda);
	
	regfile reg_file(rs,rt,wdi,wrn,wwreg,~clock,resetn,q1,q2);
	mux2x5 decidedesreg(rd,rt,regrt,drn);
	mux4x32 decideAlua(q1,eAlu,mAlu,mmo,fwda,da);
	mux4x32 decideAlub(q2,eAlu,mAlu,mmo,fwdb,db);
	
	assign rsrtequ=~|(da^db);
	assign e=sext&inst[15];
	assign ext16={16{e}};
	assign dimm={ext16,inst[15:0]};
	assign br_offset={dimm[29:0],2'b00};
	exe br_addr(dpc4,br_offset,1'b0,bpc);
	
endmodule