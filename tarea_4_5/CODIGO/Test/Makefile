all: TB

TB: TestBench.v ../Collaterals.v ../Definitions.v ../ROM.v ../IF/InstructionFetch.v ../ID/InstructionDecode.v
	iverilog -o Pipeline.test ../Collaterals.v ../Definitions.v ../ROM.v ../IF/InstructionFetch.v ../ID/InstructionDecode.v TestBench.v
	./Pipeline.test
	gtkwave Pipeline.vcd Pipeline.gtkw
