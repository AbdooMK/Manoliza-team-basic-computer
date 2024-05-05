`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 08:27:44 PM
// Design Name: 
// Module Name: encoder
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


module encoder_8_3(en,X,S);
  // declare
  input en;
  input [7:0] X;
  // store and declare output values
  output reg [2:0] S;
  always @(en,X)
  begin
    if(en==1)
      begin
        // priority encoder
        // if condition to choose 
        // output based on priority. 
        if(X[7]==1) S=3'b111;
        else if(X[6]==1) S=3'b110;
        else if(X[5]==1) S=3'b101;
        else if(X[4]==1) S=3'b100;
        else if(X[3]==1) S=3'b011;
        else if(X[2]==1) S=3'b010;
        else if(X[1]==1) S=3'b001;
        else
        S=3'b000;
      end
     // if enable is zero, there is
     // an high impedance value. 
    else S=3'bzzz;
  end
endmodule