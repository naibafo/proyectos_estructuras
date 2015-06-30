`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;
	
	// Outputs from the ID module
	reg [5:0] 	Operation_ID;
	reg [9:0] 	Data_ID;
	
	reg [7:0] RegA;
	reg CarryA;
	
	reg [7:0] RegB;
	reg CarryB;

	//Output of EXC module
	reg [7:0] oResult;
	reg oCarry;
	
	wire oOperation_EXC;
	wire oData_EXC;
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	Execution DUT
	(
		.Clock(Clock),				// 	Input Clock
		.Reset(Reset),
		.iOperation_ID(Operation_ID),
		.iData_ID(Data_ID),
		.iRegA(RegA),
		.iCarryA(CarryA),
		.iRegB(RegB),
		.iCarryB(CarryB),
		.oResult(oResult),
		.oCarry(oCarry),
		.oOperation_EXC(oOperation_EXC),
		.oData_EXC(oData_EXC)
	);
	
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("EXC.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		
		RegA = 7'b1010101;
		iCarry = 1'b0;
		
		RegB = 7'b0101010;
		iCarry = 1'b0;
		
		Operation_ID = `ADDA;
		Data_ID = 9'b1;
		
		# 5
		Reset = 1;
		# 20
		Reset = 0;
		
		#150
		$finish;

	end
      
endmodule
