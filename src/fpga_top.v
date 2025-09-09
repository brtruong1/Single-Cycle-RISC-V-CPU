`timescale 1ns / 1ps

module fpga_top (
    input  wire clk,        // 125 MHz system clock
    input  wire btn_reset_n, // pushbutton (active-low)
    output wire led0        // LED heartbeat
);

  wire reset = btn_reset_n;  // button is 1 until pressed, then 0

  
  CPU_top u_cpu (
    .clk   (clk),
    .reset (reset)   
  );

  // Heartbeat counter to keep logic alive and drive an LED
  reg [25:0] hb;
  always @(posedge clk) 
  begin
        if (reset) hb <= 0;
        else       hb <= hb + 1;
  end
  assign led0 = hb[25];

endmodule
