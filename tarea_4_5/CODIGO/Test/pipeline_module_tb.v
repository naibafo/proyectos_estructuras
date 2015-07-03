module entire_module_tb;
	
	reg Clock;
	reg Reset;
	
	wire A;
	wire B;
	
	pipeline p1 (Clock, Reset, A, B);
	
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
