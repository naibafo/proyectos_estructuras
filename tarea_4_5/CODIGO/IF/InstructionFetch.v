////////////////////////////////////////////////////////////////////////
//// MODULE: InstructionFetcher                                     ////
/////////////////////////////////////////////////////////////////// /////
/*
		Instruction Fetcher:
			-	Fetches the operations and aditional data from a ROM 
				memory. 
			-	Implements a Program Counter logic to develop lineal and
				branching way of reading the memory instructions.
*/
module InstructionFetcher
(
	input wire	 	Clock,				// 	Input Clock
	input wire 		Reset,				// 	Reset signal
	input wire 		iBranchTaken,		//
	input wire [9:0]	iRelativeJump,		//
	output wire [5:0]	oOperation_IF,		//
	output wire [9:0]	oData_IF			//
);

// --------------------- //
// Program Counter Logic //
// --------------------- //

wire [9:0] ProgramCounter;
wire [9:0] NextPCValue;
wire [9:0] JumpDirection;

// We jump to the PC plus the relative jump (is given in complement)
assign JumpDirection = ProgramCounter+iRelativeJump;
// Next value depends on wheter or not we branch
assign NextPCValue = (iBranchTaken) ? (JumpDirection): (ProgramCounter+1);

// --------------------- //
//    Program Counter    //
// --------------------- //

FFD # ( 10 ) PC 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(NextPCValue),
	.Q		(ProgramCounter)
);

// The instruction we fetch from the ROM
wire [15:0] Instruction;
/*
	Separate the Operation and the Data.
		- First 6 bits = Operation
		- Last 10 bits = Additional Data
*/
assign {oOperation_IF, oData_IF } =  Instruction;


// --------------------- //
//      ROM Memory       //
// --------------------- //

ROM InstructionMemory (
	.iAddress		(ProgramCounter),
	.oInstruction	(Instruction)
);

endmodule
///////////////////////////////////////////////////////////////////////
