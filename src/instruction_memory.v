`timescale 1ns / 1ps

module instruction_memory(A, reset, RD);
    input reset;
    input [31:0] A;

    output [31:0] RD;
    
    reg [31:0] mem [1023:0];   // 1024 x 32 bit instruction memory for 4KB
    
    assign RD = (~reset) ? {32{1'b0}} : mem[A[31:2]];   //mem[A[31:2]] because each word is 4 bytes, 
    
    initial begin
        
        
          // addi x5, x0, 0x2
          mem[0] = 32'h0020_0293;
        
          // addi x6, x0, 0x40
          mem[1] = 32'h0400_0313;
        
          // sw x5, 0x8(x6)
          mem[2] = 32'h0053_2423;
        
          // lw x7, 0x8(x6)
          mem[3] = 32'h0083_2383;
        
    end
endmodule
