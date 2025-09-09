`timescale 1ns / 1ps


module alu_decoder(Op, ALUOp, funct3, funct7, Selection);
input [2:0] funct3;
input [6:0] Op, funct7;
input [1:0] ALUOp;

output reg [2:0] Selection;


always @(*) begin
    case (ALUOp)
        2'b00: Selection = 3'b000; //lw sw
        2'b01: Selection = 3'b001; // beq
        2'b10: begin                
            case (funct3)
                3'b000: Selection = ({Op[5], funct7[5]} == 2'b11) ? 3'b001 : 3'b000; // add/sub
                3'b010: Selection = 3'b101; // slt
                3'b110: Selection = 3'b011; // or
                3'b111: Selection = 3'b010; // and
                default: Selection = 3'b000;
            endcase
        end
        default: Selection = 3'b000;
    endcase
end


endmodule
