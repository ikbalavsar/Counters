`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2021 13:52:05
// Design Name: 
// Module Name: LAB2_PART1_TB
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


module LAB2_PART1_TB();
    reg [8:0] SW_TB;
    wire [4:0] LEDR_TB;
    
    Lab2_Part1 DUT (.SW(SW_TB), .LEDR(LEDR_TB));
    
    initial 
        begin
            SW_TB = 9'b010100101;
            #10
            SW_TB = 9'b110100101;
            #10
            SW_TB = 9'b100111001;
        end
endmodule


