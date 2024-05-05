`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 08:33:54 PM
// Design Name: 
// Module Name: mux
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


module mux(AR,PC,DR,AC,IR,TR,MEM,S,BUS);
input [15:0] DR,AC,IR,TR,MEM;
input [15:0] AR,PC;
input [2:0] S;
output reg [15:0] BUS;
always@(S)
begin
case(S)
3'b000:BUS=0;
3'b001:BUS=AR;
3'b010:BUS=PC;
3'b011:BUS=DR;
3'b100:BUS=AC;
3'b101:BUS=IR;
3'b110:BUS=TR;
3'b111:BUS=MEM;
default : BUS = 0;
endcase
end
endmodule
