# UART Serial Communication IP Core

A Universal Asynchronous Receiver Transmitter (UART) IP core designed in Verilog HDL for use in SoCs and embedded systems.

## Project Info
- **Tech:** Verilog HDL  
- **Simulator:** JDoodle (Icarus Verilog)  
- **Difficulty:** Intermediate  

## Modules
| File | Description |
|------|-------------|
| uart_tx.v | UART Transmitter (FSM-based) |
| uart_rx.v | UART Receiver (FSM-based) |
| uart_tb.v | Testbench - sends 'H', 'I', '!' |

## How UART Works
- Data sent serially: START bit + 8 data bits + STOP bit
- TX converts parallel data to serial
- RX reconstructs serial bits back to parallel

## FSM States
- **TX:** IDLE → SEND → IDLE  
- **RX:** IDLE → RECV → DONE → IDLE

## Simulation Results

```
>> Received: 01001000 (72) = 'H'
>> Received: 01001001 (73) = 'I'
>> Received: 00100001 (33) = '!'
--- Transmission Complete ---
```

## Learning Outcomes
- UART protocol understanding
- FSM-based RTL design in Verilog
- Timing analysis through simulation
