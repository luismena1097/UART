/*
	Contador comparador para contar bits
*/

module contador_comparador//Contador comparador
#(parameter DW=4, limit=10)(
	input clk, rst, en,
	output enable_out,
	output reg [DW-1:0]contador
);
	 
wire igual;

assign igual = contador>= (limit);
assign enable_out=igual & en;

always@(posedge clk or posedge rst)
begin
	if(rst)
		contador<= {DW{1'b0}};
	else 
	if(en)
	begin
		if(igual)
			contador<={DW{1'b0}};
		else
			contador<=contador + 1'b1;
	end
	else
		contador <= contador;
end

endmodule