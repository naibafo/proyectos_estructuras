`include "Mult_Controller.v"


module Four_Multiplicador # (parameter SIZE=32, parameter COUNTER_SIZE=5)
(


	input	wire	[SIZE-1:0]	iData_A, 	// 	Input data A  
	input	wire	[SIZE-1:0]	iData_B,	// 	Input data B
	input	wire	[SIZE-1:0]	iData_C, 	// 	Input data C  
	input	wire	[SIZE-1:0]	iData_D, 	// 	Input data D  
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that indicates when the inputs of data are valid
	input	wire	iAcknoledged,		//	Input flag that sends the state machine to Idle State
	output	wire		oDone,				//	Output flag that indicates when the data is ready 
	output	wire		oIdle,				//	Output flag that indicates when the data is ready
	output	wire 	[4*SIZE-1:0]	oResult
);

	wire Enable;
	wire [2*SIZE-1:0] Result1 ;
	wire [2*SIZE-1:0] Result2;
	
	assign oIdle = Idle1 & Idle2 & Idle3; 
	assign Enable = Done1 & Done2;

	Multiplicator  # (SIZE, COUNTER_SIZE) mult1 
	(
		.iData_A(iData_A),
		.iData_B(iData_B),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(iValid_Data),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(Done1),				
		.oIdle(Idle1),				
		.oResult(Result1)
	);
	
	
		Multiplicator # (SIZE, COUNTER_SIZE) mult2 
	(
		.iData_A(iData_C),
		.iData_B(iData_D),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(iValid_Data),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(Done2),				
		.oIdle(Idle2),				
		.oResult(Result2)
	);
	
		Multiplicator # (2*SIZE, COUNTER_SIZE+1) mult3 
	(
		.iData_A(Result1),
		.iData_B(Result2),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(Enable),	
		.iAcknoledged(iAcknoledged),		 
		.oDone(oDone),				
		.oIdle(Idle3),				
		.oResult(oResult)
	);	



endmodule
