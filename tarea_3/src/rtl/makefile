all:

testbench:
	iverilog TestBench.v -o simulate.x
	./simulate.x
	gtkwave Waves.vcd 2>1&
