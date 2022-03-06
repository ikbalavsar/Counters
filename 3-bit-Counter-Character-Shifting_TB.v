`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2021 14:02:51
// Design Name: 
// Module Name: Lab4_Part5_TB
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


module Lab4_Part5_TB();

    reg CLK100MHZ_TB = 0 ; 
    wire [0:6] HEX0_TB ; 
    wire [7:0] AN_TB; 
    wire [2:0] LEDR_TB;
    
    Lab4_Part5 DUT (.CLK100MHZ ( CLK100MHZ_TB) , .HEX0( HEX0_TB) , .AN(AN_TB), .LEDR(LEDR_TB)); 
    
    always #5 CLK100MHZ_TB = ~CLK100MHZ_TB; 
    
endmodule
