`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 11:02:36 PM
// Design Name: 
// Module Name: sc
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


module sc (
input CLK,
input clr,
output reg [15:0] T

);
reg [3:0] count;
 initial begin
 count =0;
 T = 1 << count;
 end
always @ (posedge CLK) begin
 
    if(clr)begin
        count = 0;
        T = 1 << count;
    end else begin
        count = count + 1;
        T = 1 << count;
    end

end

endmodule