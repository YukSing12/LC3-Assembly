// Definition of shift-right register
module shiftrne( Din, load, en, sin, clock, Q ); 
  parameter n=8;
  input [n-1:0] Din;
  input load, en, sin, clock;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  integer k;

  always @(posedge clock)
  begin
    if (load)
      Q <= Din;
    else if (en)
    begin
      for (k=n-1; k>0; k=k-1)
        Q[k-1] <= Q[k];
      Q[n-1] <= sin;
    end 
  end

endmodule // shiftrne


// Definition of shift-left register
module shiftlne( Din, load, en, sin, clock, Q ); 
  parameter n=8;
  input [n-1:0] Din;
  input load, en, sin, clock;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  integer k;

  always @(posedge clock)
  begin
    if (load)
      Q <= Din;
    else if (en)
    begin
      for (k=n-1; k>0; k=k-1)
        Q[k] <= Q[k-1];
      Q[0] <= sin;
    end 
  end
endmodule // shiftlne


// Definition of register with enable and resetn
module regne( Din, clock, resetn, en, Q ); 
  parameter n=8;
  input [n-1:0] Din;
  input clock, resetn, en;
  output [n-1:0] Q;
  reg [n-1:0] Q;

  integer k;

  always @(posedge clock or negedge resetn)
  begin
    if (resetn == 0)
    begin
      for (k=0; k<n; k=k+1)
        Q[k] <= 0; 
    end
    else 
    begin
      if (en)
        Q <= Din;   
    end
  end
endmodule // regne
