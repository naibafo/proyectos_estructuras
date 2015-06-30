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
	
	input wire [7:0] iReg_A,
	input wire iCarryA,
	
	input wire [7:0] iReg_B,
	input wire iCarryB,
		
	output reg [7:0] oResult,
	output reg oCarry,
	
	output wire [5:0] oOperation_EXC,
	output wire [9:0] oData_EXC
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
		`ADDA:	{oCarry,oResult} 	= 	iReg_A + iReg_B;
					
		/*
			ADDB:
					B = A+B.
		*/
		`ADDB:	{oCarry,oResult} 	= 	iReg_A + iReg_B;
		
		/*
			ADDCA:
					A = A+const.
		*/
		`ADDCA:	{oCarry,oResult} 	= 	iReg_A + oData_EXC;
		
		/*
			ADDCB:
					B = B+const.
		*/
		`ADDCA:	{oCarry,oResult} 	= 	iReg_B + oData_EXC;	
		
		/*
			SUBA:
					A = A-B.
		*/
		`SUBA:	{oCarry,oResult} 	= 	iReg_A - iReg_B;
		
		/*
			SUBB:
					B = B-A.
		*/
		`SUBB:	{oCarry,oResult} 	= 	iReg_B - iReg_A;
		
		/*
			SUBCA:
					A = A-const.
		*/
		`SUBCA:	{oCarry,oResult} 	= 	iReg_A - oData_EXC;	

		/*
			SUBCB:
					B = B-const.
		*/
		`SUBCB:	{oCarry,oResult} 	= 	iReg_A - oData_EXC;					

		/*
			ANDA:
					A = A & B.
		*/
		`ANDA:	{oCarry,oResult} 	= 	iReg_A & iReg_B;	

		/*
			ANDB:
					B = A & B.
		*/
		`ANDB:	{oCarry,oResult} 	= 	iReg_A & iReg_B;	

		/*
			ANDCA:
					A = A & const.
		*/
		`ANDCA:	{oCarry,oResult} 	= 	iReg_A & oData_EXC;	

		/*
			ANDCB:
					B = B & const.
		*/
		`ANDCB:	{oCarry,oResult} 	= 	iReg_A & oData_EXC;

		/*
			ORA:
					A = A | B.
		*/
		`ORA:	{oCarry,oResult} 	= 	iReg_A | iReg_B;
		
		/*
			ORB:
					B = A | B.
		*/
		`ORB:	{oCarry,oResult} 	= 	iReg_A | iReg_B;

		/*
			ORCA:
					A = A | const.
		*/
		`ORCA:	{oCarry,oResult} 	= 	iReg_A | oData_EXC;
		
		/*
			ORCB:
					B = B | const.
		*/
		`ORCB:	{oCarry,oResult} 	= 	iReg_B | oData_EXC;
		
		/*
			ASLA:
					A={(A6),(A5),(A4), (A3), (A2), (A1), (A0),0}
		*/
		`ASLA:	{oCarry,oResult} 	= 	iReg_A << 1;

		/*
			ASRA:
					A={0,(A7), (A6),(A5), (A4), (A3), (A2), (A1)}
		*/
		`ASRA:	{oCarry,oResult} 	= 	iReg_A >> 1;

	
		default:
			begin
				{oCarry,oResult} 	=	9'b0;			// No branch needed
			end	
	////////////////////////////////////////////////////////////////////
	endcase	
	////////////////////////////////////////////////////////////////////
endmodule 
