`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 10:47:55 AM
// Design Name: 
// Module Name: ins_tb
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


module ins_tb();
reg clk;
wire [11:0] AR_out,PC_out;
wire[15:0] T;
wire[7:0] D;
wire [15:0] DR_out,AC_out,IR_out;
wire  E_out;
wire [15:0] MEMO_out;
wire [15:0] bus;
wire J_bit;
reg clk_sc;
wire [15:0] alu;
main tb(
.clk_sc(clk_sc),
.clk(clk),
.AR_out(AR_out),
.PC_out(PC_out),
.T(T),
.D(D),
.DR_out(DR_out),
.AC_out(AC_out),
.alu(alu),
.IR_out(IR_out),
.J_bit(J_bit),
.E_out(E_out),
.MEMO_out(MEMO_out),
.bus(bus)
);
initial begin

 clk = 0;
 clk_sc = 0;
 end 
 always begin
#5 clk=~clk;
 #5 clk_sc = ~clk_sc;
      clk=~clk;


end


endmodule
