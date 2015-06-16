////////////////////////////////////////////////////////////////////////
//// MODULE: InstructionDecoder                                     ////
////////////////////////////////////////////////////////////////////////
/*
		Instruction Decoder:
			-	Manages the branching logic. Every branching instruction
				is executed here. Every further step of the pipeline will 
				react to a branch as a NOP operation, due that there is 
				nothing else to do.
			-	In case the operation given is not a branch instruction,
				the ID acts as a transparent schift register. (Delays the
				instructions and aditional data one CLK cycle.
*/
module InstructionDecoder
(
	input wire	 		Clock,				// 	Input Clock
	input wire 		Reset,				// 	Reset signal
	input wire	[5:0]	iOperation_IF,		//	Input Operation from the IF		
	input wire	[9:0]	iData_IF,			//	Input Data from the IF
	input wire	[7:0]	iRegA,				//	Reg A
	input wire	[7:0]	iRegB,				//	Reg B
	output reg	[5:0]	oOperation_ID,		//	Output Operation
	output reg	[5:0]	oData_ID,			//	Output Data
	output reg			oBranchTaken			//	Flag that indicates if we need to branch
);
////////////////////////////////////////////////////////////////////////
wire Za, Zb;
assign Za = (iRegA == 8'b0);	// Zero flag for reg A
assign Zb = (iRegB == 8'b0);	// Zero flag for reg B
/*
	Reset logic: 
		If we have a reset, the input OP is read as a NOP. Usefull when 
		introducing bubbles into the pipeline is needed (specially after
		a branch was taken).
		
		The reset given will be:
			Reset || BranchTaken
			
		This way a Branch will introduce a NOP operation bubble.
*/
wire [5:0] iOperation;
assign iOperation = (Reset) ? iOperation_IF :  `NOP;

////////////////////////////////////////////////////////////////////////
always @ (posedge Clock)
	////////////////////////////////////////////////////////////////////
	case (iOperation)
	////////////////////////////////////////////////////////////////////
		/*
			BAEQ:
					Branch is reg A is Zero.
		*/
		`BAEQ:
			begin
				oBranchTaken 	= 	Za;			// Take a branch is A is Zero
				oOperation_ID 	= 	`NOP;		// Make other steps beleive is a NOP
				oData_ID 		=	iData_IF;	// The jump information is on iData_IF. Keep it the same
			end
		////////////////////////////////////////////////////////////////
		/*
			When its not a branch instruction:
				- Output the same operation
				- Indicate that there is no branch to take
				- Output the data we got
		*/
		default:
			begin
				oOperation_ID 	= 	iOperation;		// 
				oBranchTaken 	=	1'b0;			// 
				oData_ID		= 	iData_IF;		//
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule


