`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 09:06:29 PM
// Design Name: 
// Module Name: main
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


module main(
input clk,clk_sc,
output [11:0]  AR_out,PC_out,
output [15:0] T,
output [7:0] D,
output [15:0] DR_out,AC_out,IR_out,
output  E_out,
output [15:0] MEMO_out, 
output J_bit
    );
//wire alu;
wire [15:0] bus;

wire [15:0] alu;

wire S;
wire [15:0] B = IR_out;
wire J = IR_out[15];
wire r = (D[7]&&(~J)&&T[3]);
wire p = (D[7]&&(J)&&T[3]);
assign J_bit = J;
//**********REGISTERD************
//********** AR *****************

wire [11:0] AR_i = bus ;
wire AR_clk = clk_sc;//clk;
wire AR_ld  = (T[0]) || (T[2] || (~D[7] && J && T[3]) );   
wire AR_inc = 0;
wire AR_clr = 0;
register_12bit AddressR(
  .d_in(AR_i),
  .CLK(AR_clk),
  .LD(AR_ld),
  .INC(AR_inc),
  .MR(AR_clr),
  .q_out(AR_out)

);


//*************** PC ************
//wire pcinc;
wire [11:0] PC_i = bus;
wire PC_clk = clk_sc;//clk;
wire PC_ld  = 0;   
wire PC_inc = ((T[1]) || (B[9]&&(D[7]&&(~J)&&T[3])) );
wire PC_clr = 0;
register_12bit PC(
  .d_in(PC_i),
  .CLK(PC_clk),
  .LD(PC_ld),
  .INC(PC_inc),
  .MR(PC_clr),
  .q_out(PC_out)

);

//*************** DR ************

wire [15:0] DR_i = bus;
wire DR_clk = clk;
wire DR_ld  = ((D[0]&&T[4]) || (D[1]&&T[4]) || (D[2]&&T[4]) || (D[3]&&T[4]) || (D[5]&&T[4]) );   
wire DR_inc = 0;
wire DR_clr = 0;
register_16bit DR(
  .d_in(DR_i),
  .CLK(DR_clk),
  .LD(DR_ld),
  .INC(DR_inc),
  .MR(DR_clr),
  .q_out(DR_out)

);



//*************** AC ************

wire [15:0] AC_i = alu;
wire AC_clk = clk_sc;
wire AC_ld  = ((D[0]&&T[5]) || (D[1]&&T[5]) || (D[2]&&T[5]) || (D[3]&&T[5]) || (D[5]&&T[5]) || (r && B[8]) );   
wire AC_inc = (r && B[11]);
wire AC_clr = (r && B[10]);
register_16bit AC(
  .d_in(AC_i),
  .CLK(AC_clk),
  .LD(AC_ld),
  .INC(AC_inc),
  .MR(AC_clr),
  .q_out(AC_out)

);


//*************** IR ************

wire [15:0] IR_i = bus;
wire IR_clk = clk_sc;
wire IR_ld  = (T[1]);   
wire IR_inc = 0;
wire IR_clr = 0;
register_16bit IR(
  .d_in(IR_i),
  .CLK(IR_clk),
  .LD(IR_ld),
  .INC(IR_inc),
  .MR(IR_clr),
  .q_out(IR_out)

);

//*************** MEMORY **************************
wire [15:0] MEMO_in = bus;
wire MEMO_clk = clk;
wire MEMO_RD  = ((T[1]) || (D[0] && T[4]) || (D[1] && T[4]) ||  (D[2] && T[4]) || (D[3] && T[4]) || (D[5] && T[4]) || (~D[7] && J && T[3]));   
wire MEMO_WR = (D[4] && T[4]) ;
wire [11:0] MEMO_ADD = AR_out;


memory mem(
  .clk(MEMO_clk),
   .RD(MEMO_RD),
   .WR(MEMO_WR),
    .add(MEMO_ADD),
   .datain(MEMO_in),
   .dataout(MEMO_out)





);



//****************** FLAGS ***************************
//****************** E FLAG **********************
wire E_in;
wire E_clk = clk;
wire E_ld  = (D[1] && T[5] && E_in);   

dff E(
.D(E_ld),
.Q(E_out),
.clk(E_clk)
);

////**************DECODER****************


decoder_8_bit decoder(
    .decoder_input(IR_out[14:12]),
    .decoder_output(D)
);


////****************** SEQUANCE COUNTER *****************


//wire STOP;
wire SC_clk = ((~S) && clk_sc);
wire SC_clr = ( (D[0] && T[5]) || (D[1] && T[5]) ||  (D[2] && T[5]) || (D[3] && T[5]) ||  (D[4] && T[4]) || (D[5] && T[5]) ||  (D[7]&&(~J)&&T[3])  || (p)) ;

sc SequanceCounter(
.T(T),
.CLK(SC_clk),
.clr(SC_clr)
);

////******************* BUS ***********************

////****************** ENCODER ******************
wire [7:0] X;
assign X[0] = 0;
assign X[1] = 0;  //AR
assign X[2] = (T[0]);  //PC
assign X[3] = (D[3]&&T[5]);    //DR
assign X[4] = ((D[4]&&T[4]) || (p && B[11]));  //AC
assign X[5] = T[2];                               //IR
assign X[6] = 0;                             //TR
assign X[7] = MEMO_RD;  

bus bu(
.X(X),
.AR({4'b0000 , AR_out}),
.PC({4'b0000 , PC_out}),
.DR(DR_out),
.AC(AC_out),
.IR({4'b0000,IR_out[11:0]}),
.TR(0),
.MEM(MEMO_out),
.bus(bus)

);
//////////////ALU///////////////
alu aluu(
.DR(DR_out),
.AC(AC_out),
.IR(IR_out),
.D(D),
.E(E_out),
.E_out(E_in),
.S(S),
.ALU(alu),
.clk(clk_sc)






);










endmodule
