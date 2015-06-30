////////////////////////////////////////////////////////////////////////
//// MODULE: Memory                                                 ////
////////////////////////////////////////////////////////////////////////
/*
		Memory:
			-	Manages the logic to read and write to the RAM.
			-	Receives an 10 bit data bus, 8 bit data result
				from execution, and both registers.
			-	Determine wich register should be modified.
*/
module Memory
(
	input wire	 		Clock,		// 	Input Clock
	input wire 			Reset,		// 	Reset signal
	input wire  [7:0]	iResult,	//	Input Result
	input wire  [9:0]	iData,		//	Input Data wich might be a direction of the RAM
	input wire 			iCarry_result,//Input Carry bit from result
	input wire 	[7:0]	iRegA,		//	Reg A
	input wire 	[7:0]	iRegB,		//	Reg B
	output reg  [7:0]	oData,		// 	Output data from memory block
	output reg 			oModA,		// 	Flag to modificate Reg A
	output reg 			oModB		// 	Flag to modificate Reg B
);

// Memory selection decides between read from the RAM or NOT.
wire wMemory_sel;



// --------------------- //
//      Result           //
// --------------------- //

wire [7:0] wResult; 

FFD # ( 8 ) Result_Reg 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iResult),
	.Q		(wResult)
);


// --------------------- //
//   Constant Data       //
// --------------------- //

wire [7:0] wData; 

FFD # ( 8 ) Data_FF 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iData[7:0]),
	.Q		(wData)
);



reg rSelection;
reg Result_Sel;

assign Result_Sel = rSelection? wData:wResult;

wire iWriteEnable;
wire Memory_Data;
reg rReg_selection;

reg	 Reg_Data;
assign Reg_Data = rReg_selection? iReg_B:iReg_A;


RAM_DUAL_READ_PORT RAM(

	.Clock(Clock),
	.iWriteEnable(iWriteEnable),
	.iReadAddress(iData),
	.iWriteAddress(iData),
	.iDataIn(Reg_Data),
	.oDataOut(Memory_Data)
);

assign oData = wMemory_sel? Memory_Data:Result_Sel;


//////////////////////////////////////////////////////////////////////  
/////////////// 		Carry manage                   ///////////////
//////////////////////////////////////////////////////////////////////


// --------------------- //
//         Carry         //
// --------------------- //

// Carry is passed in the 9th bit of iData from execution
reg rCarry; 
assign rCarry = iData[8];

// FFD output with input iCarry_result
wire wCarry; 

FFD # ( 1 ) Carry_FF 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iCarry_result),
	.Q		(wCarry)
);

// The result carry from selection wich depends of the instruction.
reg rCarry_sel;

// Carry flag after reading or not from the memory
reg rCarry_flag;


assign rCarry_sel =  wSelection? rCarry:wCarry;
assign rCarry_flag = wMemory_sel? rCarry_sel:1'b0;



////////////////////////////////////////////////////////////////////////
endmodule
