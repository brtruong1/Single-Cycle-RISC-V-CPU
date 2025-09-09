`timescale 1ns / 1ps
//
module control_unit(Op, RegWrite, ImmSrc, 
ALUSrc, MemWrite, ResultSrc, 
Branch, funct3, funct7 , Selection);

    input [6:0] Op, funct7;
    input [2:0] funct3;
    
    output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch;  //from main decoder
    output [1:0] ImmSrc;
    
    output [2:0] Selection;  //from alu decoder
 
    wire [1:0]ALUOp;

     main_decoder main_decoder(
           .Op(Op),
           .RegWrite(RegWrite),
           .ImmSrc(ImmSrc),
           .MemWrite(MemWrite),
           .ResultSrc(ResultSrc),
           .Branch(Branch),
           .ALUSrc(ALUSrc),
           .ALUOp(ALUOp)
       );
   
       alu_decoder alu_decoder(
           .ALUOp(ALUOp),
           .funct3(funct3),
           .funct7(funct7),
           .Op(Op),
           .Selection(Selection)
       );

endmodule
