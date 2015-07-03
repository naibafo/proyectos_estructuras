
`timescale 1ns / 1ps
module ROM
(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `LDCA , 10'd16};
	1: oInstruction = { `LDCB , 10'd16};
	2: oInstruction = { `NOP , 10'b0};
	3: oInstruction = { `ADDA , 10'b1};
	4: oInstruction = { `NOP , 10'd2};
	5: oInstruction = { `NOP , 10'd3};
	6: oInstruction = { `BAPL , 10'b1111111100};
	7: oInstruction = { `STB , 10'b0};


	default:
		oInstruction = { `NOP ,  10'b10101010 };		//NOP
	endcase	
end
	
endmodule
