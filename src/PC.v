`timescale 1ns / 1ps

module PC_mod(clk, reset, PCNext, PC);

    input clk, reset;
    input [31:0] PCNext;

    output reg [31:0] PC;
    
    
    always @ (posedge clk) 
    begin
        if (~reset)
            PC <= {32{1'b0}};
        else
            PC <= PCNext;
    end
endmodule
