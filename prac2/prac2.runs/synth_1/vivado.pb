
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2$
create_project: 2default:default2
00:00:042default:default2
00:00:052default:default2
394.0782default:default2
72.4532default:defaultZ17-268h px� 
�
Command: %s
1870*	planAhead2�
qread_checkpoint -auto_incremental -incremental C:/Users/brain/prac2/prac2.srcs/utils_1/imports/synth_1/system.dcp2default:defaultZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2V
BC:/Users/brain/prac2/prac2.srcs/utils_1/imports/synth_1/system.dcp2default:defaultZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
w
Command: %s
53*	vivadotcl2F
2synth_design -top top_level -part xc7a100tcsg324-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-349h px� 
W
Loading part %s157*device2$
xc7a100tcsg324-12default:defaultZ21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
�
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
`
#Helper process launched with PID %s4824*oasys2
241402default:defaultZ8-7075h px� 
�
5undeclared symbol '%s', assumed default net type '%s'7502*oasys2
REGCCE2default:default2
wire2default:default2[
EC:/Xilinx/Vivado/2022.2/data/verilog/src/unimacro/BRAM_SINGLE_MACRO.v2default:default2
21702default:default8@Z8-11241h px� 
�
%s*synth2�
yStarting RTL Elaboration : Time (s): cpu = 00:00:06 ; elapsed = 00:00:07 . Memory (MB): peak = 1223.898 ; gain = 408.992
2default:defaulth px� 
�
&overwriting existing primary unit '%s'6129*oasys2
demux2default:default2U
?C:/Users/brain/prac2/prac2.srcs/sources_1/new/reset_decoder.vhd2default:default2
252default:default8@Z8-9871h px� 
�
0formal port/generic <%s> is not declared in <%s>2043*oasys2

decoder_in2default:default2
demux2default:default2Q
;C:/Users/brain/prac2/prac2.srcs/sources_1/new/top_level.vhd2default:default2
782default:default8@Z8-2043h px� 
�
+unit '%s' is ignored due to previous errors7513*oasys2
behavioural2default:default2Q
;C:/Users/brain/prac2/prac2.srcs/sources_1/new/top_level.vhd2default:default2
1482default:default8@Z8-11252h px� 
�
'VHDL file '%s' is ignored due to errors6704*oasys2O
;C:/Users/brain/prac2/prac2.srcs/sources_1/new/top_level.vhd2default:defaultZ8-10443h px� 
�
%s*synth2�
yFinished RTL Elaboration : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 1306.824 ; gain = 491.918
2default:defaulth px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
132default:default2
02default:default2
12default:default2
22default:defaultZ4-41h px� 
N

%s failed
30*	vivadotcl2 
synth_design2default:defaultZ4-43h px� 
�
Command failed: %s
69*common2Y
ESynthesis failed - please see the console or run log file for details2default:defaultZ17-69h px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Sun Oct 20 17:39:50 20242default:defaultZ17-206h px� 


End Record