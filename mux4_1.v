module mux4_1 #(parameter WIDTH=32)(
    input  [WIDTH-1:0] Data0,      // Entrada 0
    input  [WIDTH-1:0] Data1,      // Entrada 1
    input  [WIDTH-1:0] Data2,      // Entrada 2
    input  [WIDTH-1:0] Data3,      // Entrada 3
	 input  [1:0]  sel,      // Selección: 00, 01, 10, 11
    output reg[WIDTH-1:0] Data_o       // Salida
);

always@(*) begin
case (sel)
	2'b00:  Data_o = Data0;
	2'b01:  Data_o = Data1;
	2'b10:  Data_o = Data2;
	2'b11:  Data_o = Data3;
	default: Data_o = Data0; // Valor por defecto para depuración
endcase
end

endmodule
