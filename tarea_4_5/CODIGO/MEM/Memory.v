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
	input wire 			iCarry_result, //Input Carry bit from result
	input wire	[7:0]	iRegA,		//	Reg A
	input wire 	[7:0]	iRegB,		//	Reg B
	input wire 	[5:0]	iOperation,  //  Code for operation
	output wire [7:0]	oData,		// 	Output data from memory block
	output reg 			oModA,		// 	Flag to modificate Reg A
	output reg 			oModB,		// 	Flag to modificate Reg B
	output wire		    oCarry_flag //	Carry Flag from Memory
);

// Memory selection decides between read from the RAM or NOT.
reg wMemory_sel;


// --------------------- //
//      Result           //
// --------------------- //

// Wire for the Result form execution.
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

// Wire for the Data form execution.
wire [7:0] wData; 

FFD # ( 8 ) Data_FF 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iData[7:0]),
	.Q		(wData)
);


// Selection signal from Mux wich decides if read from Data or Result 
// from Execution.

reg rSelection;

// Output from the Mux wich selects between Data an Result.
wire [7:0] Result_Sel;
assign Result_Sel = rSelection? wData:wResult;
///////////////////////////////
// I/O for the RAM:
//		-Clock
// 		-Write Enable
//		-Read and Write address
// 		- Registers info input
// 		-Data output from the RAM
///////////////////////////////
reg iWriteEnable;
wire [7:0] Memory_Data;
reg rReg_selection;

// Input for the memory RAM when it's writing one of the resgisters.
wire [7:0] Reg_Data;
assign Reg_Data = rReg_selection? iRegA:iRegB;

// Memory RAM

RAM_DUAL_READ_PORT RAM(

	.Clock(Clock),
	.iWriteEnable(iWriteEnable),
	.iReadAddress(iData),
	.iWriteAddress(iData),
	.iDataIn(Reg_Data),
	.oDataOut(Memory_Data)
);

// Selection between the 
assign oData = wMemory_sel? Memory_Data:Result_Sel;


//////////////////////////////////////////////////////////////////////  
/////////////// 		Carry manage                   ///////////////
//////////////////////////////////////////////////////////////////////


// --------------------- //
//         Carry         //
// --------------------- //

// Carry is passed in the 9th bit of iData from execution
wire wCarry; 

// FFD output with input 8th bit from Data from execution
FFD # ( 1 ) Carry_FF 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iData[8]),
	.Q		(wCarry)
);

// FFD output with input iCarry_result
wire rCarry; 

FFD # ( 1 ) Result_Carry_FF 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iCarry_result),
	.Q		(rCarry)
);

// The result carry from selection wich depends of the instruction.
wire wCarry_sel;

// Carry flag after reading or not from the memory


assign wCarry_sel =  rSelection? wCarry:rCarry;
assign oCarry_flag = wMemory_sel? 1'b0:wCarry_sel;

///////// OP FFD
wire [5:0] wOperation;
FFD # ( 6 ) Operation 
(
	.Clock	(Clock),
	.Reset	(Reset),
	.Enable	(1'b1),
	.D		(iOperation),
	.Q		(wOperation)
);

always @ (wOperation)
	////////////////////////////////////////////////////////////////////
	case (wOperation)
	////////////////////////////////////////////////////////////////////
		
		// --------------------------------
		//	Memory Operations
		// --------------------------------
		
		/*
			LDA:
					Memory ----> A.
		*/
		`LDA:
			begin
				rSelection	=	1'b0;
				wMemory_sel	= 	1'b1;
				rReg_selection=	1'b1;
				iWriteEnable =  1'b0;
				oModA		=	1'b1;
				oModB		=	1'b0; 
			end
////////////////////////////////////////////////////////////////////////			
		`LDB:
			begin
				rSelection	=	1'b0;
				wMemory_sel	= 	1'b1;
				rReg_selection=	1'b0;
				iWriteEnable =  1'b0;
				oModA		=	1'b1;
				oModB		=	1'b0; 
			end
////////////////////////////////////////////////////////////////////////			
		`LDCA:
			begin
				rSelection	=	1'b1;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b1;
				iWriteEnable =  1'b0;
				oModA		=	1'b1;
				oModB		=	1'b0; 
			end
////////////////////////////////////////////////////////////////////////
		`LDCB:
			begin
				rSelection	=	1'b1;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b0;
				iWriteEnable =  1'b0;
				oModA		=	1'b0;
				oModB		=	1'b1; 
			end
////////////////////////////////////////////////////////////////////////					
		`STA:
			begin
				rSelection	=	1'b1;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b1;
				iWriteEnable =  1'b1;
				oModA		=	1'b0;
				oModB		=	1'b0; 			
			end
////////////////////////////////////////////////////////////////////////			
		`STB:
			begin
				rSelection	=	1'b1;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b0;
				iWriteEnable =  1'b1;
				oModA		=	1'b0;
				oModB		=	1'b0; 			
			end
////////////////////////////////////////////////////////////////////////					
		`ADDA,`ADDCA,`SUBA,`SUBCA,`ANDA,`ANDCA,`ORA,`ORCA,`ASLA,`ASRA:
			begin
				rSelection	=	1'b0;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b1;
				iWriteEnable =  1'b0;
				oModA		=	1'b1;
				oModB		=	1'b0; 			
			end
////////////////////////////////////////////////////////////////////////
		`ADDB,`ADDCB,`SUBB,`SUBCB,`ANDB,`ANDCB,`ORB,`ORCB:
			begin
				rSelection	=	1'b0;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b1;
				iWriteEnable =  1'b0;
				oModA		=	1'b0;
				oModB		=	1'b1; 			
			end
////////////////////////////////////////////////////////////////////////
			
		default:
			begin
				rSelection	=	1'b0;
				wMemory_sel	= 	1'b0;
				rReg_selection=	1'b0;
				iWriteEnable =  1'b0;
				oModA		=	1'b0;
				oModB		=	1'b0;
			end	
	////////////////////////////////////////////////////////////////////
	endcase	




////////////////////////////////////////////////////////////////////////
endmodule
