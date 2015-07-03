module entire_module_tb;
	
	reg Clock;
	reg Reset;
	
	wire [7:0] A;
	wire [7:0] B;
	
	pipeline UUT (Clock, Reset, A, B);
	
	always
		begin
			#10  Clock =  ! Clock;
		end

	initial begin
		// GTKwave
		$dumpfile("Pipeline_mod.vcd");
		$dumpvars;
		
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		
		// Reset Sequence
		#15;
		Reset = 1;
		#20
		Reset = 0;
		
		
		#1000
		$finish;
	end
	
endmodule
