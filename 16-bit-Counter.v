`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2021 08:54:40
// Design Name: 
// Module Name: Lab4_Part2
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


module Lab4_Part2(HEX0,AN,CLK100MHZ );
    input CLK100MHZ ; //test benchte 0 dan baþlat 
    output [0:6] HEX0;
    output [7:0] AN; 
    
    wire divided_clk1 ; 
    wire divided_clk2 ; 
    
    reg [15:0] Qout = 16'b0000000000000000 ; 
    
    clk_divider2 module1 (CLK100MHZ,divided_clk2);
    
    always@(posedge divided_clk2) begin 
        Qout <= Qout +1 ; 
    end 
    
    clk_divider1 module2 (CLK100MHZ,divided_clk1);
    AN_HEX0_CONTROLLER module3 (Qout,divided_clk1,AN,HEX0);
endmodule

module AN_HEX0_CONTROLLER (Qout,divided_clk1,AN,HEX0);

    input [15:0] Qout;
    input divided_clk1;
    output [0:6] HEX0; 
    output [7:0] AN; 
    
    reg [1:0] COUNT = 2'b00;
    reg [7:0] ANN;
    reg [0:6] HEXX; 
    wire [3:0] Part1,Part2,Part3,Part4; 
    
    assign Part1 = Qout[15:12];
    assign Part2 = Qout[11:8];
    assign Part3 = Qout[7:4];
    assign Part4 = Qout[3:0];
    
    always @(posedge divided_clk1) begin 
        if(COUNT == 2'b00) begin 
            ANN <= 8'b11110111;
            HEXX = (Part1 == 4'b0000) ? 7'b0000001:
                  (Part1 == 4'b0001) ? 7'b1001111:
                  (Part1 == 4'b0010) ? 7'b0010010:
                  (Part1 == 4'b0011) ? 7'b0000110:
                  (Part1 == 4'b0100) ? 7'b1001100:
                  (Part1 == 4'b0101) ? 7'b0100100:
                  (Part1 == 4'b0110) ? 7'b0100000:
                  (Part1 == 4'b0111) ? 7'b0001111:
                  (Part1 == 4'b1000) ? 7'b0000000:
                  (Part1 == 4'b1001) ?  7'b0000100:
                  (Part1== 4'b1010) ? 7'b0001000: //10 A
                  (Part1 == 4'b1011) ? 7'b1100000: //11 b
                  (Part1 == 4'b1100) ? 7'b0110001:  //12 C
                  (Part1 == 4'b1101) ? 7'b1000010:  //13 d
                  (Part1 == 4'b1110) ? 7'b0110000:  //14 E
                 (Part1 == 4'b1111) ? 7'b0111000:  //15 F
                  7'bX;
        end 
        else if (COUNT == 2'b01) begin 
            ANN <= 8'b11111011;
            HEXX = (Part2 == 4'b0000) ? 7'b0000001:
                  (Part2 == 4'b0001) ? 7'b1001111:
                  (Part2 == 4'b0010) ? 7'b0010010:
                  (Part2 == 4'b0011) ? 7'b0000110:
                  (Part2 == 4'b0100) ? 7'b1001100:
                  (Part2 == 4'b0101) ? 7'b0100100:
                  (Part2 == 4'b0110) ? 7'b0100000:
                  (Part2 == 4'b0111) ? 7'b0001111:
                  (Part2 == 4'b1000) ? 7'b0000000:
                  (Part2 == 4'b1001) ?  7'b0000100:
                  (Part2== 4'b1010) ? 7'b0001000: //10 A
                  (Part2 == 4'b1011) ? 7'b1100000: //11 b
                  (Part2 == 4'b1100) ? 7'b0110001:  //12 C
                  (Part2 == 4'b1101) ? 7'b1000010:  //13 d
                  (Part2 == 4'b1110) ? 7'b0110000:  //14 E
                 (Part2 == 4'b1111) ? 7'b0111000:  //15 F
                  7'bX;
        end  
        else if ( COUNT == 2'b10 ) begin 
             ANN <= 8'b11111101;
           HEXX = (Part3 == 4'b0000) ? 7'b0000001:
                 (Part3 == 4'b0001) ? 7'b1001111:
                 (Part3 == 4'b0010) ? 7'b0010010:
                 (Part3 == 4'b0011) ? 7'b0000110:
                 (Part3 == 4'b0100) ? 7'b1001100:
                 (Part3 == 4'b0101) ? 7'b0100100:
                 (Part3 == 4'b0110) ? 7'b0100000:
                 (Part3 == 4'b0111) ? 7'b0001111:
                 (Part3 == 4'b1000) ? 7'b0000000:
                 (Part3 == 4'b1001) ?  7'b0000100:
                 (Part3== 4'b1010) ? 7'b0001000: //10 A
                 (Part3 == 4'b1011) ? 7'b1100000: //11 b
                 (Part3 == 4'b1100) ? 7'b0110001:  //12 C
                 (Part3 == 4'b1101) ? 7'b1000010:  //13 d
                 (Part3 == 4'b1110) ? 7'b0110000:  //14 E
                (Part3 == 4'b1111) ? 7'b0111000:  //15 F
                 7'bX;
        end 
        else if (COUNT == 2'b11) begin 
           ANN <= 8'b11111110;
        HEXX = (Part4 == 4'b0000) ? 7'b0000001:
              (Part4 == 4'b0001) ? 7'b1001111:
              (Part4 == 4'b0010) ? 7'b0010010:
              (Part4 == 4'b0011) ? 7'b0000110:
              (Part4 == 4'b0100) ? 7'b1001100:
              (Part4 == 4'b0101) ? 7'b0100100:
              (Part4 == 4'b0110) ? 7'b0100000:
              (Part4 == 4'b0111) ? 7'b0001111:
              (Part4 == 4'b1000) ? 7'b0000000:
              (Part4 == 4'b1001) ?  7'b0000100:
              (Part4== 4'b1010) ? 7'b0001000: //10 A
              (Part4 == 4'b1011) ? 7'b1100000: //11 b
              (Part4 == 4'b1100) ? 7'b0110001:  //12 C
              (Part4 == 4'b1101) ? 7'b1000010:  //13 d
              (Part4 == 4'b1110) ? 7'b0110000:  //14 E
             (Part4 == 4'b1111) ? 7'b0111000:  //15 F
              7'bX;
        end 
        COUNT <= COUNT +1; 
    end 
   assign HEX0 = HEXX; 
   assign AN = ANN ; 
endmodule 

module clk_divider1(
    input wire CLK100MHZ ,
    output reg divided_clk = 0  );
    
    integer counter_value = 0 ; 
    localparam div_value = 50000;
    
    always@ (posedge CLK100MHZ )
    begin 
        if (counter_value == div_value) 
            counter_value <= 0 ; 
        else 
            counter_value <= counter_value +1 ;   
    end 
    always@ (posedge CLK100MHZ ) 
    begin 
        if (counter_value == div_value) 
            divided_clk  <= ~divided_clk;
        else 
            divided_clk  <= divided_clk;
    end 
 endmodule 
 
 
 module clk_divider2(     //faster because of div_value 
     input wire CLK100MHZ ,
     output reg divided_clk = 0  );
     
     integer counter_value = 0 ; 
     localparam div_value = 10000;
     
     always@ (posedge CLK100MHZ )
     begin 
         if (counter_value == div_value) 
             counter_value <= 0 ; 
         else 
             counter_value <= counter_value +1 ;   
     end 
     always@ (posedge CLK100MHZ ) 
     begin 
         if (counter_value == div_value) 
             divided_clk  <= ~divided_clk;
         else 
             divided_clk  <= divided_clk;
     end 
  endmodule 