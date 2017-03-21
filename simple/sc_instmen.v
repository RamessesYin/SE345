module sc_instmem (addr,inst,clock,memCLK,imemCLK);
   input  [31:0] addr;
   input         clock;
   input         memCLK;
   output [31:0] inst;
   output        imemCLK;
   
   wire          imemCLK;

   assign  imemCLK = clock & ( ~ memCLK );      
   
   lpm_rom_irom irom (addr[7:2],imemCLK,inst); 
   

endmodule 