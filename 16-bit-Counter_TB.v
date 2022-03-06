`timescale 1ns / 1ps

module Lab4_Part2_TB();
    reg CLK100MHZ_TB  = 0;
   
    Lab4_Part2 DUT  (  .CLK100MHZ(CLK100MHZ_TB) ); 
    
   always #5 CLK100MHZ_TB= ~CLK100MHZ_TB ; 
   
endmodule


