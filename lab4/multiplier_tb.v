`timescale 1ns/1ns

module multiplier_tb;

  reg [7:0] Ain, Bin;
  reg rstn, clk, loadA, loadB, start;
  wire [15:0] product;
  wire done;

  multiplier_hier U1(.Clock(clk), .Resetn(rstn), .LA(loadA), .LB(loadB),
                     .s(start), .DataA(Ain), .DataB(Bin),
                     .P(product), .Done(done) );

  // define clock
  always
  begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // defint test sequence
  initial
  begin
    // Please define the test sequence by yourself
    #0 Ain=8'b00001000;Bin=8'b00000111; rstn=0; start=1; loadA=1; loadB=1;
    #10 rstn=1;loadA=0;loadB=0;
  end

endmodule // multiplier_tb
