////////////////////////////////////////////////////////////////////////
//// MODULE: WriteBack                                              ////
////////////////////////////////////////////////////////////////////////
/*
		Write Back:
			-	Maganages the logic to modify the general purpose 
				registers, and gives given registers to the rest of the 
				modules.
*/
module WriteBack
(
	input wire	 		Clock,		// 	Input Clock
	input wire 		Reset,		// 	Reset signal
	output wire [7:0]	oRegA,		//	Reg A
	output wire [7:0]	oRegB,		//	Reg B
	input wire  [7:0]	iData,		//	Input Data
	input wire 		iModA,		// 	Flag to modificate Reg A
	input wire 		iModB		// 	Flag to modificate Reg B
);

// --------------------- //
//           A           //
// --------------------- //

FFD # ( 8 ) A_Reg 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(iModA),
	.D		(iData),
	.Q		(oRegA)
);

// --------------------- //
//           B           //
// --------------------- //

FFD # ( 8 ) B_Reg 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(iModB),
	.D		(iData),
	.Q		(oRegB)
);

////////////////////////////////////////////////////////////////////////
endmodule
