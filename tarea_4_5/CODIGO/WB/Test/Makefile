all: TB

TB: WB_TestBench.v ../WriteBack.v ../../Definitions.v ../../Collaterals.v 
	iverilog -o WB.test ../../Collaterals.v ../../Definitions.v ../WriteBack.v WB_TestBench.v
	./WB.test
	gtkwave WB.vcd WB.gtkw
