`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;

	// Inputs for the ID module
	reg [7:0] regA; 
	reg [7:0] regB;
	reg [5:0] Operation;
	reg [9:0] Data; 
	reg		   CarryA;
	reg		   CarryB;
	
	// Outputs from the ID module
	wire [5:0] 	OperationID;
	wire [9:0] 	DataID;
	wire		BranchTaken; 
	
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	InstructionDecoder UUT
	(
		.Clock(Clock),				// 	Input Clock
		.Reset(Reset|BranchTaken),	// 	Reset signal
		.iOperation_IF(Operation),	//	Input Operation from the IF		
		.iData_IF(Data),			//	Input Data from the IF
		.iRegA(regA),				//	Reg A
		.iCarryA(CarryA),			//	Carry A
		.iRegB(regB),				//	Reg B
		.iCarryB(CarryB),			//	Carry B
		.oOperation_ID(OperationID),//	Output Operation
		.oData_ID(DataID),			//	Output Data
		.oBranchTaken(BranchTaken)	//	Flag that indicates if we need to branch
	);
	
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("ID.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		Operation = `LDA;
		regA = 0;
		regB = 0;
		Data = 10'b1010101010;
		
		// Wait 100 ns for global reset to finish
		#15;
		Reset = 1;
		#20
		Reset = 0;
        
        // No Branch should be taken:
		#20 
		regA = 8'b00101010; 
		Operation = `BAPL;
		
		
		#90 
		regA = 8'hFF;
		
		
		#50
		$finish;

	end
      
endmodule
