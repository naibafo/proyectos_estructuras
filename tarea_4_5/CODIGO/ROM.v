`timescale 1ns / 1ps
`include "Defintions.v"

module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
		0: oInstruction = { `STO , 8'b1, 16'hffff};	

	default:
		oInstruction = { `NOP ,  10'b0 };		//NOP
	endcase	
end
	
endmodule
