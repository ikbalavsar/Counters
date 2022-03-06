`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2021 09:00:41
// Design Name: 
// Module Name: Lab4_Part5
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


module Lab4_Part5(CLK100MHZ,LEDR, AN,HEX0);

    input CLK100MHZ;
    output [2:0] LEDR;
    output [7:0] AN ; 
    output [0:6] HEX0 ; 
    
    reg [2:0] Count_3bit = 3'b000;
    wire divided_clk_counter;
    wire divided_clk_AN;
    
    clk_divider_Counter module1 ( CLK100MHZ, divided_clk_counter ) ; 
    
    always @ ( posedge divided_clk_counter ) begin 
        if (    Count_3bit >= 3'b101)
            Count_3bit <= 3'b000;
        else 
        Count_3bit <= Count_3bit + 1 ; 
    end 
    
    clk_divider_AN module2 ( CLK100MHZ, divided_clk_AN);
    AN_HEX_CONTROLL module4 (Count_3bit, divided_clk_AN, AN, HEX0) ; 
    assign LEDR  = Count_3bit; 
endmodule


module AN_HEX_CONTROLL(Count_3bit,divided_clk_AN, AN, HEX0);
    input [2:0] Count_3bit;
    input divided_clk_AN; 
    output [7:0] AN;
    output [0:6] HEX0; 
    
    reg [1:0] Counter0 = 2'b00; 
    reg [1:0] Counter1 = 2'b00; 
    reg [1:0] Counter2 = 2'b00;   
    reg [1:0] Counter3 = 2'b00; 
    reg [1:0] Counter4 = 2'b00;  
    reg [1:0] Counter5 = 2'b00;   
    reg [7:0] ANN; 
    reg [0:6] HEXX; 
    
    always @ ( posedge divided_clk_AN) begin
        Counter0 <= Counter0 +1 ; 
    end 
    always @ ( posedge divided_clk_AN) begin
            Counter1 <= Counter1 +1 ;
    end 
    always @ ( posedge divided_clk_AN) begin 
                Counter2 <= Counter2 +1 ; 
        end 
    always @ ( posedge divided_clk_AN) begin 
                Counter3 <= Counter3 +1 ; 
        end 
    always @ ( posedge divided_clk_AN) begin 
            Counter4 <= Counter4 +1 ; 
    end 
     always @ ( posedge divided_clk_AN) begin 
               Counter5 <= Counter5 +1 ; 
       end 
               
    always @( posedge divided_clk_AN ) begin
        if ( Count_3bit == 3'b000) begin 
            if (Counter0 == 2'b00 ) begin
                ANN <= 8'b11110111;
                HEXX = 7'b1000010; //d 
            end 
            else if ( Counter0 == 2'b01) begin 
                ANN <= 8'b11111011;
                HEXX = 7'b0110000; //e 
            end 
            else if (Counter0 == 2'b10 ) begin 
                ANN <= 8'b11111101;
                HEXX = 7'b1001111; //1 
            end 
            else if ( Counter0 == 2'b11) begin 
                 ANN <= 8'b11111110;
                 HEXX = 7'b0000001; //0
            end 
        end //count3bit 000

    else if (Count_3bit == 3'b001) begin 
        if (Counter1 == 2'b00 ) begin
            ANN <= 8'b11101111;
            HEXX = 7'b1000010; //d 
        end 
        else if ( Counter1 == 2'b01) begin 
            ANN <= 8'b11110111;
            HEXX = 7'b0110000; //e 
        end 
        else if (Counter1 == 2'b10) begin 
            ANN <= 8'b11111011;
            HEXX = 7'b1001111; //1 
        end 
        else if ( Counter1 == 2'b11) begin 
             ANN <= 8'b11111101;
             HEXX = 7'b0000001; //0
        end 
    end //Count3 bit  001
    
    else if (Count_3bit == 3'b010) begin 
        if (Counter2 == 2'b00 ) begin
            ANN <= 8'b11011111;
            HEXX = 7'b1000010; //d 
        end 
        else if ( Counter2 == 2'b01) begin 
            ANN <= 8'b11101111;
            HEXX = 7'b0110000; //e 
        end 
        else if (Counter2 == 2'b10) begin 
            ANN <= 8'b11110111;
            HEXX = 7'b1001111; //1 
        end 
        else if ( Counter2 == 2'b11) begin 
             ANN <= 8'b11111011;
             HEXX = 7'b0000001; //0
        end 
    end //Count3 bit  010
    
    else if (Count_3bit == 3'b011) begin 
        if (Counter3 == 2'b00 ) begin
            ANN <= 8'b11011111;
            HEXX = 7'b0110000; //e
        end 
        else if ( Counter3 == 2'b01) begin 
            ANN <= 8'b11101111;
            HEXX = 7'b1001111; //1 
        end 
        else if (Counter3 == 2'b10) begin 
            ANN <= 8'b11110111;
            HEXX = 7'b0000001; //0 
        end 
        else if ( Counter3 == 2'b11) begin 
             ANN <= 8'b11111110;
             HEXX = 7'b1000010; //d
        end 
    end //Count3 bit  011
    
     else if (Count_3bit == 3'b100) begin 
       if (Counter4 == 2'b00 ) begin
           ANN <= 8'b11011111;
           HEXX = 7'b1001111; //1
       end 
       else if ( Counter4 == 2'b01) begin 
           ANN <= 8'b11101111;
           HEXX = 7'b0000001; //0 
       end 
       else if (Counter4 == 2'b10) begin 
           ANN <= 8'b11111101;
           HEXX = 7'b1000010; //d
       end 
       else if ( Counter4 == 2'b11) begin 
            ANN <= 8'b11111110;
            HEXX = 7'b0110000; //e
       end 
       end //Count3 bit  100
       
    else if (Count_3bit == 3'b101) begin 
         if (Counter5 == 2'b00 ) begin
             ANN <= 8'b11011111;
             HEXX =  7'b0000001; //0 
         end 
         else if ( Counter5 == 2'b01) begin 
             ANN <= 8'b11111011;
             HEXX = 7'b1000010; //d
         end 
         else if (Counter5 == 2'b10) begin 
             ANN <= 8'b11111101;
             HEXX =  7'b0110000; //e
         end 
         else if ( Counter5 == 2'b11) begin 
              ANN <= 8'b11111110;
              HEXX = 7'b1001111; //1
         end 
         end //Count3 bit  100
    end // always 
    
    assign HEX0 = HEXX;
    assign AN = ANN;

endmodule 


module clk_divider_Counter(
    input wire CLK100MHZ ,
    output reg divided_clk = 0  );
    
    integer counter_value = 0 ; 
    localparam div_value = 40000000; //40.10^6 
    
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

 module clk_divider_AN(
     input wire CLK100MHZ ,
     output reg divided_clk = 0  );
     
     integer counter_value = 0 ; 
     localparam div_value = 50000; //5.10^6
     
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
  
  