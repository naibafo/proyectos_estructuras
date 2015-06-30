
`timescale 1ns / 1ps
module ROM
(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `ADDA , 10'b0};
	1: oInstruction = { `ADDB , 10'b0};
	2: oInstruction = { `SUBA , 10'b0};
	3: oInstruction = { `SUBB , 10'b0};
	4: oInstruction = { `ADDCA , 10'b0000100001};
	5: oInstruction = { `ADDCB , 10'b0000100001};
	6: oInstruction = { `SUBCA , 10'b0000100001};
	7: oInstruction = { `SUBCB , 10'b0000100001};


	default:
		oInstruction = { `NOP ,  10'b10101010 };		//NOP
	endcase	
end
	
endmodule
