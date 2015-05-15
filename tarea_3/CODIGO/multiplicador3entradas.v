`include "Mult_Controller.v"

module Multiplicator_3_in
(
	input	wire	[31:0]	iData_A, 	// 	Input data A  
	input	wire	[31:0]	iData_B,	// 	Input data B
	input	wire	[31:0]	iData_C, 	// 	Input data C  
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that indicates when the inputs of data are valid
	input	wire	iAcknoledged,		//	Input flag that sends the state machine to Idle State
	output	reg		oDone,				//	Output flag that indicates when the data is ready 
	output	reg		oIdle,				//	Output flag that indicates when the data is ready
	output	wire 	[127:0]	oResult
);
	
	reg [32:0] rTemp_C;
	reg [64:0] rTemp2_C;
	
	wire [63:0] wA_times_B;
	wire wfirst_done;
	wire wIdle1;
	wire wIdle2;
	wire wIdleG;
	wire wDone;
	
	always @(posedge iValid_Data) //saves C entry until A*B is ready 
		begin
			//~ rTemp_C = {32b'0, iData_C};
			rTemp_C = iData_C;
			oDone = wDone;
			oIdle = wIdleG;	
		end 
	
	rTemp2_C = {32b'0, rTemp_C};
	
	Multiplicator # (32, 5) mult1 
	(
		.iData_A(iData_A),
		.iData_B(iData_B),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(iValid_Data),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(wfirst_done),				
		.oIdle(wIdle1),				
		.oResult(wA_times_B)
	);
	
	
		Multiplicator # (64, 6) mult2 
	(
		.iData_A(wA_times_B),
		.iData_B(iData_C),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(wfirst_done),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(wDone),				
		.oIdle(wIdle2),				
		.oResult(oResult)
	);
	
	and(wIdleG, wIdel1, wIdle2);
	

endmodule
/////////////////////////////////////////////////////////////////////////




