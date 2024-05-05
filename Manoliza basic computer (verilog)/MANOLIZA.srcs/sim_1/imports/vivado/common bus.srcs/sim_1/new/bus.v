`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 12:50:07 PM
// Design Name: 
// Module Name: bus
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


module bus(
input [7:0] X,
input [15:0] AR,PC,DR,AC,IR,TR,MEM,
output reg [15:0] bus
);
always @* begin
case(X)

  16'h01 : bus = 0;
  16'h02 : bus = AR;
  16'h04 : bus = PC;
  16'h08 : bus = DR;
  16'h10 : bus = AC;
  16'h20 : bus = IR;
  16'h40 : bus = TR;
  16'h80 : bus = MEM;
  default bus=0;

  

endcase
end





endmodule
