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
	output	reg	 	[31:0]	oResult			// 
);

// Registers Definition
reg [31:0] reg_B;
reg [31:0] reg_A;

// Wheter we sum or not depends on the last bit of iDataB
wire add_sel;
assign add_sel = iData_B[0];
// Define a Sum Result
wire [31:0] wTmp_Sum;
assign wTmp_Sum = (add_sel) ? rResult : (rResult + reg_A);

always (posedge Clock) 
	begin
		reg_B 	 = (iData_Reset) ? iData_B : (reg_B >> 1);
		reg_A 	 = (iData_Reset) ? iData_A : (reg_A << 1);
		oProduct = (iData_Reset) ? 32'b0   : wTmp_Sum ;
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
		if (Reset)
			oCounter = 0;
		else
			begin
				oCounter = oCounter + 1;
			end			
	end

endmodule
////////////////////////////////////////////////////////////////////
