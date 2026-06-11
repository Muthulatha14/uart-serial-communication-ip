// UART Receiver Module
module uart_rx (
    input clk, rst, rx,
    output reg [7:0] data,
    output reg valid
);
reg [3:0] bit_index;
reg [7:0] shift_reg;
localparam IDLE = 2'b00, RECV = 2'b01, DONE = 2'b10;
reg [1:0] state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data <= 0; valid <= 0;
        bit_index <= 0; shift_reg <= 0;
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                valid <= 0;
                if (rx == 0) begin
                    bit_index <= 0; state <= RECV;
                end
            end
            RECV: begin
                shift_reg[bit_index] <= rx;
                bit_index <= bit_index + 1;
                if (bit_index == 7) state <= DONE;
            end
            DONE: begin
                data <= shift_reg;
                valid <= 1; state <= IDLE;
            end
        endcase
    end
end
endmodule
