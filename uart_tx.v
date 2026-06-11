// UART Transmitter Module
module uart_tx (
    input clk, rst, start,
    input [7:0] data,
    output reg tx,
    output reg busy
);
reg [3:0] bit_index;
reg [9:0] frame;
localparam IDLE = 2'b00, SEND = 2'b10;
reg [1:0] state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        tx <= 1; busy <= 0;
        bit_index <= 0; state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                tx <= 1; busy <= 0;
                if (start) begin
                    frame <= {1'b1, data, 1'b0};
                    state <= SEND; busy <= 1;
                    bit_index <= 0;
                end
            end
            SEND: begin
                tx <= frame[bit_index];
                bit_index <= bit_index + 1;
                if (bit_index == 9) state <= IDLE;
            end
        endcase
    end
end
endmodule
