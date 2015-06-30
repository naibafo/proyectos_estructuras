////////////////////////////////////////////////////////////////////////
//// MODULE: WriteBack                                              ////
////////////////////////////////////////////////////////////////////////
/*
		Write Back:
			-	Maganages the logic to modify the general purpose 
				registers, and gives given registers to the rest of the 
				modules.
			-	Receives an 8 bit value, a carry an wich register to modify
*/
module WriteBack
(
	input wire	 		Clock,		// 	Input Clock
	input wire 			Reset,		// 	Reset signal
	output wire [7:0]	oRegA,		//	Reg A
	output wire [7:0]	oRegB,		//	Reg B
	output wire 		oCarryA,	//	Carry for Reg A
	output wire 		oCarryB,	//	Carry for Reg B
	input wire  [7:0]	iData,		//	Input Data
	input wire			iCarry,		// 	Input Carry
	input wire 			iModA,		// 	Flag to modificate Reg A
	input wire 			iModB		// 	Flag to modificate Reg B
);

// --------------------- //
//           A           //
// --------------------- //

FFD # ( 9 ) A_Reg 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(iModA),
	.D		({iCarry,iData}),
	.Q		({oCarryA,oRegA})
);

// --------------------- //
//           B           //
// --------------------- //

FFD # ( 9 ) B_Reg 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(iModB),
	.D		({iCarry,iData}),
	.Q		({oCarryB,oRegB})
);

////////////////////////////////////////////////////////////////////////
endmodule
