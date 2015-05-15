`include "Mult_Controller.v"

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
	
