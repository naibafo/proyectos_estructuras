`include "Mult_Controller.v"

module Multiplicator_3_in  # (parameter SIZE=32, parameter COUNTER_SIZE=5)
(
	input	wire	[SIZE-1:0]	iData_A, 	// 	Input data A  
	input	wire	[SIZE-1:0]	iData_B,	// 	Input data B
	input	wire	[SIZE-1:0]	iData_C, 	// 	Input data C  
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that indicates when the inputs of data are valid
	input	wire	iAcknoledged,		//	Input flag that sends the state machine to Idle State
	output	wire	oDone,				//	Output flag that indicates when the data is ready 
	output	wire	oIdle,				//	Output flag that indicates when the data is ready
	output	wire 	[4*SIZE-1:0]	oResult
);
	reg [2*SIZE-1:0] rTemp_C;
	
	wire [2*SIZE-1:0] wA_times_B;
	wire wfirst_done;
	wire wIdle1;
	wire wIdle2;
	wire wDone;
	
	always @(posedge iValid_Data) //saves C entry until A*B is ready 
		begin
			rTemp_C = {32'b0, iData_C};
		end 
	
	assign oIdle = wIdle1 & wIdle2;
	
	Multiplicator  # (SIZE, COUNTER_SIZE) mult1 
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
	
	Multiplicator # (2*SIZE, COUNTER_SIZE+1) mult2 
	(
		.iData_A(rTemp_C),
		.iData_B(wA_times_B),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(wfirst_done),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(oDone),				
		.oIdle(wIdle2),				
		.oResult(oResult)
	);	

endmodule
/////////////////////////////////////////////////////////////////////////




