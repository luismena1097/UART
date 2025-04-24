/*
	Revision de paridad
	Diseño realizado por: Luis Mena & David Monteon
	Practica 2
*/
module parity (
input [7:0] Tx_Data,
output parity
);

assign parity = ^Tx_Data;

endmodule