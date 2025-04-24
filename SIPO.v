/*
	Registro SIPO (Serial Input Parallel Output)
	Diseño realizado por: Luis Mena 
*/
module SIPO #(parameter DW=8)(
	 input serial_input,
	 input rst, en, clk, 
	 output [DW-1:0] Parallel_out
    );

reg [DW-1:0] register;

always@(posedge clk or posedge rst)
if(rst)
	register <= 'b0;
else if(en)
	begin
	register <= register << 1;
	register[0] <= serial_input;
	end

assign Parallel_out = {register[0], register[1], register[2], register[3], register[4], register[5], register[6], register[7]};

endmodule