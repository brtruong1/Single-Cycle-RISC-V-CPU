`timescale 1ns / 1ps
///////////////////////////////////////////////////////////


module mux(a, b, s, c);
    input [31:0] a, b;
    input s;   //selection   0 for S type (gets value from alu), 1 for Itype or S-type   (gets from data)
    output [31:0] c;

    assign c = (~s) ? a : b;
endmodule
