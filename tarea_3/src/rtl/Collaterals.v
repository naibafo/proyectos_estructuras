/*
	Collaterals.v
		Defines two modules:
			Data_Path
			Counter
*/

////////////////////////////////////////////////////////////////////
//// Module: Data_Path
////////////////////////////////////////////////////////////////////

module Data_Path
(
	input	wire	[31:0]	iData_A, 		// Input data A  
	input	wire	[31:0]	iData_B,		// Input data B
	input 	wire	        iData_Reset,	// 
	input	wire 			Clock,			// 
	output	reg		[31:0]	oProduct		// 
);

// Registers Definition
reg [31:0] reg_B;
reg [31:0] reg_A;

// Define a Sum Result
reg [31:0] wTmp_Sum;
wire add_sel;
assign add_sel = reg_B[0];

always @ (posedge Clock) 
	begin
		wTmp_Sum = (!add_sel) ? oProduct : (oProduct + reg_A);
		oProduct = (iData_Reset) ? 32'b0   : wTmp_Sum ;
		reg_B 	 = (iData_Reset) ? iData_B : (reg_B >> 1);
		reg_A 	 = (iData_Reset) ? iData_A : (reg_A << 1);	
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
