/*
	Registro PISO (Parallel Input Serial Output)
	Diseño realizado por: Luis Mena & David Monteon
	Practica 2
*/
module PISO #(parameter DW=5) (
input clk, nrst, enable, load, 
input [DW-1:0] Data,
output reg Q
);

reg [DW-1:0] register;

always@(posedge clk or posedge nrst)
begin
	if(nrst)
	begin
		register <= {DW{1'b0}};
		Q <= 1'b0;
	end
	else
	begin	
	if(load)
		register <= Data;
	else
		register <= register;
		
	if(enable)
	begin
		Q <= register[0];
		register <= {1'b0,register[DW-1:1]};
	end
	end
end




endmodule
