`timescale 1ns / 1ps

module Lab3_Part5_TB2();
    reg [9:0] SW_TB ;
    reg CLK100MHZ =0 ;
    wire LEDR_TB;
    wire [7:0] AN_TB ; 
    wire [0:6] HEX0_TB;
  
    Lab3_Part5_2 DUT (.SW(SW_TB) , .LEDR(LEDR_TB), .CLK100MHZ(CLK100MHZ), .HEX0(HEX0_TB), .AN(AN_TB));
    
    always #5 CLK100MHZ = ~CLK100MHZ ; 
    initial 
        begin 
        SW_TB[9] <= 1'b1 ; 
        SW_TB[8] <= 1'b1 ; 
       
        SW_TB[7:0] = 8'b11010001;
        #10
        SW_TB[7:0] = 8'b10001001;
        end 
        
        always #10 SW_TB[9] <= ~SW_TB[9];
        always #30 SW_TB[8]<= SW_TB[8] ;
endmodule

