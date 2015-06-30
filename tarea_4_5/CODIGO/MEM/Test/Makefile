all: TB

TB: MEM_tb.v ../execution.v ../../Definitions.v ../../ROM.v ../../Collaterals.v 
	iverilog -o MEM.test ../../Collaterals.v ../../Definitions.v ../../ROM.v ../Memory.v MEM_tb.v
	./MEM.test
	gtkwave MEM.vcd 
