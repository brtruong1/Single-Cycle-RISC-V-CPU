`timescale 1ns / 1ps


module register_file(clk, reset, WE3, WD3, A1, A2, A3, RD1, RD2);
    input clk, WE3, reset;
    input [4:0] A1, A2, A3;
    input [31:0] WD3;

    output [31:0] RD1, RD2;


    reg [31:0] Register [31:0];   //32 element x 32 bit register file
    
    
    
    always @ (posedge clk)
    begin
        Register[0] <= {32'b0}; //zero register for addi
         if (WE3)  //write enable
            Register[A3] <= WD3;
    end
    
    assign RD1 = (~reset) ? 32'b0 : Register[A1];
    assign RD2 = (~reset) ? 32'b0 : Register[A2];
    
    
endmodule
