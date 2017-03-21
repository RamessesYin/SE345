module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   reg [31:0] s;
   reg        z;
   always @ (a or b or aluc) 
      begin                                   
         casex (aluc)
             4'bx000: s = a + b;              //x000 ADD
             4'bx100: s = a - b;              //x100 SUB
             4'bx101: s = a | b;              //x101 OR
             4'bx010: s = a ^ b;              //x010 XOR
             //new:x111 even
             4'bx111: s = a[31]^a[30]^a[29]^a[28]^a[31]^a[30]^a[29]^a[28]^
                               ^a[27]^a[26]^a[25]^a[24]^a[23]^a[22]^a[21]^
                               ^a[20]^a[19]^a[18]^a[17]^a[16]^a[15]^a[14]^
                               ^a[13]^a[12]^a[11]^a[10]^a[9]^a[8]^a[7]^
                               ^a[6]^a[5]^a[4]^a[3]^a[2]^a[1]^a[0]^
                               ^b[30]^b[29]^b[28]^b[31]^b[30]^b[29]^b[28]^
                               ^b[27]^b[26]^b[25]^b[24]^b[23]^b[22]^b[21]^
                               ^b[20]^b[19]^b[18]^b[17]^b[16]^b[15]^b[14]^
                               ^b[13]^b[12]^b[11]^b[10]^b[9]^b[8]^b[7]^
                               ^b[6]^b[5]^b[4]^b[3]^b[2]^b[1]^b[0]

             4'bx110: s = b << 16;            //x110 LUI         
             4'bx001: s = a & b;              //x001 AND    
             4'b0011: s = b << a;             //0011 SLL
             4'b0111: s = b >> a;             //0111 SRL
             4'b1111: s = $signed(b) >>> a;   //1111 SRA
             default: s = 0;
         endcase
         if (s == 0 )  z = 1;
            else z = 0;         
      end      
endmodule 