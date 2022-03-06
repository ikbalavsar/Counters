`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2021 08:05:00
// Design Name: 
// Module Name: Lab3_Part5_2
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


module Lab3_Part5_2(SW,CLK100MHZ,LEDR, HEX0, AN);
    input [9:0] SW;
    input CLK100MHZ;
    output LEDR;
    output [0:6] HEX0;
    output [7:0] AN;
    
    wire CLK;
    wire reset;
    wire [7:0] SUM;
    wire COUT;
    reg [7:0] INPUT_Q;
    reg [7:0]  INPUT_A,INPUT_B;
    wire [7:0] A ,B,sum2 ;
    wire [0:6] HEX0;
    wire [7:0] AN;
    wire divided_clk;
   
    integer cnt = 0;
    
    assign CLK = SW[9];
    assign reset = SW[8];
   
    always @(posedge CLK or negedge reset) 
    begin 
        if(!reset) begin
        INPUT_A <= 8'b00000000;
        INPUT_B <= 8'b00000000;
        cnt <= 0;
        end 
        else
        begin 
            if(cnt == 0 ) begin
                INPUT_A <= SW[7:0];  //A
                cnt <= cnt + 1 ;  end
                INPUT_Q <= INPUT_A;
            if (cnt == 1 ) begin
                INPUT_B <= SW[7:0]; //B 
                INPUT_Q <= INPUT_B;
                end
        end 
    end 
    
    assign A = INPUT_A;
    assign B = INPUT_B;
    
    clk_divider module1 (CLK100MHZ,divided_clk );
    adder_8_bit module2(INPUT_A,INPUT_B,SUM,COUT);
    assign sum2 = SUM;
    AN_CONTROLLER module3 (divided_clk,A,B,sum2,HEX0,AN);
    assign LEDR = COUT;
endmodule

module adder_8_bit(INPUT_A,INPUT_B,SUM, COUT);
    input [7:0] INPUT_A;
    input [7:0] INPUT_B ;
    output [7:0] SUM;
    output COUT ;
    
    wire OUT0,OUT1,OUT2,OUT3,OUT4,OUT5,OUT6,OUT7;
    wire CIN,COUT0,COUT1,COUT2,COUT3,COUT4,COUT5,COUT6;
       
   assign CIN = 1'b0;
   
    assign OUT0 = (INPUT_A[0] ^ INPUT_B[0])^ CIN;
    assign COUT0 = (INPUT_A[0] && INPUT_B[0]) || ((INPUT_A[0] ^ INPUT_B[0]) && CIN);
    assign OUT1 = (INPUT_A[1] ^ INPUT_B[1])^ COUT0;
    assign COUT1 = (INPUT_A[1] && INPUT_B[1]) || ((INPUT_A[1] ^ INPUT_B[1]) && COUT0);
    assign OUT2 = (INPUT_A[2] ^ INPUT_B[2])^ COUT1;
    assign COUT2 = (INPUT_A[2] && INPUT_B[2]) || ((INPUT_A[2] ^ INPUT_B[2]) && COUT1);
    assign OUT3 = (INPUT_A[3] ^INPUT_B[3])^ COUT2;
    assign COUT3 = (INPUT_A[3] && INPUT_B[3]) || ((INPUT_A[3] ^ INPUT_B[3]) && COUT2);
    assign OUT4 = (INPUT_A[4] ^ INPUT_B[4] ^ COUT3);
    assign COUT4 = (INPUT_A[4] && INPUT_B[4]) || ((INPUT_A[4] ^INPUT_B[4])&& COUT3);
    assign OUT5 = (INPUT_A[5] ^ INPUT_B[5])^ COUT4;
    assign COUT5 = (INPUT_A[5] && INPUT_B[5]) || ((INPUT_A[5] ^ INPUT_B[5]) && COUT4);
    assign OUT6 = (INPUT_A[6] ^ INPUT_B[6])^ COUT5;
    assign COUT6 = (INPUT_A[6] && INPUT_B[6]) || ((INPUT_A[6] ^ INPUT_B[6]) && COUT5);
    assign OUT7 = (INPUT_A[7] ^ INPUT_B[7])^ COUT6;
    assign COUT = (INPUT_A[7] && INPUT_B[7]) || ((INPUT_A[7] ^ INPUT_B[7]) && COUT6);      
          
    assign SUM[0]= OUT0;
    assign SUM[1]= OUT1;
    assign SUM[2]= OUT2;
    assign SUM[3]= OUT3;
    assign SUM[4]= OUT4;
    assign SUM[5]= OUT5;
    assign SUM[6]= OUT6;
    assign SUM[7]= OUT7;
endmodule 

module AN_CONTROLLER (divided_clk,A,B,sum2, HEX0,AN );
    input divided_clk;
    input [7:0] A;
    input [7:0] B;
    input [7:0] sum2;
    output [0:6] HEX0;
    output [7:0] AN ; 
    
    reg [7:0] ANN;
    reg [0:6]HEXX;
    reg [2:0] COUNT = 3'b000 ;
    
    wire [3:0] A_PART1 ,A_PART2,B_PART1,B_PART2,SUM_PART1,SUM_PART2;
    
    assign A_PART1 = A[7:4] ;
    assign A_PART2 = A[3:0] ;
    assign B_PART1 = B[7:4] ;
    assign B_PART2 = B[3:0] ;
    assign SUM_PART1 = sum2[7:4] ;
    assign SUM_PART2 = sum2[3:0] ;

    always @ ( posedge divided_clk) begin
            if(COUNT  == 3'b000) begin 
            ANN <= 8'b11011111;
            HEXX = (A_PART1 == 4'b0000) ? 7'b0000001:
                  (A_PART1 == 4'b0001) ? 7'b1001111:
                  (A_PART1 == 4'b0010) ? 7'b0010010:
                  (A_PART1 == 4'b0011) ? 7'b0000110:
                  (A_PART1 == 4'b0100) ? 7'b1001100:
                  (A_PART1 == 4'b0101) ? 7'b0100100:
                  (A_PART1 == 4'b0110) ? 7'b0100000:
                  (A_PART1 == 4'b0111) ? 7'b0001111:
                  (A_PART1 == 4'b1000) ? 7'b0000000:
                  (A_PART1 == 4'b1001) ?  7'b0000100:
                  (A_PART1 == 4'b1010) ? 7'b0001000: //10 A
                  (A_PART1 == 4'b1011) ? 7'b1100000: //11 d
                  (A_PART1 == 4'b1100) ? 7'b0110001:  //12 C
                  (A_PART1 == 4'b1101) ? 7'b1000010:  //13 d
                  (A_PART1 == 4'b1110) ? 7'b0110000:  //14 E
                 (A_PART1 == 4'b1111) ? 7'b0111000:  //15 F
                  7'bX; end   
       if(COUNT == 3'b001) begin 
       ANN <= 8'b11101111;
       HEXX = (A_PART2 == 4'b0000) ? 7'b0000001:
              (A_PART2 == 4'b0001) ? 7'b1001111:
              (A_PART2 == 4'b0010) ? 7'b0010010:
              (A_PART2 == 4'b0011) ? 7'b0000110:
              (A_PART2 == 4'b0100) ? 7'b1001100:
              (A_PART2 == 4'b0101) ? 7'b0100100:
             (A_PART2 == 4'b0110) ? 7'b0100000:
             (A_PART2 == 4'b0111) ? 7'b0001111: 
              (A_PART2 == 4'b1000) ? 7'b0000000:
              (A_PART2 == 4'b1001) ?  7'b0000100: 
              (A_PART2 == 4'b1010) ? 7'b0001000: //10 A
               (A_PART2 == 4'b1011) ? 7'b1100000: //11 d
               (A_PART2 == 4'b1100) ? 7'b0110001:  //12 C
               (A_PART2 == 4'b1101) ? 7'b1000010:  //13 d
               (A_PART2== 4'b1110) ? 7'b0110000:  //14 E
               (A_PART2 == 4'b1111) ? 7'b0111000:  //15 F
              7'bX;  end                       
       if(COUNT == 3'b010) begin 
        ANN <= 8'b11110111;
        HEXX = (B_PART1  == 4'b0000) ? 7'b0000001:
               (B_PART1  == 4'b0001) ? 7'b1001111:
               (B_PART1  == 4'b0010) ? 7'b0010010:
               (B_PART1  == 4'b0011) ? 7'b0000110:
               (B_PART1  == 4'b0100) ? 7'b1001100:
               (B_PART1  == 4'b0101) ? 7'b0100100:
               (B_PART1  == 4'b0110) ? 7'b0100000:
               (B_PART1  == 4'b0111) ? 7'b0001111: 
               (B_PART1  == 4'b1000) ? 7'b0000000:
               (B_PART1  == 4'b1001) ?  7'b0000100: 
               (B_PART1  == 4'b1010) ? 7'b0001000: //10 A
               (B_PART1  == 4'b1011) ? 7'b1100000: //11 d
               (B_PART1  == 4'b1100) ? 7'b0110001:  //12 C
               (B_PART1  == 4'b1101) ? 7'b1000010:  //13 d
               (B_PART1 == 4'b1110) ? 7'b0110000:  //14 E
               (B_PART1  == 4'b1111) ? 7'b0111000:  //15 F
                7'bX; end                                              
       if(COUNT == 3'b011) begin 
         ANN <= 8'b11111011;
         HEXX = (B_PART2  == 4'b0000) ? 7'b0000001:
                (B_PART2   == 4'b0001) ? 7'b1001111:
                (B_PART2   == 4'b0010) ? 7'b0010010:
                (B_PART2    == 4'b0011) ? 7'b0000110:
                (B_PART2    == 4'b0100) ? 7'b1001100:
                (B_PART2    == 4'b0101) ? 7'b0100100:
                (B_PART2    == 4'b0110) ? 7'b0100000:
                (B_PART2    == 4'b0111) ? 7'b0001111: 
                (B_PART2    == 4'b1000) ? 7'b0000000:
                (B_PART2    == 4'b1001) ?  7'b0000100: 
                (B_PART2    == 4'b1010) ? 7'b0001000: //10 A
                (B_PART2    == 4'b1011) ? 7'b1100000: //11 d
                (B_PART2   == 4'b1100) ? 7'b0110001:  //12 C
                (B_PART2    == 4'b1101) ? 7'b1000010:  //13 d
                (B_PART2  == 4'b1110) ? 7'b0110000:  //14 E
                (B_PART2    == 4'b1111) ? 7'b0111000:  //15 F
               7'bX; end                                                   
       if(COUNT == 3'b100) begin 
          ANN <= 8'b11111101;
          HEXX = (SUM_PART1  == 4'b0000) ? 7'b0000001:
                  (SUM_PART1   == 4'b0001) ? 7'b1001111:
                  (SUM_PART1   == 4'b0010) ? 7'b0010010:
                  (SUM_PART1     == 4'b0011) ? 7'b0000110:
                  (SUM_PART1     == 4'b0100) ? 7'b1001100:
                  (SUM_PART1     == 4'b0101) ? 7'b0100100:
                  (SUM_PART1    == 4'b0110) ? 7'b0100000:
                  (SUM_PART1    == 4'b0111) ? 7'b0001111: 
                  (SUM_PART1     == 4'b1000) ? 7'b0000000:
                  (SUM_PART1     == 4'b1001) ?  7'b0000100: 
                   (SUM_PART1     == 4'b1010) ? 7'b0001000: //10 A
                   (SUM_PART1     == 4'b1011) ? 7'b1100000: //11 d
                   (SUM_PART1    == 4'b1100) ? 7'b0110001:  //12 C
                   (SUM_PART1    == 4'b1101) ? 7'b1000010:  //13 d
                   (SUM_PART1   == 4'b1110) ? 7'b0110000:  //14 E
                   (SUM_PART1   == 4'b1111) ? 7'b0111000:  //15 F
                    7'bX; end          
        if(COUNT == 3'b101) begin 
        ANN <= 8'b11111110;
        HEXX = (SUM_PART2  == 4'b0000) ? 7'b0000001:
                (SUM_PART2  == 4'b0001) ? 7'b1001111:
                (SUM_PART2   == 4'b0010) ? 7'b0010010:
                (SUM_PART2     == 4'b0011) ? 7'b0000110:
                 (SUM_PART2    == 4'b0100) ? 7'b1001100:
                 (SUM_PART2     == 4'b0101) ? 7'b0100100:
                 (SUM_PART2    == 4'b0110) ? 7'b0100000:
                 (SUM_PART2    == 4'b0111) ? 7'b0001111: 
                 (SUM_PART2    == 4'b1000) ? 7'b0000000:
                 (SUM_PART2    == 4'b1001) ?  7'b0000100: 
                  (SUM_PART2    == 4'b1010) ? 7'b0001000: //10 A
                  (SUM_PART2    == 4'b1011) ? 7'b1100000: //11 d
                   (SUM_PART2   == 4'b1100) ? 7'b0110001:  //12 C
                   (SUM_PART2   == 4'b1101) ? 7'b1000010:  //13 d
                    (SUM_PART2   == 4'b1110) ? 7'b0110000:  //14 E
                   (SUM_PART2  == 4'b1111) ? 7'b0111000:  //15 F
                   7'bX;  end  
            COUNT <= COUNT +1;   
        end
        assign AN = ANN; 
        assign HEX0  = HEXX ; 
endmodule 


module clk_divider(
    input wire CLK100MHZ,
    output reg divided_clk = 0  );

    integer counter_value = 0 ; 
    localparam div_value = 10000;
    
    always@ (posedge CLK100MHZ)
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

