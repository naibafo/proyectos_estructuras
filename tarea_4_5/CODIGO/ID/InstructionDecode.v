/*
	MODULE:
		Instruction Decode
*/

module InstructionDecoder
(
	input wire	 		Clock,				// 	Input Clock
	input wire 		Reset,				// 	Reset signal
	input wire	[5:0]	iOperation_IF,		//	Input Operation from the IF		
	input wire	[9:0]	iData_IF,			//
	input wire			iRegA,				//	
	input wire			iRegB,				//	
	output reg	[5:0]	oOperation_ID,		//
	output reg	[5:0]	oData_ID,			//
	output reg			oBrachTaken,		//	
);


always @ (posedge Clock)
	////////////////////////////////////////////////////////////////////
	case (iOperation_IF)
	////////////////////////////////////////////////////////////////////
		`NOP:
			begin
			end
		///////////////////////////////////////
		/*
			When its not a branch instruction:
				- Output the same operation
				- Indicate that there is no branch to take
				- Output the data we got
		*/
		default:
			begin
				oOperation_ID 	= 	iOperation_IF;	// 
				oBranchTaken 	=	1'b0;			// 
				oData_ID		= 	iData_IF;		//
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule


endmodule
