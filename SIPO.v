/*
	Registro SIPO (Serial Input Parallel Output)
	Diseño realizado por: Luis Mena 
*/
module SIPO #(parameter DW=8)(
	 input serial_input,
	 input rst, en, clk, 
	 output[DW-1:0] Parallel_out
    );

reg [DW-1:0] register;

always@(posedge clk or posedge rst)
if(rst)
	register <= 'b0;
else if(en)
		register <= {serial_input,register[DW-1:1]};

assign Parallel_out = register;

endmodule