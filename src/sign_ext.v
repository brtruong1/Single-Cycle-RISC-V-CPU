`timescale 1ns / 1ps


module sign_ext (In, Imm_Ext, ImmSrc);

    input [31:0] In;
    input ImmSrc;
    output [31:0] Imm_Ext;

    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}},In[31:25],In[11:7]}):   //if ImmSrc = 1, comes from S type
                                        {{20{In[31]}},In[31:20]};   //ImmScr = 0, comes from I type
                                
endmodule
