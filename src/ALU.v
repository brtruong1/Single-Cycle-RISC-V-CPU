`timescale 1ns / 1ps


module ALU(a, b, Selection, Result, Zero, Carry, Overflow, Negative);


    input [31:0] a, b;
    input [2:0] Selection; // 3 bits for 8 operations

    output Zero, Carry, Overflow, Negative;
    output [31:0] Result;
    reg [31:0] Result_Reg;
    wire Cout;
    wire [31:0] sum;
    
    
    // when selection[1] is 1, do logic op, when it is 0 do arithmetic
    // when selection[0] = 1, subtraction , if 0 then addition
    /// 000 add, lw, sw, 
    /// 001 sub, beq
    /// 101 slt  comes from subtraction
    // 011 or
    // 010 and
    
    
    assign {Cout, sum} = (Selection[0] == 1'b0) ? a + b : (a +((~b) + 1));  // twos complement for subtraction  //MSB is Cout
    // then cout goes to carry
    assign Carry = ((~Selection[1])) & Cout;    // we only want it for arithmetic though
        
    always @(*) begin
        case(Selection)
            3'b000: Result_Reg = sum;   //arithmetic add
            3'b001: Result_Reg = sum;   //arithmetic sub
            3'b010: Result_Reg = a & b;   //  and op
            3'b011: Result_Reg = a | b;  // or op
            3'b101: Result_Reg = {31'b0, sum[31]};     //slt from sub, take msb and 
            default: Result_Reg = 32'b0;   // for the other unused selections
        endcase 
    end
    assign Result = Result_Reg;
    
    assign Overflow = ((sum[31] ^ a[31]) &     //  check if MSB of a and result are different
                      (~(Selection[0] ^ b[31] ^ a[31])) &  //overflow rules
                      (~Selection[1]));      // only if in arithmetic mode
    
    assign Zero = (Result == 32'b0);    // if its all 0 then
    assign Negative = Result[31];  //just the MSB    
endmodule
