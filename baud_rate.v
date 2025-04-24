/*
	Contador comparador para generar el baud rate
*/

module baud_rate//Contador comparador
#(parameter DW=4, limit=10)(
	input clk, rst, en,
	output enable_out, 
	output reg baud_rate_clk,
	output reg [DW-1:0]contador
);
	 
wire igual;

assign igual = contador>= (limit);
assign enable_out=igual & en;

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		contador<= {DW{1'b0}};
		baud_rate_clk <= 1'b0;
	end
	else 
	if(en)
	begin
		if(igual)
		begin
			contador<={DW{1'b0}};
			baud_rate_clk <= ~baud_rate_clk;
		end
		else
		begin
			contador<=contador + 1'b1;
			baud_rate_clk <= baud_rate_clk;
		end
	end
	else
	begin
		contador <= contador;
		baud_rate_clk <= baud_rate_clk;
	end
end

endmodule