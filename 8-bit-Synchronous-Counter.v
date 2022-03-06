`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2021 08:25:22
// Design Name: 
// Module Name: Lab4_Part1
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


module Lab4_Part1 (SW,CLK100MHZ,LEDR,AN,HEX0) ; 
     input CLK100MHZ  ; 
    input [2:0] SW;
    output [7:0] LEDR;
     output [0:6] HEX0;
     output [7:0] AN;
    
    wire Enable, CLK,Clear;
    wire divided_clk;
    
    wire Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8;
    wire [7:0]Qout ; 
    
    wire [0:6] HEX0; 
    wire[7:0] AN;
     
    assign Enable = SW[0]; 
    assign CLK = SW[1]; 
    assign Clear = SW[2]; 
    
    wire [7:0] Result; 
    
    T_Flip_Flop module2 (.CLK(CLK), .T(Enable) , .Q(Qout[0]),.Clear(Clear));
    assign Result[0] = Enable & Qout[0] ; 
    T_Flip_Flop module3 (.CLK(CLK), .T(Result[0]) , .Q(Qout[1]),.Clear(Clear));
    assign Result[1] = Result[0] & Qout[1] ; 
    T_Flip_Flop module4 (.CLK(CLK), .T(Result[1]) , .Q(Qout[2]), .Clear(Clear));
    assign Result[2] = Result[1] & Qout[2] ; 
    T_Flip_Flop module5 (.CLK(CLK), .T(Result[2]) , .Q(Qout[3]), .Clear(Clear));
    assign Result[3] = Result[2] & Qout[3] ; 
    T_Flip_Flop module6 (.CLK(CLK), .T(Result[3]) , .Q(Qout[4]),.Clear(Clear));
    assign Result[4] = Result[3] & Qout[4] ; 
    T_Flip_Flop module7 (.CLK(CLK), .T(Result[4]) , .Q(Qout[5]),.Clear(Clear));
    assign Result[5] = Result[4] & Qout[5] ; 
    T_Flip_Flop module8 (.CLK(CLK), .T(Result[5]) , .Q(Qout[6]),.Clear(Clear));
    assign Result[6] = Result[5] & Qout[6] ; 
    T_Flip_Flop module9 (.CLK(CLK), .T(Result[6]) , .Q(Qout[7]),.Clear(Clear));
    assign LEDR = Qout; 
    
   clk_divider module1 (CLK100MHZ ,divided_clk); 
   display_AN_HEX0 module10 (Qout,divided_clk,HEX0,AN);
endmodule

module T_Flip_Flop ( Clear, T, CLK,  Q ) ;
    input Clear;
    input CLK ; 
    input T ; // T deðeri Enable 
    output reg Q ; 
  
  initial
     begin 
    Q <= 1'b0; 
    end 
    
    always@(posedge CLK) begin 
        if ( Clear == 1'b1   ) 
            Q <= 1'b0;
        else if ( T == 1 ) begin 
            Q <= ~Q ; end 
        else 
           Q <= Q  ;
        end 
endmodule 

module display_AN_HEX0(Qout,divided_clk ,HEX0,AN);
    input [7:0] Qout; 
    input divided_clk ;
    output [0:6] HEX0 ;
    output [7:0] AN ;
    
    reg [1:0] COUNT = 2'b00; 
    wire [3:0]Part1 , Part2 ; 
    reg [7:0] ANN; 
    reg [0:6] HEXX; 
    assign Part1 = Qout[7:4]; 
    assign Part2 = Qout[3:0]; 

    always@ ( posedge divided_clk  ) begin 
        COUNT <= COUNT +1 ; 
        if( COUNT == 2'b01) begin 
            ANN <= 8'b11111101;
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
        else if ( COUNT == 2'b10) begin 
            ANN <= 8'b11111110;
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
    end 
    assign HEX0 = HEXX; 
    assign AN = ANN ; 
endmodule 

module clk_divider(
    input wire CLK100MHZ ,
    output reg divided_clk = 0  );

    integer counter_value = 0 ; 
    localparam div_value = 1000;
    
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

