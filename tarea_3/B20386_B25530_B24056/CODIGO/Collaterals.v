/*
	Collaterals.v
		Defines following modules:
			Data_Path
			Counter
			Verificator
			Conductual_Multiplier
*/

////////////////////////////////////////////////////////////////////
//// Module: Data_Path
////////////////////////////////////////////////////////////////////

module Data_Path  # (parameter SIZE=32) 
(
	input	wire	[SIZE-1:0]		iData_A, 		// Input data A  
	input	wire	[SIZE-1:0]		iData_B,		// Input data B
	input 	wire	        		iData_Reset,	// 
	input	wire 					Clock,			// 
	output	reg		[2*SIZE-1:0]	oProduct		// 
);

// Registers Definition
reg [SIZE-1:0] reg_B;
reg [2*SIZE-1:0] reg_A;

// Define a Sum Result
reg [2*SIZE-1:0] wTmp_Sum;
wire add_sel;
assign add_sel = reg_B[0];

always @ (posedge Clock)
	begin
		wTmp_Sum = (!add_sel) ? oProduct : (oProduct + reg_A);
		oProduct = (iData_Reset) ? {2*SIZE{1'b0}} : wTmp_Sum ;
		reg_B 	 = (iData_Reset) ? iData_B : (reg_B >> 1);
		reg_A 	 = (iData_Reset) ? {{SIZE{1'b0}},iData_A} : (reg_A << 1);	
	end


endmodule
////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//// Module: Counter
////////////////////////////////////////////////////////////////////

module Counter # (parameter SIZE=5)
(
	input wire Clock, iCounterReset,
	output reg [SIZE-1:0] oCounter
);

// Counter logic
always @(posedge Clock )
	begin	
		// Synchronous Reset 
		if (iCounterReset)
			oCounter = 0;
		else
			begin
				oCounter = oCounter + 1;
			end			
	end

endmodule
////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////
//// Module: Verificator
////////////////////////////////////////////////////////////////////
module verificator
(
	input wire [63:0] iR_dut,
	input wire [63:0] iR_nut,
	input wire Clock,
	input wire Reset,
	output reg	 good
);
	always @(posedge Clock)
		begin
			if (Reset) good = 0;
			else
				begin
					if (iR_dut == iR_nut) good = 1;
					else good = 0;
				end
		end
endmodule 
/////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//// Module: Coductual_Multiplier
////////////////////////////////////////////////////////////////////

module Conductual_Multiplicator
(
	input	wire	[31:0]	iData_A, 	// 	Input data A  
	input	wire	[31:0]	iData_B,	// 	Input data B
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that 
	input	wire	iAcknoledged,		//	Input flaf that 
	output	reg		oDone,				//	Output flag that indicates when the data is ready 
	output	reg		oIdle,				//	Output flag that indicates when the multiplier is ready to load data in
	output	reg 	[63:0]	oResult
);
	always @(posedge Clock)
		begin
			if(iValid_Data)
				begin
					oResult = iData_A*iData_B;
					oDone <= 1'b1;
					oIdle <= 1'b0;
				end
			else if(iAcknoledged)
				begin
					oResult = 63'b0;
					oIdle <= 1'b1;
					oDone <= 1'b0;
				end
		end

endmodule
///////////////////////////////////////////////////////////////////////
