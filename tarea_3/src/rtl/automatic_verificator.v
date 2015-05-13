module verificator
(
	input wire [31:0] iR_dut,
	input wire [31:0] iR_nut,
	input wire Clock,
	input wire Reset,
	output reg good
);
	always @(posedge Clock)
		begin
			if (Reset) good <= 0;
			else
				begin
					if (iR_dut == iR_nut) good <= 1;
					else good <= 0;
				end
		end
endmodule

module automatic_verificator_tb
	reg Clock;
	reg Reset;
	reg [31:0] A;
	reg [31:0] B;
	reg Valid_Data_Flag, Ack_Flag;
	wire Done, Idle;
	wire [31:0] Result_dut;
	wire [31:0] Result_nut;
	
	
	
