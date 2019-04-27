module multiplier (Clock, Resetn, LA, LB, s, DataA, DataB, P, Done);

  parameter n = 8;
  input Clock, Resetn, LA, LB, s;
  input [n-1:0] DataA, DataB;
  output [n+n-1:0] P;
  output Done;
  wire z;
  reg [n+n-1:0] A, DataP;
  wire [n+n-1:0] Sum;
  reg [1:0] y, Y;
  reg [n-1:0] B;
  reg Done, EA, EB, EP, Psel;
  integer k;

  // control circuit
  parameter S1=2'b00, S2 = 2'b01, S3 = 2'b10;
  always @(s or y or z)
  begin: State_table
    case (y)
      S1: if (s == 0) Y = S1;
          else Y = S2;
      S2: if (z == 0) Y = S2;
          else Y = S3;
      S3: if (s == 1) Y = S3;
          else Y = S1;
      default: Y = 2'bXX;
    endcase
  end

  always @(posedge Clock or negedge Resetn)
  begin: State_flipflops
    if (Resetn == 0)
        y <= S1;
    else
        y <= Y;
  end

  always @(s or y or B[0])
  begin: FSM_outputs
    // defaults
    EA = 0; EB = 0; EP = 0; Done = 0; Psel = 0;
    case (y)
      S1: EP = 1;
      S2: begin
            EA = 1; EB = 1; Psel = 1;
            if (B[0]) EP = 1;
            else EP = 0;
          end
      S3: Done = 1;
    endcase
  end

  // Datapath circuit
  shiftrne ShiftB (DataB, LB, EB, 0, Clock, B);
    defparam ShiftB.n = 8;
  shiftlne ShiftA ({{n{1'b0}}, DataA}, LA, EA, 0, Clock, A);
    defparam ShiftA.n = 16;

  assign z = (B == 0);
  assign Sum = A + P;

  // define the 2n 2-to-1 multiplexers
  always @(Psel or Sum)
  begin
    for (k = 0; k < n+n; k = k+1)
      DataP[k] = Psel ? Sum[k] : 0;
  end

  regne RegP (DataP, Clock, Resetn, EP, P);
    defparam RegP.n = 16;

endmodule

