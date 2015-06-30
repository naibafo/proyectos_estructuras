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
	wire [7:0] oResult;
	wire oCarry;
	
	wire [5:0] oOperation_EXC;
	wire [9:0] oData_EXC;
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	Execution DUT
	(
		.Clock(Clock),				// 	Input Clock
		.Reset(Reset),
		.iOperation_ID(Operation_ID),
		.iData_ID(Data_ID),
		.iReg_A(RegA),
		.iCarryA(CarryA),
		.iReg_B(RegB),
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
		
		RegA = 8'b11010101;
		CarryA = 1'b0;
		
		RegB = 8'b10101010;
		CarryA = 1'b0;
		
		Operation_ID = `ADDA;
		Data_ID = 9'b1;
		
		# 5
		Reset = 1;
		# 20
		Reset = 0;
		
		#20 Operation_ID = `ADDCB;
		#20 Operation_ID = `ORB;
		#100
		$finish;

	end
      
endmodule
