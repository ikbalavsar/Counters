`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2021 15:13:16
// Design Name: 
// Module Name: Lab4_Part4
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


module Lab4_Part4(CLK100MHZ, HEX0, AN,LEDR);

    input CLK100MHZ;
    output [0:6] HEX0;
    output [7:0] AN ; 
    output [1:0] LEDR; 
    
    reg [1:0] Counter = 2'b00; 
    wire divided_clk1; 
    wire divided_clk2; 
   
    clk_dividerr1 module1 (CLK100MHZ, divided_clk1); 
    clk_dividerr2 module2 (CLK100MHZ, divided_clk2); 
    
    always @(posedge divided_clk1 ) begin 
        Counter <= Counter +1 ; 
    end 
    
    assign LEDR[1:0] = Counter ; 
    
    AN_HEX_CONTROL module4 ( Counter, divided_clk2, HEX0, AN);
endmodule

module AN_HEX_CONTROL (Counter,divided_clk2, HEX0,AN ) ; 
     input [1:0] Counter;
     input divided_clk2; 
     output [0:6] HEX0 ;
     output [7:0] AN;
    
    reg [1:0] AN_COUNTER00 = 2'b00;
    reg [1:0] AN_COUNTER01 = 2'b00;
    reg [1:0] AN_COUNTER10 = 2'b00;
    reg [1:0] AN_COUNTER11 = 2'b00;
     
     reg [7:0] ANN;
     reg [0:6] HEXX;
     
     always @ ( posedge  divided_clk2 ) begin 
        AN_COUNTER00 <= AN_COUNTER00 +1 ; 
     end 
     always @ ( posedge divided_clk2 ) begin 
            AN_COUNTER01 <= AN_COUNTER01 +1 ; 
      end 
    always @ ( posedge  divided_clk2 ) begin 
                AN_COUNTER10 <= AN_COUNTER10 +1 ; 
     end 
     always @ ( posedge divided_clk2 ) begin 
                 AN_COUNTER11 <= AN_COUNTER11 +1 ; 
    end 
     
     always @( posedge divided_clk2 ) begin 
        if( Counter == 2'b00) begin 
            if ( AN_COUNTER00 == 2'b00) begin
                ANN <= 8'b11110111;
                HEXX = 7'b1000010 ; //d
            end 
            else if ( AN_COUNTER00 == 2'b01) begin 
                ANN <= 8'b11111011;
                HEXX = 7'b0110000; //e
            end 
            else if ( AN_COUNTER00 == 2'b10 ) begin 
                ANN <= 8'b11111101;
                HEXX = 7'b1001111; //1 
            end 
            else if ( AN_COUNTER00 == 2'b11  ) begin 
                ANN <= 8'b11111110;
                HEXX = 7'b0000001; //0
            end 
            
        end // Counter 00 
        if( Counter == 2'b01) begin 
            if ( AN_COUNTER01 == 2'b00) begin
                ANN <= 8'b11110111;
                HEXX = 7'b0110000; //e
            end 
            else if ( AN_COUNTER01 == 2'b01) begin 
                ANN <= 8'b11111011;
                HEXX = 7'b1001111; //1 
            end 
            else if ( AN_COUNTER01 == 2'b10  ) begin 
                ANN <= 8'b11111101;
                HEXX =7'b0000001; //0
            end 
            else if ( AN_COUNTER01 == 2'b11   ) begin 
                ANN <= 8'b11111110;
                HEXX = 7'b1000010 ; //d
            end 
            
        end // Counter 01
        if( Counter == 2'b10) begin 
            if ( AN_COUNTER10 == 2'b00) begin
                ANN <= 8'b11110111;
                HEXX = 7'b1001111; //1 
            end 
            else if ( AN_COUNTER10 == 2'b01) begin 
                ANN <= 8'b11111011;
                HEXX = 7'b0000001; //0
            end 
            else if ( AN_COUNTER10 == 2'b10 ) begin 
                ANN <= 8'b11111101;
                HEXX = 7'b1000010 ; //d
            end 
            else if ( AN_COUNTER10 == 2'b11  ) begin 
                ANN <= 8'b11111110;
                HEXX = 7'b0110000; //e 
            end 
            
        end // Counter 10
        if( Counter == 2'b11) begin
             if ( AN_COUNTER11 == 2'b00) begin
                   ANN <= 8'b11111110;
                   HEXX = 7'b1001111; //1
               end 
               else if ( AN_COUNTER11 == 2'b01) begin 
                   ANN <= 8'b11110111;
                   HEXX = 7'b0000001; //0
               end 
               else if ( AN_COUNTER11 == 2'b10  ) begin 
                   ANN <= 8'b11111011;
                   HEXX =  7'b1000010 ; //D
               end 
               else if ( AN_COUNTER11 == 2'b11 ) begin 
                   ANN <= 8'b11111101;
                   HEXX = 7'b0110000; //E
               end 
            
        end // Counter 10
     end //always 
     assign AN = ANN; 
     assign HEX0 = HEXX; 
endmodule 

module clk_dividerr1(
    input wire CLK100MHZ ,
    output reg divided_clk = 0  );
    
    integer counter_value = 0 ; 
    localparam div_value = 800000; // en yavaþ 2 bit counter  5 sýfýr
    
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
 
 module clk_dividerr2(
     input wire CLK100MHZ ,
     output reg divided_clk = 0  );
     
     integer counter_value = 0 ; 
     localparam div_value = 1000;   // Daha hýzlý hex ve an kontrol  3 sýfýr
     
     always@ (posedge CLK100MHZ )
     begin 
         if (counter_value == div_value) 
             counter_value <= 0 ; 
         else 
             counter_value <= counter_value +1 ;   
     end 
     
     always@ (posedge CLK100MHZ) 
     begin 
         if (counter_value == div_value) 
             divided_clk  <= ~divided_clk;
         else 
             divided_clk  <= divided_clk;
     end 
  endmodule 
  

    
  
