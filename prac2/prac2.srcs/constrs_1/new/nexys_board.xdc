## Clock signal
#set_property PACKAGE_PIN E3 [get_ports CLK]
#set_property IOSTANDARD LVCMOS33 [get_ports CLK]
 
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK]

## Reset signal (Button BTNC)
set_property PACKAGE_PIN E16 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]

## Button 1 (mapped to V10)
set_property PACKAGE_PIN V10 [get_ports {BUTTON[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[0]}]

## Button 2 (mapped to T16)
set_property PACKAGE_PIN T16 [get_ports {BUTTON[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[1]}]

## Button 3 (mapped to F15)
set_property PACKAGE_PIN F15 [get_ports {BUTTON[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[2]}]

## Button 4 (mapped to R10)
set_property PACKAGE_PIN R10 [get_ports {BUTTON[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[3]}]

## Switch 0 (mapped to U9)
set_property PACKAGE_PIN U9 [get_ports {SW[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]

## Switch 1 (mapped to U8)
set_property PACKAGE_PIN U8 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]

## Switch 2 (mapped to R7)
set_property PACKAGE_PIN R7 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]

## Switch 3 (mapped to R6)
set_property PACKAGE_PIN R6 [get_ports {SW[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[3]}]

## Switch 14 (mapped to P3)
#set_property PACKAGE_PIN P3 [get_ports {SW[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[14]}]

### Switch 15 (mapped to P4)
#set_property PACKAGE_PIN P4 [get_ports {SW[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[15]}]

## LED LD16 (controlled by buttons)
set_property PACKAGE_PIN T8 [get_ports LED16]
set_property IOSTANDARD LVCMOS33 [get_ports LED16]

## LED LD1 (controlled by switches)
#set_property PACKAGE_PIN V9 [get_ports LED1]
#set_property IOSTANDARD LVCMOS33 [get_ports LED1]

## LED LD15 unlock
set_property PACKAGE_PIN P2 [get_ports MATCH]
set_property IOSTANDARD LVCMOS33 [get_ports MATCH]

## LED LD14 lock
set_property PACKAGE_PIN R2 [get_ports LOCK_LED]
set_property IOSTANDARD LVCMOS33 [get_ports LOCK_LED]

### LED LD13 (controlled by Reg2)
#set_property PACKAGE_PIN U1 [get_ports LED13]
#set_property IOSTANDARD LVCMOS33 [get_ports LED13]

### LED LD12 (controlled by Reg3)
#set_property PACKAGE_PIN P5 [get_ports LED12]
#set_property IOSTANDARD LVCMOS33 [get_ports LED12]

## 7-Segment Display
# Segment A
set_property PACKAGE_PIN L3 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

# Segment B
set_property PACKAGE_PIN N1 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

# Segment C
set_property PACKAGE_PIN L5 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

# Segment D
set_property PACKAGE_PIN L4 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

# Segment E
set_property PACKAGE_PIN K3 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

# Segment F
set_property PACKAGE_PIN M2 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

# Segment G
set_property PACKAGE_PIN L6 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

# Decimal Point (DP)
set_property PACKAGE_PIN M4 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]

## Anode control for 7-segment display
## set_property PACKAGE_PIN N6 [get_ports {an[0]}]
set_property PACKAGE_PIN N2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

## set_property PACKAGE_PIN M6 [get_ports {an[1]}]
set_property PACKAGE_PIN N4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]

## set_property PACKAGE_PIN M3 [get_ports {an[2]}]
set_property PACKAGE_PIN L1 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]

## set_property PACKAGE_PIN N5 [get_ports {an[3]}]
set_property PACKAGE_PIN M1 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

## MUX Output (MUX_OUT)
# Set a specific I/O pin and I/O standard for the MUX output
set_property PACKAGE_PIN T15 [get_ports {MUX_OUT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MUX_OUT[0]}]

set_property PACKAGE_PIN T13 [get_ports {MUX_OUT[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MUX_OUT[1]}]

set_property PACKAGE_PIN L18 [get_ports {MUX_OUT[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MUX_OUT[2]}]

set_property PACKAGE_PIN J14 [get_ports {MUX_OUT[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MUX_OUT[3]}]


