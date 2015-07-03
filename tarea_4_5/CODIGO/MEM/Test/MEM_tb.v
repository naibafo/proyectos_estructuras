`timescale 1ns / 1ps

module TestBench;

	// Clock and Reset Signals
	reg Clock;
	reg Reset;
	
	// Inputs from the ID module
	reg [5:0] 	Operation_ID;
	reg [9:0] 	Data_EXC;
	
	reg [7:0] RegA;
	reg [7:0] RegB;


	//Output from EXC module
	reg [7:0] iResult;
	reg iCarry;
	
	wire oOperation_EXC;
	wire oData_EXC;
	
	wire [7:0] DataOut;
	wire ModA, ModB;
	
	wire CarryFlag;
	
	// ---------------------
	// Module instanciation:
	// ---------------------
	
	Memory DUT
	(
	.Clock(Clock),
	.Reset(Reset),		
	.iResult(iResult),	
	.iData(Data_EXC),		
	.iCarry_result(iCarry), 
	.iRegA(RegA),		
	.iRegB(RegB),		
	.iOperation(Operation_ID),  
	.oData(DataOut),		
	.oModA(ModA),		
	.oModB(ModB),
	.oCarry_flag(CarryFlag)		
	);
	
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("MEM.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		RegA = 7'b1000010;
		RegB = 7'b0101010;
		Operation_ID = `NOP;
		iResult = 7'b0000010;
		Data_EXC = 9'b111110000;
		iCarry = 1'b0;
		
		# 5
		Reset = 1;
		# 20
		Reset = 0;
		
		#25
		Operation_ID = `STA;
		#20
		Operation_ID = `LDA;
		#20
		Operation_ID = `ADDB;
		#20
		Operation_ID = `SUBA;
		#20
		Operation_ID = `NOP;
		#150
		$finish;

	end
      
endmodule
