all: CODE TB

CODE: ../code_parser.pl
	../code_parser.pl -code ../RUN.w -out ../ROM.v 

TB: TestBench.v ../Collaterals.v ../Definitions.v ../ROM.v  ../RAM.v ../IF/InstructionFetch.v ../ID/InstructionDecode.v ../EXC/execution.v ../MEM/Memory.v ../WB/WriteBack.v
	iverilog -o Pipeline.test ../Collaterals.v ../Definitions.v ../ROM.v ../RAM.v ../IF/InstructionFetch.v ../ID/InstructionDecode.v ../EXC/execution.v ../MEM/Memory.v ../WB/WriteBack.v TestBench.v
	./Pipeline.test
	gtkwave Pipeline.vcd Pipeline.gtkw
