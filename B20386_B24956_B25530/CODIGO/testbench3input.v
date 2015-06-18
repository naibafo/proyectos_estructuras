`include "multiplicador3entradas.v"

module TestBench;
	// Signals definition
	reg Clock;
	reg Reset;
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] C;
	reg Valid_Data_Flag, Ack_Flag;
	wire Done, Idle;
	wire [127:0] Result;

	//Clock definition 
	always
	  begin
	    if (Clock)
		  #5 Clock =  0;
		else
		  #5 Clock = 1;
	  end
	
	//Unit Under Test (Multiplicador) instance
	
	Multiplicator_3_in uut
	(
		.iData_A(A),
		.iData_B(B),
		.iData_C(C),	
		.Clock(Clock),
		.Reset(Reset),
		.iValid_Data(Valid_Data_Flag),	
		.iAcknoledged(Ack_Flag),		 
		.oDone(Done),				
		.oIdle(Idle),				
		.oResult(Result)
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
		//~ A <= $unsigned($random) %100;
		//~ B <= $unsigned($random) %100;
		A<=A+1;
		B<=B+1;
		C<=C+1;
		# 500 Valid_Data_Flag <= 1;
		# 100 Valid_Data_Flag <= 0;	
	end
	
	initial 
	begin
	  // GTKwave
	  $dumpfile("3inpts_Waves.vcd");
	  $dumpvars;
	  
	  // Inicializar señales primarias
	  #5 Clock = 0;
         Reset = 0;
         Ack_Flag = 0;
         Valid_Data_Flag = 0; 
         A = 1; 
		 B = 2;
		 C = 3;
	  // Hacer un reset para iniciar el conteo
	  #15 Reset = 1;
	  #80 Reset = 0;
        
	  #500000 $finish;                                                                                            

	end
	
	
endmodule
