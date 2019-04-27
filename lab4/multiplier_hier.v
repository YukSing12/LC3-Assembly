// Definition of control module for shift-and-add multipler
module mul_control( clock, rstn, b0, zero, start, en_a, en_b, en_p, done, psel );
  input clock, rstn, b0, zero, start;
  output en_a, en_b, en_p, done, psel;
  // control circuit
	reg done, en_a, en_b, en_p, psel;
  parameter S1=2'b00, S2 = 2'b01, S3 = 2'b10;
	reg [1:0] y, Y;

  always @(start or y or zero)
  begin: State_table
    case (y)
      S1: if (start == 0) Y = S1;
          else Y = S2;
      S2: if (zero == 0) Y = S2;
          else Y = S3;
      S3: if (start == 1) Y = S3;
          else Y = S1;
      default: Y = 2'bXX;
    endcase
  end
	
	
  always @(posedge clock or negedge rstn)
  begin: State_flipflops
    if (rstn == 0)
        y <= S1;
    else
        y <= Y;
  end

  always @(start or y or b0)
  begin: FSM_outputs
    // defaults
    en_a = 0; en_b = 0; en_p = 0; done = 0; psel = 0;
    case (y)
      S1: en_p = 1;
      S2: begin
            en_a = 1; en_b = 1; psel = 1;
            if (b0) en_p = 1;
            else en_p = 0;
          end
      S3: done = 1;
    endcase
  end
endmodule // mul_control

// Definition for the datapath module of shift-and-add multiplier
module mul_datapath (clock, rstn, din_a, din_b, ld_a, en_a, ld_b, en_b, en_p, psel,
                     b0, zero, product);
  parameter n = 8;
  input clock, rstn, ld_a, en_a, ld_b, en_b, en_p, psel;
  input [n-1:0] din_a, din_b;
  output b0, zero;
  output [n+n-1:0] product;
  wire [n-1:0] B;
  wire [n+n-1:0] A;
  reg [n+n-1:0] data_p;
  wire [n+n-1:0] sum;

  integer k;
  // Please finish the remaining statements for control circuit
	// Datapath circuit
	
  shiftrne ShiftB (din_b, ld_b, en_b, 0, clock,B);
  defparam ShiftB.n = 8;
  shiftlne ShiftA ({{n{1'b0}}, din_a}, ld_a, en_a, 0, clock, A);
  defparam ShiftA.n = 16;

  assign zero=(B==0);
  assign b0=B[0];
  assign sum=A+product;
  
  // define the 2n 2-to-1 multiplexers
  always @(psel or sum)
  begin
    for (k = 0; k < n+n; k = k+1)
      data_p[k] = psel ? sum[k] : 0;
  end

  regne RegP (data_p, clock, rstn, en_p, product);
    defparam RegP.n = 16;
endmodule // mul_datapath


// Top level multiplier module
module multiplier_hier (Clock, Resetn, LA, LB, s, DataA, DataB, P, Done);

  parameter n = 8;
  input Clock, Resetn, LA, LB, s;
  input [n-1:0] DataA, DataB;
  output [n+n-1:0] P;
  output Done;

  wire Done, EA, EB, EP, Psel;
  wire b_0, z;

 	mul_control Cntl( .clock(Clock), .rstn(Resetn), .b0(b_0), .zero(z),
                    .start(s), .en_a(EA), .en_b(EB), .en_p(EP), .done(Done),
                    .psel(Psel) );

  mul_datapath DPath(.clock(Clock), .rstn(Resetn), .din_a(DataA), .din_b(DataB),
                     .ld_a(LA), .en_a(EA), .ld_b(LB), .en_b(EB),
                     .en_p(EP), .psel(Psel),
                     .b0(b_0), .zero(z), .product(P) );
endmodule // multiplier_hier

