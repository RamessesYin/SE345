module num_to_16(inNum,outNum5,outNum4,outNum3,outNum2,outNum1,outNum0);
	input [31:0] inNum;
	output [6:0] outNum5,outNum4,outNum3,outNum2,outNum1,outNum0;
	
	reg [3:0] num5,num4,num3,num2,num1,num0;
	
	sevenseg display_dt_5( num5, outNum5 );
	sevenseg display_dt_4( num4, outNum4 );
	sevenseg display_dt_3( num3, outNum3 );
	sevenseg display_dt_2( num2, outNum2 );
	sevenseg display_dt_1( num1, outNum1 );
	sevenseg display_dt_0( num0, outNum0 );
	
	always @ (inNum)
	begin
		num5 = ( inNum/100000 ) % 10;
		num4 = ( inNum/10000 ) % 10;
		num3 = ( inNum/1000 ) % 10;
		num2 = ( inNum/100 ) % 10;
		num1 = ( inNum/10 ) % 10;
		num0 = inNum % 10;
	end
	
endmodule
