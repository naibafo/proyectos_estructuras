`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;
	
	// Outputs from the ID module
	wire [5:0] 	OperationIF;
	wire [9:0] 	Data_IF;
	
	// Inputs to mod
	reg			BranchTaken; 
	reg [9:0]	RelativeJump;
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	InstructionFetcher UUT
	(
		.Clock(Clock),				// 	Input Clock
		.Reset(Reset),
		.iBranchTaken(BranchTaken),
		.iRelativeJump(RelativeJump),
		.oOperation_IF(OperationIF),
		.oData_IF(Data_IF)
	);
	
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("IF.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		BranchTaken = 0;
		RelativeJump = 10'b0;
		
		# 5
		Reset = 1;
		# 20
		Reset = 0;
		
		# 40
		BranchTaken = 1;
		RelativeJump = 10'b1111111111;
		
		#20 
		BranchTaken = 0;
		RelativeJump = 10'b11;
		
		#150
		$finish;

	end
      
endmodule
