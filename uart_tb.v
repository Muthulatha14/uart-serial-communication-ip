// UART Testbench - Sends 'H', 'I', '!'
module uart_top (
    input clk, rst, start,
    input [7:0] tx_data,
    output [7:0] rx_data,
    output valid, busy
);
    wire serial_line;
    uart_tx TX (.clk(clk),.rst(rst),.start(start),
                .data(tx_data),.tx(serial_line),.busy(busy));
    uart_rx RX (.clk(clk),.rst(rst),
                .rx(serial_line),.data(rx_data),.valid(valid));
endmodule

module tb_uart_multi;
reg clk, rst, start;
reg [7:0] tx_data;
wire [7:0] rx_data;
wire valid, busy;

uart_top uut (
    .clk(clk),.rst(rst),.start(start),
    .tx_data(tx_data),.rx_data(rx_data),
    .valid(valid),.busy(busy)
);

always #5 clk = ~clk;

always @(posedge clk) begin
    if (valid)
        $display(">> Received: %b (%0d) = '%c'", rx_data, rx_data, rx_data);
end

initial begin
    clk=0; rst=1; start=0; tx_data=0;
    #10 rst=0;
    tx_data=8'h48; start=1; #10 start=0;
    wait(!busy); #20;
    tx_data=8'h49; start=1; #10 start=0;
    wait(!busy); #20;
    tx_data=8'h21; start=1; #10 start=0;
    wait(!busy); #20;
    #100;
    $display("--- Transmission Complete ---");
    $finish;
end
endmodule
