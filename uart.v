/*
	Top module UART full duplex
	Diseño realizado por: Luis Mena 
*/

module uart (
    input clk, rst, tx_send, rx, rx_flag_clr, // Added rx_flag_clr input
    input [7:0] Tx_Data,
    output tx_output_serial,
    output [7:0] Rx_Data,
    output parity_error, rx_flag
);

// Instantiate the UART Transmitter
UART_Tx TX_instance(
    .clk(clk), .nrst(rst), .tx_send(tx_send),
    .Tx_Data(Tx_Data),
    .tx_output_serial(tx_output_serial)
);

// Instantiate the UART Receiver
UART_Rx RX_instance(
    .clk(clk), .nrst(~nrst), .rx(rx), .rx_flag_clr(rx_flag_clr), // Added rx_flag_clr connection
    .Rx_Data(Rx_Data),
    .parity_error(parity_error),
    .rx_flag(rx_flag)
);

endmodule