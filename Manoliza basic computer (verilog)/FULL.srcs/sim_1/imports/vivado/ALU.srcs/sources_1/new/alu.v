`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 09:07:44 AM
// Design Name: 
// Module Name: alu
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


module alu(
input [15:0] DR,AC,IR,
input [7:0]  D,
input E,clk,
output reg E_out,S,
output reg [15:0] ALU,
//output reg PC_inc
);
initial begin

S=1;
ALU <=0;
end

always @(posedge clk) begin
if(~D[7])begin

   case (D)
   
        8'h01 : ALU = ~(AC & DR);
        8'h02 : {E_out,ALU} = (DR + AC);
        8'h04 : ALU  =  (AC | DR);
        8'h08 : ALU = DR;
        8'h20 : ALU = (DR[7:0] * AC[7:0]);
   
   endcase
end
else begin 

    if(~(IR[15]))begin
        
        case(IR)
//            16'h7200 : PC_inc = AC[15] ? 0 : 1; 
            16'h7100 : begin
                            ALU = (AC >>1);
                            ALU[15] = E;
                            E_out = AC[0];                             
                        end
            16'h7080 : S = 0;
        
        
        endcase
    
    end


end


end
endmodule
