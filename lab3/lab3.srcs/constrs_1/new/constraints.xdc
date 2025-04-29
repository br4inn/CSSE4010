    ## Clock signal    
    set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK]
    create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK]
    
    ## Reset signal (Button BTNC)
    set_property PACKAGE_PIN E16 [get_ports RESET]
    set_property IOSTANDARD LVCMOS33 [get_ports RESET]
    
    ## Button 1 (mapped to V10)
    set_property PACKAGE_PIN V10 [get_ports BUTTON]
    set_property IOSTANDARD LVCMOS33 [get_ports BUTTON]
    
    ### Button 2 (mapped to T16)
#    set_property PACKAGE_PIN T16 [get_ports {BUTTON[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[1]}]
    
#    set_property PACKAGE_PIN T16 [get_ports BUTTON]
#    set_property IOSTANDARD LVCMOS33 [get_ports BUTTON]
    
    ### Button 3 (mapped to F15)
    #set_property PACKAGE_PIN F15 [get_ports {BUTTON[2]}]
    #set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[2]}]
    
    ### Button 4 (mapped to R10)
    #set_property PACKAGE_PIN R10 [get_ports {BUTTON[3]}]
    #set_property IOSTANDARD LVCMOS33 [get_ports {BUTTON[3]}]
    
     
     ## Switches
    #Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
    set_property PACKAGE_PIN U9 [get_ports {sw[0]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
    #Bank = 34, Pin name = IO_25_34,							Sch name = SW1
    set_property PACKAGE_PIN U8 [get_ports {sw[1]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
    #Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
    set_property PACKAGE_PIN R7 [get_ports {sw[2]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
    #Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = SW3
    set_property PACKAGE_PIN R6 [get_ports {sw[3]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
    #Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = SW4
    set_property PACKAGE_PIN R5 [get_ports {sw[4]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
    #Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = SW5
    set_property PACKAGE_PIN V7 [get_ports {sw[5]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
    #Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = SW6
    set_property PACKAGE_PIN V6 [get_ports {sw[6]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
    #Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = SW7
    set_property PACKAGE_PIN V5 [get_ports {sw[7]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
    #Bank = 34, Pin name = IO_L8P_T1-34,						Sch name = SW8
    set_property PACKAGE_PIN U4 [get_ports {sw[8]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
    #Bank = 34, Pin name = IO_L9N_T1_DQS_34,					Sch name = SW9
    set_property PACKAGE_PIN V2 [get_ports {sw[9]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
    #Bank = 34, Pin name = IO_L9P_T1_DQS_34,					Sch name = SW10
    set_property PACKAGE_PIN U2 [get_ports {sw[10]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
    #Bank = 34, Pin name = IO_L11N_T1_MRCC_34,					Sch name = SW11
    set_property PACKAGE_PIN T3 [get_ports {sw[11]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
    #Bank = 34, Pin name = IO_L17N_T2_34,						Sch name = SW12
    set_property PACKAGE_PIN T1 [get_ports {sw[12]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
    #Bank = 34, Pin name = IO_L11P_T1_SRCC_34,					Sch name = SW13
    set_property PACKAGE_PIN R3 [get_ports {sw[13]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
    #Bank = 34, Pin name = IO_L14N_T2_SRCC_34,					Sch name = SW14
    set_property PACKAGE_PIN P3 [get_ports {sw[14]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
    #Bank = 34, Pin name = IO_L14P_T2_SRCC_34,					Sch name = SW15
    set_property PACKAGE_PIN P4 [get_ports {sw[15]}]					
        set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
     
     
    ## LED LD16 (controlled by buttons)
    set_property PACKAGE_PIN T8 [get_ports LED16]
    set_property IOSTANDARD LVCMOS33 [get_ports LED16]
    
    # LED LD1 (controlled by switches)
    set_property PACKAGE_PIN V9 [get_ports LED1]
    set_property IOSTANDARD LVCMOS33 [get_ports LED1]
    
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
    # set_property PACKAGE_PIN N6 [get_ports {an[0]}]
    set_property PACKAGE_PIN N2 [get_ports {cn[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {cn[0]}]
    
    ## set_property PACKAGE_PIN M6 [get_ports {an[1]}]
    set_property PACKAGE_PIN N4 [get_ports {cn[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {cn[1]}]
    
    ## set_property PACKAGE_PIN M3 [get_ports {an[2]}]
    set_property PACKAGE_PIN L1 [get_ports {cn[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {cn[2]}]
    
    ## set_property PACKAGE_PIN N5 [get_ports {an[3]}]
    set_property PACKAGE_PIN M1 [get_ports {cn[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {cn[3]}]
    
    
    
    ## Anode control for 7-segment display
    set_property PACKAGE_PIN N6 [get_ports {an[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
    
    ## set_property PACKAGE_PIN M6 [get_ports {an[1]}]
    set_property PACKAGE_PIN M6 [get_ports {an[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
    
    ## set_property PACKAGE_PIN M3 [get_ports {an[2]}]
    set_property PACKAGE_PIN M3 [get_ports {an[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
    
    ## set_property PACKAGE_PIN N5 [get_ports {an[3]}]
    set_property PACKAGE_PIN N5 [get_ports {an[3]}]
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
    
    #set pin for carry_out
     
    set_property PACKAGE_PIN J15 [get_ports {carry_out}]
    set_property IOSTANDARD LVCMOS33 [get_ports {carry_out}]
    
    #set_property PACKAGE_PIN T14 [get_ports sub]					
    #	set_property IOSTANDARD LVCMOS33 [get_ports sub]