`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 06:38:46 PM
// Design Name: 
// Module Name: memory
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


module memory(
     input clk,
     input RD,
     input WR,
     input [11:0] add,
     input [15:0] datain,
     output reg [15:0] dataout

    );

    reg [15:0] ram [4095:0];
    
    initial begin
        $readmemh("D:/Games/New folder/meme.txt",ram);
        dataout <= ram[0];

    end
        
    
    always @(posedge clk) begin 
    if(RD && !WR) begin
        dataout <= ram[add];
    end
    else if(!RD&&WR) begin
        ram[add] <= datain ;
    end
    end
endmodule
