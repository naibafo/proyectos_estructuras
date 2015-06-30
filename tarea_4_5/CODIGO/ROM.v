
`timescale 1ns / 1ps
module ROM
(
	input  wire[9:0]  		iAddress,
	output reg [15:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
<<<<<<< HEAD
	0: oInstruction = { `LDA , 10'b1111100000};
	1: oInstruction = { `LDB , 10'b0000011111};
	2: oInstruction = { `ADDCA , 10'b1111111111};
	3: oInstruction = { `ADDCB , 10'b1010101010};
	4: oInstruction = { `STB , 10'b0};
	5: oInstruction = { `STA , 10'b1};
	6: oInstruction = { `BAEQ , 10'b0};
=======
	0: oInstruction = { `NOP  , 10'b0};
	1: oInstruction = { `LDCA , 10'b0};
	2: oInstruction = { `LDCB , 10'b1};
	3: oInstruction = { `NOP  , 10'b0};
	4: oInstruction = { `ADDA , 10'b0};
	5: oInstruction = { `NOP  , 10'b0};
	6: oInstruction = { `ADDA , 10'b0};
	7: oInstruction = { `NOP  , 10'b0};
	8: oInstruction = { `BAMI , 10'b1111111011};
>>>>>>> b6abb876cbe400ac547abf065d9774f079480a6e


	default:
		oInstruction = { `NOP ,  10'b10101010 };		//NOP
	endcase	
end
	
endmodule
