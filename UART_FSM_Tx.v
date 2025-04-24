/*
	UART TX
	Diseño realizado por: Luis Mena
	Practica 2
*/
module UART_FSM_Tx (
input clk, nrst, tx_send, count_bits, baud_rate_en, enable_tk_pkg_done,
output reg load_data_2_PISO, enable_baud_rate,
output reg [1:0] Selector_datos
);

// Definicion de los estados posibles
localparam IDLE   = 3'b000;
localparam START  = 3'b001;
localparam DATA   = 3'b011;
localparam PARITY = 3'b010;
localparam STOP   = 3'b110;

reg [2:0] estado;

always @(posedge clk or posedge nrst)
begin
	if(nrst)
		estado <= IDLE;
	else
	case(estado) 
		IDLE:
		begin		
			if(tx_send)
				estado <= START;
			else
				estado <= estado;
		end
		START:
		begin
			if(baud_rate_en)
				estado <= DATA;
			else
				estado <= estado;
		end
		DATA:
		begin
			if(count_bits)
				estado <= PARITY;
			else
				estado <= estado;
		end
		PARITY:
		begin
			if(baud_rate_en)
				estado <= STOP;
			else
				estado <= estado;
		end
		STOP:
		begin
			if(enable_tk_pkg_done)
				estado <= IDLE;
			else
				estado <= estado;
		end
		default:
			estado <= IDLE;
	endcase
end

always @(estado)
begin
case(estado)
	IDLE:
	begin
		Selector_datos 	= 2'b00;	//Mux 4 a 1 donde 00 será un 1'b1 para mantener en alto la transmisión
		load_data_2_PISO 	= 1'b1;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b0;		//Baud rate solo se habilita al comenzar la transmisión		
	end
	START:
	begin
		Selector_datos 	= 2'b01;	//Mux 4 a 1 donde 01 será un 1'b0 para indicar el comienzo de la transmisión
		load_data_2_PISO 	= 1'b0;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b1;		//Baud rate solo se habilita al comenzar la transmisión		
	end
	DATA:
	begin
		Selector_datos 	= 2'b11;	//Mux 4 a 1 donde 11 será la salida serial del registro PISO enviar los datos
		load_data_2_PISO 	= 1'b0;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b1;		//Baud rate solo se habilita al comenzar la transmisión	
	end
	PARITY:
	begin
		Selector_datos 	= 2'b10;	//Mux 4 a 1 donde 10 se tendrá el bit de paridad
		load_data_2_PISO 	= 1'b0;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b1;		//Baud rate solo se habilita al comenzar la transmisión	
	end
	STOP:
		begin
		Selector_datos 	= 2'b00;	//Mux 4 a 1 donde 00 será un 1'b1 para mantener en alto la transmisión
		load_data_2_PISO 	= 1'b0;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b1;		//Baud rate solo se habilita al comenzar la transmisión
	end
	default:
	begin
		Selector_datos 	= 2'b00;	//Mux 4 a 1 donde 00 será un 1'b1 para mantener en alto la transmisión
		load_data_2_PISO 	= 1'b1;		//Habilitar la carga de datos solo en IDLE ya que si despues cambia habrá un error en la TX
		enable_baud_rate	= 1'b0;		//Baud rate solo se habilita al comenzar la transmisión	
	end
endcase
end


endmodule