`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 12:05:59 AM
// Design Name: 
// Module Name: dff
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


module dff(D,clk,Q);
input D; // Data input 
input clk; // clock input 
output reg Q; // output Q 
initial begin 
Q <= 0;
end
always @(posedge clk) 
begin
 Q <= D; 
end 
endmodule 