all: TB

TB: IF_TestBench.v ../InstructionFetch.v ../../Definitions.v ../../ROM.v ../../Collaterals.v 
	iverilog -o IF.test ../../Collaterals.v ../../Definitions.v ../../ROM.v ../InstructionFetch.v IF_TestBench.v
	./IF.test
	gtkwave IF.vcd IF.gtkw
