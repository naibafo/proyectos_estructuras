////////////////////////////////////////////////////////////////////
//// STATES DEFINITIONS

`define		STATE_RESET		2'd0
`define		STATE_IDLE		2'd1
`define		STATE_MULT		2'd2
`define		STATE_DONE		2'd3

/////////////////////////////////////////////////////////////////////////
//// Module: Multiplicator                                           ////
/////////////////////////////////////////////////////////////////////////

module Multiplicator
(
	input	wire	[31:0]	iData_A, 	// 	Input data A  
	input	wire	[31:0]	iData_B,	// 	Input data B
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that 
	input	wire	iAcknoledged,		//	Input flaf that 
	output	reg		oDone,				//	Output flag that indicates when the data is ready 
	output	reg		oIdle,				//	Output flag that indicates when the data is ready
	output	reg		oResult
);

/////////////////////////////////////////////////////////////////////////
reg  [1:0] 	rCurrentState;
reg  [1:0] 	rNextState;
reg		  	rData_Select;
/////////////////////////////////////////////////////////////////////////


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Counter Instance                                                    //
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
wire [4:0] wCounter;
reg	  rCounterReset

Counter Counter_32b
(
	.Clock(Clock),
	.iCounterReset(rCounterReset),
	.oCounter(wCounter)
);

// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
// Data_Path Instance                                                  //
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //
module Data_Path
(
	.iData_A(iData_A), 			// Input data A  
	.iData_B(iData_B),			// Input data B
	.iData_Reset(rData_Reset),	// 
	.oResult(oResult)
);
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = //

/////////////////////////////////////////////////////////////////////////
/*
	NEXT STATE LOGIC:
		Manage next state logic (rNextState becames rCurrentState).
		And reset state machine
*/
always @ (posedge Clock)
	begin
		// Synchornous Reset
		if(Reset)
			rCurrentState = `Reset_State; 	// Move to reset state if Reset signal
		else
			rCurrentState = rNextState; 	// Change Current State
	end
/////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////
/*
	CONTROLLER STATE MACHINE.
		Consists of 4 states (therefore the 2 bit state registers).
			- STATE RESET
			- STATE IDLE
			- STATE MULT
			- STATE DONE

*/
always @ ( * )
	begin
		case (rCurrentState)
			/* 
				STATE RESET:
					
					State that resets (defines) the signals in the counter
					and the Data_Path.
			*/
			`STATE_RESET:
				begin
					rNextState = `STATE_IDLE; 	// Move on to IDLE state
					rData_Reset  = 1;			// Reset Data
					rCounterReset = 1;			// Reset Counter
					oDone = 0;					// Define oDone
					oIdle = 0;					// Define oIdle
				end
			/*
				STATE_IDLE:
					
					We are waiting for valid data. We reset counter and 
					data in the data path. Set oIdle flag up to comunicate
					that we are ready to receive data
			*/
			`STATE_IDLE:
				begin
					rNextState = (iValid_Data) ? `STATE_MULT : `STATE_IDLE ;
					rCounterReset = 1;	// 	Reset Counter for next state
					rData_Reset  = 1;	// 	Keep charging new data
					oDone = 0;			// 	Not even close to been close
					oIdle = 1;			//	We are Idle
				end
			/*
				STATE_MULT:
					
					In here most of the work is done by the Data_Path. By
					leaving the rData_Reset in 0, and waiting exactly 32 
					cycles.
					
					When we reach the 32 bit cycles. We move on to DONE 
					state
			*/
			`STATE_MULT:
				begin
					rNextState = (wCounter == 5'd31) ? `STATE_DONE : `STATE_MULT;
					rData_Reset = 0; 		// No reset of data
					rCounterReset = 0;		// No reset of counter
					oDone = 0;				// Not Done
					oIdle = 0;				// Not Idle
				end
			/*
				STATE_DONE:
					
					We have the product ready. We send a oDone flag, to 
					comunicate that we already have the result and then 
					we check the iAcknoledged flag to move on to a IDLE
					state.
					
					Important to hold rData_Reset in 0, so result doesnt
					change 
			*/
			`STATE_DONE:
				begin
					rNextState = (iAcknoledged) ? `STATE_IDLE : `STATE_DONE;
					rData_Reset = 0; 	// This is so we maintain the exit
					rCounterReset = 1;	// No need to count 
					oDone = 1;			// We are done
					oIdle = 0;			// Not done
				end
		endcase
	end
endmodule
/////////////////////////////////////////////////////////////////////////


