`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;
	
	// Outputs from the ID module
	reg Carry;
	reg [7:0] Data_MEM;

	reg	ModA; 
	reg	ModB;
	
	wire [7:0] RegA, RegB;
	wire CarryA, CarryB;	
	
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	WriteBack DUT
	(
		.Clock(Clock),
		.Reset(Reset),
		.iData(Data_MEM),
		.iCarry(Carry),
		.iModA(ModA),
		.iModB(ModB),
		.oRegA(RegA),
		.oRegB(RegB),
		.oCarryA(CarryA),
		.oCarryB(CarryB)
	);
	
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("WB.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		
		ModA = 1'b0;
		ModB = 1'b0;
		
		Carry = 1'b0;
		
		Data_MEM = 8'b11111011;
		
		# 5
		Reset = 1;
		# 20
		Reset = 0;
		
		# 25
		ModA = 1'b1;
		#25
		ModB = 1'b1;
		Carry = 1'b1;
		#25
		ModA = 1'b0;
		#25
		ModB = 1'b0;
		Carry = 1'b0;
		#10
		ModA = 1'b1;
		ModB = 1'b1;
		#25
		ModA = 1'b0;
		ModB = 1'b0;
		#150
		$finish;

	end
      
endmodule
