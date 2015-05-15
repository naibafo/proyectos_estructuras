module 4x4Multiplicador (


	input	wire	[31:0]	iData_A, 	// 	Input data A  
	input	wire	[31:0]	iData_B,	// 	Input data B
	input	wire	[31:0]	iData_C, 	// 	Input data C  
	input	wire	[31:0]	iData_D, 	// 	Input data D  
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that indicates when the inputs of data are valid
	input	wire	iAcknoledged,		//	Input flag that sends the state machine to Idle State
	output	reg		oDone,				//	Output flag that indicates when the data is ready 
	output	reg		oIdle,				//	Output flag that indicates when the data is ready
	output	wire 	[31:0]	oResult
);

	Multiplicator mult1
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
	
	
		Multiplicator mult2
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



endmodule
