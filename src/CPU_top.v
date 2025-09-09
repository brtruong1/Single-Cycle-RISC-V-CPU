`timescale 1ns / 1ps
//

module CPU_top(clk, reset);
    
    input clk, reset;
    
    wire RegWrite,MemWrite,ALUSrc,ResultSrc;
         
    wire [1:0] ImmSrc;
         
    wire [2:0] ALUControl_Top;
    
    
    wire [31:0] PC_Top, RD_Instr, 
    RD1_Top, Imm_Ext_Top, ALUResult, 
    ReadData, PC4, RD2_Top, SrcB, Result;
     
    
     
    PC_mod PC(
        .clk(clk),
        .reset(reset),
        .PC(PC_Top),
        .PCNext(PC4)
    );
    
    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),   //4 bytes
        .c(PC4)
    );
    
    

    register_file register_file(
        .clk(clk),
        .reset(reset),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );
    
    instruction_memory instruction_memory(
        .reset(reset),
        .A(PC_Top),
        .RD(RD_Instr)
    );
    
    sign_ext sign_ext(
        .In(RD_Instr),
        .ImmSrc(ImmSrc[0]),
        .Imm_Ext(Imm_Ext_Top)
    );
    
    
    
    ALU ALU(
        .a(RD1_Top),
        .b(SrcB),
        .Result(ALUResult),
        .Selection(ALUControl_Top),
        .Overflow(),   //not needed
        .Carry(),
        .Zero(),
        .Negative()
    );
    
    mux mux_r_to_alu(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );
    
    control_unit control_unit(
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),   //changed
        .Selection(ALUControl_Top),
        .Branch()  //not used
        
    );
    
    
    data_memory data_memory(
        .clk(clk),
        .reset(reset),
        .A(ALUResult),
        .RD(ReadData),
        .WE(MemWrite),
        .WD(RD2_Top)
    );
    
    mux mux_datamemory_to_r(
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Result)
    );
    
endmodule
