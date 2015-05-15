all: mult

mult:
	iverilog TestBench.v -o simulate.x
	./simulate.x
	gtkwave Waves.vcd &

verifier:
	iverilog automatic_verificator.v -o simulate_stuff.x
	./simulate_stuff.x
	gtkwave av_Waves.vcd  &
	
mult4:
	iverilog TestBench4x4.v -o Simulation4x4.x
	./Simulation4x4.x
	gtkwave 4x4Waves.vcd &

clean:	
	rm *.x 1
