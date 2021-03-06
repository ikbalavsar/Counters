`timescale 1ns / 1ps

module Lab4_Part1_TB();

    reg [2:0] SW_TB;
    reg CLK100MHZ_TB  =0; 
    wire [7:0] LEDR_TB ; 

    Lab4_Part1 DUT (.SW(SW_TB),.LEDR(LEDR_TB) , .CLK100MHZ (CLK100MHZ_TB ));
    
    always #1000 CLK100MHZ_TB= ~CLK100MHZ_TB ; 
    initial 
        begin 
       SW_TB[0]  = 1'b1; //ENABLE 
       SW_TB[1]  <= 1'b1;  //CLK 
       SW_TB[2] = 1'b0 ; // reset
        end 

        always #1000 SW_TB[1]  <= ~SW_TB[1]; 
endmodule



