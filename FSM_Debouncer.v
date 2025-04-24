`timescale 1ns / 1ps
// Company: ITESO
// Engineer: Cuauhtemoc Aguilera
//////////////////////////////////////////////////////////////////////////////////
module FSM_Debouncer(
    input clk,
    input rst,
    input sw,
	 input fin_delay,
	 output reg rst_out,
    output reg one_shot
    );
// Definition of State codes. 
parameter [2:0] ini  = 'b000;
parameter [2:0] shot = 'b001;
parameter [2:0] off1 = 'b011;
parameter [2:0] sw_1 = 'b010;
parameter [2:0] off2 = 'b110;

reg [2:0]estado;
//asynchronous reset asserted at high-level.
always @(posedge rst, posedge clk)
    begin
        if(rst)
            estado <= ini;
        else
            case(estado)
                ini: if (sw)
                        estado <= shot;
                shot: estado <= off1;
                off1: if(fin_delay)
                        estado <= sw_1;
                sw_1: if(~sw)
                        estado <= off2;
                off2: if(fin_delay)
                        estado <=ini;
                default: estado <=ini;
            endcase
    end
always @ (estado)
    begin
        case(estado)
                 ini: begin one_shot = 'b0; rst_out = 1'b1; end
                shot: begin one_shot = 'b1; rst_out = 1'b1; end
                off1: begin one_shot = 'b0; rst_out = 1'b0; end
                sw_1: begin one_shot = 'b0; rst_out = 1'b1; end
                off2: begin one_shot = 'b0; rst_out = 1'b0; end
             default: begin one_shot = 'b0; rst_out = 1'b1; end
        endcase
    end
endmodule
