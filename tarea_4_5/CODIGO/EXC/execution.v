////////////////////////////////////////////////////////////////////////
//// MODULE: Execution                                     ////
////////////////////////////////////////////////////////////////////////
/*
		Execution:
			-	All the arithmetic operations take place in this module. 
*/

module Execution 
(
	input wire Clock,
	input wire Reset,
	
	input wire iOperation_ID,
	input wire iData_ID,
	
	input wire [7:0] iRegA,
	input wire iCarryA,
	
	input wire [7:0] iRegB,
	input wire iCarryB,
	
	output reg [7:0] oResult,
	output reg oCarry,
	
	output wire oOperatio_EXC,
	output wire oData_EXC
	
);

	//Operation
	FFD # ( 6 ) Operation 
	(
		.Clock	(Clock),
		.Reset	(Reset),
		.Enable	(1'b1),
		.D		(iOperation_ID),
		.Q		(oOperation_EXC)
	);

	// Data

	FFD # ( 10 ) Additional_Data 
	(
		.Clock	(Clock),
		.Reset	(Reset),
		.Enable	(1'b1),
		.D		(iData_ID),
		.Q		(oData_EXC)
	);
		
always @ (oOperation_EXC)
	////////////////////////////////////////////////////////////////////
	case (oOperation_EXC)
	////////////////////////////////////////////////////////////////////
		
		// --------------------------------
		//	Branching Operations for reg A
		// --------------------------------
		
		/*
			ADDA:
					A = A+B.
		*/
		`ADDA:	{oCarry,oData_EXC} 	= 	iReg_A + iReg_B;
					
		/*
			ADDB:
					B = A+B.
		*/
		`ADDB:	{oCarry,oData_EXC} 	= 	iReg_A + iReg_B;
		
		/*
			ADDCA:
					A = A+const.
		*/
		`ADDCA:	{oCarry,oData_EXC} 	= 	iReg_A + oData_EXC;
		
		/*
			ADDCB:
					B = B+const.
		*/
		`ADDCA:	{oCarry,oData_EXC} 	= 	iReg_B + oData_EXC;	
		
		/*
			SUBA:
					A = A-B.
		*/
		`SUBA:	{oCarry,oData_EXC} 	= 	iReg_A - iReg_B;
		
		/*
			SUBB:
					B = B-A.
		*/
		`SUBB:	{oCarry,oData_EXC} 	= 	iReg_B - iReg_A;
							
		default:
			begin
				oBranchTaken 	=	1'b0;			// No branch needed
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule 
