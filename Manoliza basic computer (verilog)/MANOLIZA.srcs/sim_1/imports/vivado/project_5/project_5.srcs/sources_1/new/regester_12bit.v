`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2024 07:43:17 PM
// Design Name: 
// Module Name: regester_16bit
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


module register_12bit(
        input CLK,
    input MR,
    input LD,
    input INC,
    input [0:11] d_in,
    output reg [0:11] q_out

    );
    
   initial begin 
   q_out <= 0;
   end
   
   always @ (posedge CLK)
        if(MR)
          q_out <=0 ;
          else begin 
            if(INC)
             q_out <= q_out + 1;
             else if(LD)
             q_out <= d_in;
          
          end
endmodule
