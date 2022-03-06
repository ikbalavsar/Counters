`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2021 11:39:37
// Design Name: 
// Module Name: Lab2_Part1
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


module Lab2_Part1(
    input [8:0] SW,
    output [4:0] LEDR 
    );
    
    wire OUT0, OUT1, OUT2, OUT3;
    wire CIN,COUT0,COUT1,COUT2,COUT3;
    
    wire [3:0] A;
    wire [3:0] B;
   
    assign A = SW[7:4];
    assign B = SW[3:0];
    assign CIN = SW[8];
    
    assign OUT0 = (A[0] ^ B[0])^ CIN;
    assign COUT0 = (A[0] && B[0]) || ((A[0] ^ B[0]) && CIN);
    assign LEDR[0] = OUT0;
    
    assign OUT1 = (A[1] ^ B[1])^ COUT0;
    assign COUT1 = (A[1] && B[1]) || ((A[1] ^ B[1]) && COUT0);
    assign LEDR[1] = OUT1;
    
    assign OUT2 = (A[2] ^ B[2])^ COUT1;
    assign COUT2 = (A[2] && B[2]) || ((A[2] ^ B[2]) && COUT1);
    assign LEDR[2] = OUT2;
    
    assign OUT3 = (A[3] ^ B[3])^ COUT2;
    assign COUT3 = (A[3] && B[3]) || ((A[3] ^ B[3]) && COUT2);
    assign LEDR[3] = OUT3;
    assign LEDR[4] = COUT3;    
    
endmodule



