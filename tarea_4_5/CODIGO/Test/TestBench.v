`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;
	
	// Outputs from the IF module
	wire [5:0] 	Operation_IF;
	wire [9:0] 	Data_IF;
	// Outputs from the ID module
	wire [5:0] 	Operation_ID;
	wire [9:0] 	Data_ID;
	wire [9:0]	RelativeJump;
	wire		BranchTaken; 
	
	// Inputs for the ID module
	reg [7:0] regA; 
	reg [7:0] regB; 
	reg		   CarryA;
	reg		   CarryB;
	
	// Outputs from EXC module
	wire [7:0]	Result;
	wire 		Carry;
	wire [9:0]	Data_EXC;
	wire [6:0]	Operation_EXC;
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	// Instruction Fetcher
	InstructionFetcher IF
	(
		.Clock(Clock),					//	Input Clock
		.Reset(Reset),					//	Reset	
		.iBranchTaken(BranchTaken),		//	BranchTaken
		.iRelativeJump(Data_ID),	//	RelativeJump
		.oOperation_IF(Operation_IF),	//	Operation from IF module
		.oData_IF(Data_IF)				// 	Data from IF module
	);
	
	// Instruction Decoder
	InstructionDecoder ID
	(
		.Clock(Clock),					// 	Input Clock
		.Reset(Reset|BranchTaken),		// 	Reset signal
		.iOperation_IF(Operation_IF),	//	Input Operation from the IF		
		.iData_IF(Data_IF),				//	Input Data from the IF
		.iRegA(regA),					//	Reg A
		.iCarryA(CarryA),				//	Carry A
		.iRegB(regB),					//	Reg B
		.iCarryB(CarryB),				//	Carry B
		.oOperation_ID(Operation_ID),	//	Output Operation
		.oData_ID(Data_ID),				//	Output Data
		.oBranchTaken(BranchTaken)		//	Flag that indicates if we need to branch
	);
	
	// Execution
	Execution EXC
	(
		.Clock(Clock),					// 	Input Clock
		.Reset(Reset),
		.iOperation_ID(Operation_ID),
		.iData_ID(Data_ID),
		.iReg_A(regA),
		.iCarryA(CarryA),
		.iReg_B(regB),
		.iCarryB(CarryB),
		.oResult(Result),
		.oCarry(Carry),
		.oOperation_EXC(Operation_EXC),
		.oData_EXC(Data_EXC)
	);
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("Pipeline.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		
		// Reset Sequence
		#15;
		Reset = 1;
		#20
		Reset = 0;
		
		regA = 8'b11110101;
		regB = 8'b10101010;
		CarryA = 0;
		CarryB = 0;
		
		#350
		$finish;

	end
      
endmodule
