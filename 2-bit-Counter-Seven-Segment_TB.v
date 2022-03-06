`timescale 1ns / 1ps

module Lab4_Part4_TB();

    reg CLK100MHZ_TB = 0;
    wire [0:6] HEX0_TB ; 
    wire [7:0] AN_TB ; 
    wire [1:0] LEDR_TB;
    
    Lab4_Part4 DUT (.CLK100MHZ(CLK100MHZ_TB) , .HEX0(HEX0_TB), .AN(AN_TB) , .LEDR(LEDR_TB));
    
    always #5 CLK100MHZ_TB = ~CLK100MHZ_TB; 
    
endmodule

