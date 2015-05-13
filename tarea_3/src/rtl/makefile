all:

testbench:
	iverilog TestBench.v -o simulate.x
	./simulate.x
	gtkwave Waves.vcd 2>1&

testbench_verificator:
	iverilog automatic_verificator.v -o simulate_stuff.x
	./simulate_stuff.x
	gtkwave av_Waves.vcd 2>1&
