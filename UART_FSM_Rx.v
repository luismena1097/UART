/*
	UART TX
	Diseño realizado por: Luis Mena
	Practica 2
*/
module UART_FSM_Rx (
input clk, nrst, rx, baud_rate_enable_out, count_bits, enable_tk_pkg_done, rx_flag_clr, 
output reg enable_baud_rate_counter, rx_flag, sipo_en
);

localparam IDLE   = 3'b000;		//0
localparam START  = 3'b001;		//1
localparam DATA   = 3'b011;		//3
localparam PARITY = 3'b010;		//2
localparam STOP   = 3'b110;		//6
localparam CLEAR	= 3'b111;		//7

reg [2:0] estado;

always @(posedge clk or posedge nrst)
begin
	if(nrst)
		estado <= IDLE;
	else
	case(estado) 
		IDLE:
		begin		
			if(rx == 1'b0)
				estado <= START;
			else
				estado <= estado;
		end
		START:
		begin
			if(baud_rate_enable_out)
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
			if(baud_rate_enable_out)
				estado <= STOP;
			else
				estado <= estado;
		end
		STOP:
		begin
			if(enable_tk_pkg_done)
				estado <= CLEAR;
			else
				estado <= estado;
		end
		CLEAR:
		begin
			if(rx_flag_clr)
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
		enable_baud_rate_counter 	= 1'b0;
		rx_flag							= 1'b0;
		sipo_en							= 1'b0;
	end
	START:
	begin
		enable_baud_rate_counter 	= 1'b1;
		rx_flag							= 1'b0;
		sipo_en							= 1'b0;	
	end
	DATA:
	begin
		enable_baud_rate_counter 	= 1'b1;
		rx_flag							= 1'b0;
		sipo_en							= 1'b1;		
	end
	PARITY:
	begin
		enable_baud_rate_counter 	= 1'b1;
		rx_flag							= 1'b0;	
		sipo_en							= 1'b1;
	end
	STOP:
	begin
		enable_baud_rate_counter 	= 1'b1;
		rx_flag							= 1'b1;
		sipo_en							= 1'b0;	
	end
	CLEAR:
	begin
		enable_baud_rate_counter 	= 1'b0;
		rx_flag							= 1'b1;
		sipo_en							= 1'b0;	
	end
	default:
	begin
		enable_baud_rate_counter 	= 1'b0;
		rx_flag							= 1'b0;
		sipo_en							= 1'b0;
	end
endcase
end


endmodule