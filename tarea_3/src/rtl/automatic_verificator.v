`include "Mult_Controller.v"

module verificator
(
	input wire [63:0] iR_dut,
	input wire [63:0] iR_nut,
	input wire Clock,
	input wire Reset,
	output reg	 good
);
	always @(posedge Clock)
		begin
			if (Reset) good = 0;
			else
				begin
					if (iR_dut == iR_nut) good = 1;
					else good = 0;
				end
		end
endmodule

module Conductual_Multiplicator
(
	input	wire	[31:0]	iData_A, 	// 	Input data A  
	input	wire	[31:0]	iData_B,	// 	Input data B
	input 	wire	Clock,
	input 	wire	Reset,
	input 	wire 	iValid_Data,		// 	Input flag that 
	input	wire	iAcknoledged,		//	Input flaf that 
	output	reg		oDone,				//	Output flag that indicates when the data is ready 
	output	reg		oIdle,				//	Output flag that indicates when the multiplier is ready to load data in
	output	reg 	[63:0]	oResult
);
	always @(posedge Clock)
		begin
			if(iValid_Data)
				begin
					oResult = iData_A*iData_B;
					oDone <= 1'b1;
					oIdle <= 1'b0;
				end
			else if(iAcknoledged)
				begin
					oIdle <= 1'b1;
					oDone <= 1'b0;
				end
		end

endmodule

module automatic_verificator_tb;
	//Signals 
	reg Clock;
	reg Reset;
	reg [31:0] A;
	reg [31:0] B;
	reg Valid_Data_Flag, Ack_Flag;
	wire Done, Idle;
	wire [63:0] Result_dut;
	wire [63:0] Result_nut;
	wire is_all_good;
	
	//Clock
	always
	  begin
	    if (Clock)
		  #5 Clock =  0;
		else
		  #5 Clock = 1;
	  end
	
	Multiplicator dut
	(
		.iData_A(A),
		.iData_B(B),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(Valid_Data_Flag),	
		.iAcknoledged(Ack_Flag),		 
		.oDone(Done),				
		.oIdle(Idle),				
		.oResult(Result_dut)
	);
	
	Conductual_Multiplicator nut
	(
		.iData_A(A),
		.iData_B(B),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(Valid_Data_Flag),	
		.iAcknoledged(Ack_Flag),		 
		.oDone(Done),				
		.oIdle(Idle),				
		.oResult(Result_nut)
	);
	
	verificator dut_nut_comparator
	(
		.iR_dut(Result_dut),
		.iR_nut(Result_nut),
		.Clock(Clock),
		.Reset(Reset),
		.good(is_all_good)
	);
	
	always @ (posedge Done)
	begin
		# 50 Ack_Flag = 1;	
	end
	

	always @ (negedge Done)
	begin
		# 50  Ack_Flag = 0;	
	end
		
	always @ (posedge Idle)
	begin
		A <= $unsigned($random) %10;
		B <= $unsigned($random) %10;
		# 500 Valid_Data_Flag <= 1;
		# 100 Valid_Data_Flag <= 0;	
	end
	
	initial 
	begin
	  // GTKwave
	  $dumpfile("av_Waves.vcd");
	  $dumpvars;
	  
	  // Inicializar señales primarias
	  #5 Clock = 0;
         Reset = 0;
         Ack_Flag = 0;
         Valid_Data_Flag = 0; 
         A = 1; 
		 B = 1;
	  // Hacer un reset para iniciar el conteo
	  #15 Reset = 1;
	  #80 Reset = 0;
        
	  #5000 $finish;                                                                                            

	end
	
endmodule
	
