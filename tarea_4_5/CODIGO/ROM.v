
`timescale 1ns / 1ps
module ROM
(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `NOP , 10'b0};
	1: oInstruction = { `LDCA , 10'b0};
	2: oInstruction = { `LDCB , 10'b1};
	3: oInstruction = { `NOP , 10'b0};
	4: oInstruction = { `ADDA , 10'b0};
	5: oInstruction = { `NOP , 10'b0};
	6: oInstruction = { `ADDA , 10'b0};
	7: oInstruction = { `NOP , 10'b0};
	8: oInstruction = { `BAMI , 10'b1111111011};


	default:
		oInstruction = { `NOP ,  10'b10101010 };		//NOP
	endcase	
end
	
endmodule
