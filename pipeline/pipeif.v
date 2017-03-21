module pipeif( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock ); 
	input [31:0] pc,bpc,da,jpc;
	input[1:0]pcsource;
	input mem_clock;
	output[31:0]npc,pc4,ins;
	
	mux4x32 selectnpc(pc4,bpc,da,jpc,pcsource,npc);
	exe pcplus4(pc,32'h4,1'b0,pc4);
	lpm_rom_irom irom(pc[7:2],mem_clock,ins);
endmodule