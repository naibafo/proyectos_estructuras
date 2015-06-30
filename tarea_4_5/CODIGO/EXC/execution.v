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
	
	input wire [5:0] iOperation_ID,
	input wire [9:0] iData_ID,
	
	input wire [7:0] iRegA,
	input wire iCarryA,
	
	input wire [7:0] iRegB,
	input wire iCarryB,
	
	output reg [7:0] oResult,
	output reg oCarry,
	
	output wire oOperation_EXC,
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
		
		/*
			SUBCA:
					A = A-const.
		*/
		`SUBCA:	{oCarry,oData_EXC} 	= 	iReg_A - oData_EXC;	

		/*
			SUBCB:
					B = B-const.
		*/
		`SUBCB:	{oCarry,oData_EXC} 	= 	iReg_A - oData_EXC;					

		/*
			ANDA:
					A = A & B.
		*/
		`ANDA:	{oCarry,oData_EXC} 	= 	iReg_A & iReg_B;	

		/*
			ANDB:
					B = A & B.
		*/
		`ANDB:	{oCarry,oData_EXC} 	= 	iReg_A & iReg_B;	

		/*
			ANDCA:
					A = A & const.
		*/
		`ANDCA:	{oCarry,oData_EXC} 	= 	iReg_A & oData_EXC;	

		/*
			ANDCB:
					B = B & const.
		*/
		`ANDCB:	{oCarry,oData_EXC} 	= 	iReg_A & oData_EXC;

		/*
			ORA:
					A = A | B.
		*/
		`ORA:	{oCarry,oData_EXC} 	= 	iReg_A | iReg_B;
		
		/*
			ORB:
					B = A | B.
		*/
		`ORB:	{oCarry,oData_EXC} 	= 	iReg_A | iReg_B;

		/*
			ORCA:
					A = A | const.
		*/
		`ORCA:	{oCarry,oData_EXC} 	= 	iReg_A | oDataEXC;
		
		/*
			ORCB:
					B = B | const.
		*/
		`ORCB:	{oCarry,oData_EXC} 	= 	iReg_B | oDataEXC;
		
		/*
			ASLA:
					A={(A6),(A5),(A4), (A3), (A2), (A1), (A0),0}
		*/
		`ASLA:	{oCarry,oData_EXC} 	= 	iReg_A << 1;

		/*
			ASRA:
					A={0,(A7), (A6),(A5), (A4), (A3), (A2), (A1)}
		*/
		`ASRA:	{oCarry,oData_EXC} 	= 	iReg_A >> 1;

	
		default:
			begin
				oBranchTaken 	=	1'b0;			// No branch needed
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule 
