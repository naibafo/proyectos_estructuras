all: TB

TB: EXC_tb.v ../execution.v ../../Definitions.v ../../ROM.v ../../Collaterals.v 
	iverilog -o EXC.test ../../Collaterals.v ../../Definitions.v ../execution.v EXC_tb.v
	./EXC.test
	gtkwave EXC.vcd EXC.gtkw &
