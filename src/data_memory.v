`timescale 1ns / 1ps
/////////////////////////////////////////


module data_memory(clk, reset, A, WE, WD, RD );
    input clk, WE, reset;
    input [31:0] A, WD;
    output [31:0] RD;
    
    reg [31:0] mem [1023:0];   // 1024 x 32 bit instruction memory for 4KB
    
    always @ (posedge clk)
    begin
        if (WE)
            mem[A] <= WD;    //
    end
    
    assign RD = (~reset) ? 32'b0 : mem[A];
    
    
endmodule
