all: TB

TB: ID_TestBench.v ../InstructionDecode.v ../../Definitions.v ../../Collaterals.v
	iverilog -o ID.test ../../Collaterals.v ../../Definitions.v ../InstructionDecode.v ID_TestBench.v
	./ID.test
	gtkwave ID.vcd ID.gtkw
