
`timescale 1ns / 1ps
module ROM
(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
	0: oInstruction = { `LDA , 10'b1111100000};
	1: oInstruction = { `LDB , 10'b0000011111};
	2: oInstruction = { `ADDCA , 10'b1111111111};
	3: oInstruction = { `ADDCB , 10'b1010101010};
	4: oInstruction = { `STB , 10'b0};
	5: oInstruction = { `STA , 10'b1};
	6: oInstruction = { `BAEQ , 10'b1111111011};
	7: oInstruction = { `SUBA , 10'h3};


	default:
		oInstruction = { `NOP ,  10'b10101010 };		//NOP
	endcase	
end
	
endmodule
