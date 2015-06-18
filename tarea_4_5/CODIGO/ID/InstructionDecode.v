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
	input wire 		iCarryA,			//	Carry for reg A
	input wire	[7:0]	iRegB,				//	Reg B
	input wire 		iCarryB,			//	Carry for reg B
	output wire [5:0]	oOperation_ID,		//	Output Operation
	output wire [9:0]	oData_ID,			//	Output Data
	output reg			oBranchTaken		//	Flag that indicates if we need to branch
);
////////////////////////////////////////////////////////////////////////
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
assign iOperation = (Reset) ?  `NOP: iOperation_IF;

//
// Operation
//

FFD # ( 6 ) Operation 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iOperation),
	.Q		(oOperation_ID)
);

//
// Additional Data
//

FFD # ( 10 ) Additional_Data 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iData_IF),
	.Q		(oData_ID)
);

////////////////////////////////////////////////////////////////////////
//
//	FLAGS
//
////////////////////////////////////////////////////////////////////////
wire Za, Zb;
assign Za = (iRegA == 8'b0);	// Zero flag for reg A
assign Zb = (iRegB == 8'b0);	// Zero flag for reg B

wire Na, Nb;
assign Na = iRegA[7];	// Sign flag for reg A
assign Nb = iRegB[7];	// Sign flag for reg B
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
always @ (posedge Clock)
	////////////////////////////////////////////////////////////////////
	case (iOperation)
	////////////////////////////////////////////////////////////////////
		
		// --------------------------------
		//	Branching Operations for reg A
		// --------------------------------
		
		/*
			BAEQ:
					Branch if reg A is Zero.
		*/
		`BAEQ:	oBranchTaken 	= 	Za;			// Take a branch if A is Zero
		/*
			BANE:
					Branch if reg A is non Zero.
		*/
		`BANE:	oBranchTaken 	= 	~Za;		// Take a branch if A is non Zero
		/*
			BACS:
					Branch if CarryA is set.
		*/
		`BACS:	oBranchTaken 	= 	iCarryA;		// Take a branch if CarryA is set
		/*
			BACC:
					Branch if CarryA is clear.
		*/
		`BACC:	oBranchTaken 	= 	~iCarryA;	// Take a branch if CarryA is clear
		/*
			BAMI:
					Branch if reg A is positive.
		*/
		`BAMI:	oBranchTaken 	= 	Na;	// Take a branch if reg A is positive.
		/*
			BAPL:
					Branch if reg A is positive.
		*/
		`BAPL:	oBranchTaken 	= 	~Na;	// Take a branch if reg A is positive.
		
		// --------------------------------
		//	Branching Operations for reg B
		// --------------------------------
		
		/*
			BBEQ:
					Branch if reg B is Zero.
		*/
		`BBEQ:	oBranchTaken 	= 	Zb;			// Take a branch if B is Zero
		/*
			BBNE:
					Branch if reg B is non Zero.
		*/
		`BBNE:	oBranchTaken 	= 	~Zb;		// Take a branch if B is non Zero
		/*
			BBCS:
					Branch if CarryB is set.
		*/
		`BBCS:	oBranchTaken 	= 	iCarryB;		// Take a branch if CarryB is set
		/*
			BBCC:
					Branch if CarryB is clear.
		*/
		`BBCC:	oBranchTaken 	= 	~iCarryB;	// Take a branch if CarryB is clear
		/*
			BBMI:
					Branch if reg B is positive.
		*/
		`BBMI:	oBranchTaken 	= 	Nb;	// Take a branch if reg B is positive.
		/*
			BBPL:
					Branch if reg B is positive.
		*/
		`BBPL:	oBranchTaken 	= 	~Nb;	// Take a branch if reg B is positive.
		////////////////////////////////////////////////////////////////
		/*
			When its not a branch instruction:
				- Indicate that there is no branch to take
				- Output the data we got
		*/
		default:
			begin
				oBranchTaken 	=	1'b0;			// No branch needed
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule


