`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2021 08:55:09
// Design Name: 
// Module Name: Lab4_Part2_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Lab4_Part2_TB();
    reg CLK100MHZ_TB  = 0;
   
    Lab4_Part2 DUT  (  .CLK100MHZ(CLK100MHZ_TB) ); 
    
   always #5 CLK100MHZ_TB= ~CLK100MHZ_TB ; 
   
endmodule


