module pipeif( pcsource,pc,bpc,da,jpc,npc,pc4,ins,mem_clock ); 
	input [31:0] pc,bpc,da,jpc;
	input[1:0]pcsource;
	input mem_clock;
	output[31:0]npc,pc4,ins;
	wire[63:0]newIns;
	
	reg[31:0]INS;
	assign ins=INS;
	reg[31:0]pcOff;
	initial
	begin
		pcOff=0;
	end
	
	mux4x32 selectnpc(pc4,bpc,da,jpc,pcsource,npc);
	cla32 pcplus4(pc,pcOff,1'b0,pc4);
	lpm_rom_irom irom(pc[7:2],mem_clock,newIns);
	always@(*)
	begin
		case(newIns[47:40])
		8'h30:begin
				INS[31:26]<=6'b001000;
				INS[25:21]<=5'b00000;
				INS[20]<=1'b0;
				INS[19:16]<=newIns[35:32]+1;
				INS[7:0]<=newIns[31:24];
				INS[15:8]<=newIns[23:16];
				pcOff[31:0]<=32'b11000;
			end
		8'h40:begin
				INS[31:26]<=6'b101011;
				INS[25]<=1'b0;
				INS[24:21]<=newIns[35:32]+1;
				INS[20]<=1'b0;
				INS[19:16]<=newIns[39:36]+1;
				INS[7:0]<=newIns[31:24];
				INS[15:8]<=newIns[23:16];
				pcOff[31:0]<=32'b11000;
			end
		8'h50:begin
				INS[31:26]<=6'b100011;
				INS[25]<=1'b0;
				INS[24:21]<=newIns[35:32]+1;
				INS[20]<=1'b0;
				INS[19:16]<=newIns[39:36]+1;
				INS[7:0]<=newIns[31:24];
				INS[15:8]<=newIns[23:16];
				pcOff[31:0]<=32'b11000;
			end
		8'h00:
			begin
			if(newIns[39:32]==8'h70)
					begin
					INS[31:26]<=6'b000010;
					INS[7:0]<=newIns[31:24];
					INS[15:8]<=newIns[23:16];
					INS[23:16]<=newIns[15:8];
					INS[25:24]<=2'b00;
					pcOff[31:0]<=32'b10100;
					end
			else
				if(newIns[15:8]==8'h60)
					begin
						INS[31:26]<=6'b000000;
						INS[25]<=1'b0;
						INS[24:21]<=newIns[7:4]+1;
						INS[20]<=1'b0;
						INS[19:16]<=newIns[3:0]+1;
						INS[15]<=1'b0;
						INS[14:11]<=newIns[3:0]+1;
						INS[10:0]<=11'b00000100000;
						pcOff[31:0]<=32'b01000;
					end
				else
					if(newIns[7:0]==8'h10)
					begin
						INS<=0;
						pcOff[31:0]<=32'b00100;
					end
			end
		endcase
	end
endmodule