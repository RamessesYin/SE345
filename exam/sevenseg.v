//4bit 的 BCD 码至 7 段 LED 数码管译码器模块
module sevenseg ( data, ledsegments);
input [3:0] data;
output ledsegments;
reg [6:0] ledsegments;
always @ (*)
case(data)


//改变 led 显示

0: ledsegments = 7'b000_0110; // E
1: ledsegments = 7'b100_0000; // 0
default: ledsegments = 7'b111_1111; // 其它值时全灭。
endcase
endmodule
