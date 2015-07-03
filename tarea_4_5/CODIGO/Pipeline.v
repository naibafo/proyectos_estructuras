module pipeline
(
	input wire Clock,
	input wire Reset,
	output wire regA,
	output wire regB
);

	// Outputs from the IF module
	wire [5:0] 	Operation_IF;
	wire [9:0] 	Data_IF;
	// Outputs from the ID module
	wire [5:0] 	Operation_ID;
	wire [9:0] 	Data_ID;
	wire [9:0]	RelativeJump;
	wire		BranchTaken; 
	
	// Inputs for the ID module
	wire	   CarryA;
	wire	   CarryB;
	
	// Outputs from EXC module
	wire [7:0]	Result;
	wire 		Carry;
	wire [9:0]	Data_EXC;
	wire [5:0]	Operation_EXC;
	
	//Outputs from MEM module
	
	wire 	   ModB;
	wire 	   ModA;
	wire [7:0] MEM_Out;
	wire 	   CarryFlag;
	
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
	
	// Memory
	Memory MEM
	(
		.Clock(Clock),
		.Reset(Reset),		
		.iResult(Result),	
		.iData(Data_EXC),		
		.iCarry_result(Carry), 
		.iRegA(regA),		
		.iRegB(regB),		
		.iOperation(Operation_EXC),  
		.oData(MEM_Out),		
		.oModA(ModA),		
		.oModB(ModB),
		.oCarry_flag(CarryFlag)		
	);
	
	// Write Back
	WriteBack WB
	(
		.Clock(Clock),
		.Reset(Reset),
		.iData(MEM_Out),
		.iCarry(CarryFlag),
		.iModA(ModA),
		.iModB(ModB),
		.oRegA(regA),
		.oRegB(regB),
		.oCarryA(CarryA),
		.oCarryB(CarryB)
	);
endmodule
