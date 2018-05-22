# File saved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new main_pwm work:main_pwm:NOFILE -nosplit
load symbol binary_bcd work:binary_bcd:NOFILE HIERBOX pin clk input.left pin reset input.left pinBus bcd output.right [19:0] pinBus bcd0 output.right [3:0] pinBus bcd1 output.right [3:0] pinBus bcd2 output.right [3:0] pinBus bcd3 output.right [3:0] pinBus bcd4 output.right [3:0] pinBus binary_in input.left [15:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Finite_State_Machine work:abstract:NOFILE HIERBOX pin But input.left pin CLK input.left pin RESET input.left pinBus State output.right [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_MUX31 work MUX pin I0 input.left pin I1 input.left pin I2 input.left pin I3 input.left pin O output.right pinBus S input.bot [1:0] fillcolor 1
load symbol RTL_REG__BREG_19 work GEN pin C input.clk.left pin D input.left pin Q output.right fillcolor 1
load symbol clock_divider__parameterized3 work:clock_divider__parameterized3:NOFILE HIERBOX pin enable input.left pin in_clock input.left pin out_clock output.right boxcolor 1 fillcolor 2 minwidth 13%
load symbol clock_divider__parameterized1 work:clock_divider__parameterized1:NOFILE HIERBOX pin enable input.left pin in_clock input.left pin out_clock output.right boxcolor 1 fillcolor 2 minwidth 13%
load symbol clock_divider work:clock_divider:NOFILE HIERBOX pin enable input.left pin in_clock input.left pin out_clock output.right boxcolor 1 fillcolor 2 minwidth 13%
load symbol PWM_generator work:PWM_generator:NOFILE HIERBOX pin BTNC input.left pin BTNU input.left pin LED17_B output.right pin RESET input.left pin clk input.left pin clk1000hz input.left pin count_zero output.right pin output output.right pin toggle_output output.right pinBus LED output.right [15:0] pinBus SW input.left [15:0] pinBus count_out output.right [15:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol debounce work:abstract:NOFILE HIERBOX pin but input.left pin but_debounce output.right pin clk input.left pin reset input.left boxcolor 1 fillcolor 2 minwidth 13%
load symbol debounce work:debounce:NOFILE HIERBOX pin but input.left pin but_debounce output.right pin clk input.left pin reset input.left boxcolor 1 fillcolor 2 minwidth 13%
load symbol Finite_State_Machine work:Finite_State_Machine:NOFILE HIERBOX pin But input.left pin CLK input.left pin RESET input.left pinBus State output.right [1:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol multiplex_seven_seg work:multiplex_seven_seg:NOFILE HIERBOX pin CA output.right pin CB output.right pin CC output.right pin CD output.right pin CE output.right pin CF output.right pin CG output.right pin clk input.left pinBus AN output.right [7:0] pinBus bcd input.left [19:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol RTL_AND0 work AND pin I0 input pin I1 input pin O output fillcolor 1
load symbol RTL_EQ0 work RTL(=) pin I0 input.left pin I1 input.left pin O output.right fillcolor 1
load symbol RTL_MUX28 work MUX pin I0 input.left pin I1 input.left pin I2 input.left pin O output.right pinBus S input.bot [1:0] fillcolor 1
load symbol RTL_MUX12 work MUX pin I0 input.left pin I1 input.left pin O output.right pin S input.bot fillcolor 1
load symbol RTL_LATCH work GEN pin D input.left pin G input.left pin Q output.right fillcolor 1
load port CF output -pg 1 -y 340
load port LED17_B output -pg 1 -y 420
load port CG output -pg 1 -y 360
load port LED16_R output -pg 1 -y 80
load port BTNU input -pg 1 -y 360
load port LED16_G output -pg 1 -y 1120
load port LED17_R output -pg 1 -y 600
load port BTNL input -pg 1 -y 670
load port CLK100MHZ input -pg 1 -y 720
load port CA output -pg 1 -y 240
load port CB output -pg 1 -y 260
load port BTNC input -pg 1 -y 300
load port CC output -pg 1 -y 280
load port BTND input -pg 1 -y 570
load port CD output -pg 1 -y 300
load port LED16_B output -pg 1 -y 970
load port BTNR input -pg 1 -y 740
load port CE output -pg 1 -y 320
load portBus AN output [7:0] -attr @name AN[7:0] -pg 1 -y 220
load portBus LED output [15:0] -attr @name LED[15:0] -pg 1 -y 400
load portBus JA output [2:1] -attr @name JA[2:1] -pg 1 -y 580
load portBus SW input [15:0] -attr @name SW[15:0] -pg 1 -y 460
load inst Debounce_BTND debounce work:abstract:NOFILE -autohide -attr @cell(#000000) debounce -pg 1 -lvl 3 -y 540
load inst RESET_reg RTL_REG__BREG_19 work -attr @cell(#000000) RTL_REG -pg 1 -lvl 1 -y 720
load inst CLK_FSM Finite_State_Machine work:abstract:NOFILE -autohide -attr @cell(#000000) Finite_State_Machine -pinBusAttr State @name State[1:0] -pg 1 -lvl 3 -y 680
load inst Clock100Hz clock_divider__parameterized1 work:clock_divider__parameterized1:NOFILE -autohide -attr @cell(#000000) clock_divider__parameterized1 -pg 1 -lvl 3 -y 960
load inst Binary_2_BCD binary_bcd work:binary_bcd:NOFILE -autohide -attr @cell(#000000) binary_bcd -pinBusAttr bcd @name bcd[19:0] -pinBusAttr bcd0 @name bcd0[3:0] -pinBusAttr bcd0 @attr n/c -pinBusAttr bcd1 @name bcd1[3:0] -pinBusAttr bcd1 @attr n/c -pinBusAttr bcd2 @name bcd2[3:0] -pinBusAttr bcd2 @attr n/c -pinBusAttr bcd3 @name bcd3[3:0] -pinBusAttr bcd3 @attr n/c -pinBusAttr bcd4 @name bcd4[3:0] -pinBusAttr bcd4 @attr n/c -pinBusAttr binary_in @name binary_in[15:0] -pg 1 -lvl 9 -y 290
load inst Clock5Hz clock_divider work:clock_divider:NOFILE -autohide -attr @cell(#000000) clock_divider -pg 1 -lvl 3 -y 840
load inst Debounce_BTNU debounce work:debounce:NOFILE -autohide -attr @cell(#000000) debounce -pg 1 -lvl 5 -y 340
load inst CLK_i RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 4 -y 880
load inst PWM_FSM Finite_State_Machine work:Finite_State_Machine:NOFILE -autohide -attr @cell(#000000) Finite_State_Machine -pinBusAttr State @name State[1:0] -pg 1 -lvl 4 -y 580
load inst output_tmp_reg RTL_LATCH work -attr @cell(#000000) RTL_LATCH -pg 1 -lvl 6 -y 720
load inst LED16_G_i RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 10 -y 1120
load inst output_tmp1_i RTL_AND0 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 8 -y 750
load inst output_tmp_i RTL_MUX28 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 5 -y 540
load inst Debounce_BTNL debounce work:abstract:NOFILE -autohide -attr @cell(#000000) debounce -pg 1 -lvl 2 -y 660
load inst LED16_R_i RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 10 -y 70
load inst output_tmp_i__0 RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 5 -y 730
load inst CLK_reg RTL_REG__BREG_19 work -attr @cell(#000000) RTL_REG -pg 1 -lvl 5 -y 900
load inst output_tmp_i__1 RTL_MUX12 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=1'b1 -pinAttr I1 @attr S=default -pg 1 -lvl 9 -y 700
load inst Counter16_PWM PWM_generator work:PWM_generator:NOFILE -autohide -attr @cell(#000000) PWM_generator -pinBusAttr LED @name LED[15:0] -pinBusAttr SW @name SW[15:0] -pinBusAttr count_out @name count_out[15:0] -pg 1 -lvl 6 -y 390
load inst LED16_B_i RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 10 -y 960
load inst LED17_R_i RTL_MUX31 work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=2'b00 -pinAttr I1 @attr S=2'b01 -pinAttr I2 @attr S=2'b10 -pinAttr I3 @attr S=2'b11 -pinBusAttr S @name S[1:0] -pg 1 -lvl 10 -y 580
load inst output_tmp2_i RTL_EQ0 work -attr @cell(#000000) RTL_EQ -pg 1 -lvl 7 -y 680
load inst Clock1000Hz clock_divider__parameterized3 work:clock_divider__parameterized3:NOFILE -autohide -attr @cell(#000000) clock_divider__parameterized3 -pg 1 -lvl 1 -y 830
load inst JA_reg[1] RTL_REG__BREG_19 work -attr @cell(#000000) RTL_REG -pg 1 -lvl 10 -y 830
load inst output_tmp2_i__0 RTL_EQ0 work -attr @cell(#000000) RTL_EQ -pg 1 -lvl 7 -y 760
load inst Seven_Seg multiplex_seven_seg work:multiplex_seven_seg:NOFILE -autohide -attr @cell(#000000) multiplex_seven_seg -pinBusAttr AN @name AN[7:0] -pinBusAttr bcd @name bcd[19:0] -pg 1 -lvl 10 -y 210
load net AN[1] -attr @rip AN[1] -port AN[1] -pin Seven_Seg AN[1]
load net CLK1000HZ -pin Binary_2_BCD clk -pin CLK_FSM CLK -pin CLK_i I2 -pin Clock1000Hz out_clock -pin Counter16_PWM clk1000hz -pin Debounce_BTND clk -pin Debounce_BTNL clk -pin Debounce_BTNU clk -pin PWM_FSM CLK -pin Seven_Seg clk
netloc CLK1000HZ 1 1 9 310 750 580 630 910 530 1190 470 1470 320 NJ 320 NJ 320 2200 380 2490
load net CA -port CA -pin Seven_Seg CA
netloc CA 1 10 1 NJ
load net bcd[17] -attr @rip bcd[17] -pin Binary_2_BCD bcd[17] -pin Seven_Seg bcd[17]
load net counter_out[1] -attr @rip count_out[1] -pin Binary_2_BCD binary_in[1] -pin Counter16_PWM count_out[1]
load net LED[12] -attr @rip LED[12] -pin Counter16_PWM LED[12] -port LED[12]
load net CB -port CB -pin Seven_Seg CB
netloc CB 1 10 1 NJ
load net bcd[7] -attr @rip bcd[7] -pin Binary_2_BCD bcd[7] -pin Seven_Seg bcd[7]
load net LED[3] -attr @rip LED[3] -pin Counter16_PWM LED[3] -port LED[3]
load net CC -port CC -pin Seven_Seg CC
netloc CC 1 10 1 NJ
load net bcd[14] -attr @rip bcd[14] -pin Binary_2_BCD bcd[14] -pin Seven_Seg bcd[14]
load net output -pin Counter16_PWM output -pin LED17_R_i I0
netloc output 1 6 4 1840 550 NJ 550 NJ 550 NJ
load net LED17_B -pin Counter16_PWM LED17_B -port LED17_B
netloc LED17_B 1 6 5 NJ 420 NJ 420 NJ 420 NJ 420 NJ
load net BTND_d -pin Debounce_BTND but_debounce -pin PWM_FSM But
netloc BTND_d 1 3 1 870
load net CD -port CD -pin Seven_Seg CD
netloc CD 1 10 1 NJ
load net CE -port CE -pin Seven_Seg CE
netloc CE 1 10 1 NJ
load net bcd[11] -attr @rip bcd[11] -pin Binary_2_BCD bcd[11] -pin Seven_Seg bcd[11]
load net counter_out[13] -attr @rip count_out[13] -pin Binary_2_BCD binary_in[13] -pin Counter16_PWM count_out[13]
load net output_tmp_i__0_n_0 -pin output_tmp_i__0 O -pin output_tmp_reg G
netloc output_tmp_i__0_n_0 1 5 1 NJ
load net CF -port CF -pin Seven_Seg CF
netloc CF 1 10 1 NJ
load net SW[1] -attr @rip SW[1] -pin Counter16_PWM SW[1] -port SW[1]
load net RESET -pin Binary_2_BCD reset -pin Counter16_PWM RESET -pin Debounce_BTND reset -pin Debounce_BTNL reset -pin Debounce_BTNU reset -pin RESET_reg Q
netloc RESET 1 1 8 290 610 540 490 NJ 510 1210 430 1510 340 NJ 340 NJ 340 NJ
load net CG -port CG -pin Seven_Seg CG
netloc CG 1 10 1 NJ
load net AN[2] -attr @rip AN[2] -port AN[2] -pin Seven_Seg AN[2]
load net CLK0_out -pin CLK_i O -pin CLK_reg D
netloc CLK0_out 1 4 1 1150
load net SW[8] -attr @rip SW[8] -pin Counter16_PWM SW[8] -port SW[8]
load net bcd[8] -attr @rip bcd[8] -pin Binary_2_BCD bcd[8] -pin Seven_Seg bcd[8]
load net counter_out[10] -attr @rip count_out[10] -pin Binary_2_BCD binary_in[10] -pin Counter16_PWM count_out[10]
load net counter_out[2] -attr @rip count_out[2] -pin Binary_2_BCD binary_in[2] -pin Counter16_PWM count_out[2]
load net output_tmp -pin output_tmp2_i__0 I0 -pin output_tmp_reg Q
netloc output_tmp 1 6 1 1800
load net output_tmp2_i__0_n_0 -pin output_tmp1_i I1 -pin output_tmp2_i__0 O
netloc output_tmp2_i__0_n_0 1 7 1 NJ
load net BTNU_d -pin Counter16_PWM BTNU -pin Debounce_BTNU but_debounce
netloc BTNU_d 1 5 1 1530
load net LED[15] -attr @rip LED[15] -pin Counter16_PWM LED[15] -port LED[15]
load net counter_out[9] -attr @rip count_out[9] -pin Binary_2_BCD binary_in[9] -pin Counter16_PWM count_out[9]
load net LED16_R -port LED16_R -pin LED16_R_i O
netloc LED16_R 1 10 1 NJ
load net SW[12] -attr @rip SW[12] -pin Counter16_PWM SW[12] -port SW[12]
load net bcd[5] -attr @rip bcd[5] -pin Binary_2_BCD bcd[5] -pin Seven_Seg bcd[5]
load net LED[6] -attr @rip LED[6] -pin Counter16_PWM LED[6] -port LED[6]
load net <const1> -power -pin Clock1000Hz enable -pin Clock100Hz enable -pin Clock5Hz enable -pin LED16_B_i I1 -pin LED16_B_i I3 -pin LED16_G_i I2 -pin LED16_G_i I3 -pin LED16_R_i I0 -pin LED16_R_i I3 -pin output_tmp_i__0 I0 -pin output_tmp_i__0 I1 -pin output_tmp_i__0 I3 -pin output_tmp_i__1 I1
load net BTNL_d -pin CLK_FSM But -pin Debounce_BTNL but_debounce
netloc BTNL_d 1 2 1 N
load net SW[9] -attr @rip SW[9] -pin Counter16_PWM SW[9] -port SW[9]
load net JA[2] -attr @rip 2 -port JA[2] -port LED17_R -pin LED17_R_i O
load net LED[14] -attr @rip LED[14] -pin Counter16_PWM LED[14] -port LED[14]
load net bcd[19] -attr @rip bcd[19] -pin Binary_2_BCD bcd[19] -pin Seven_Seg bcd[19]
load net counter_out[11] -attr @rip count_out[11] -pin Binary_2_BCD binary_in[11] -pin Counter16_PWM count_out[11]
load net SW[6] -attr @rip SW[6] -pin Counter16_PWM SW[6] -port SW[6]
load net CLK_state[1] -attr @rip State[1] -pin CLK_FSM State[1] -pin CLK_i S[1]
load net LED[5] -attr @rip LED[5] -pin Counter16_PWM LED[5] -port LED[5]
load net LED[0] -attr @rip LED[0] -pin Counter16_PWM LED[0] -port LED[0]
load net AN[0] -attr @rip AN[0] -port AN[0] -pin Seven_Seg AN[0]
load net bcd[16] -attr @rip bcd[16] -pin Binary_2_BCD bcd[16] -pin Seven_Seg bcd[16]
load net counter_out[0] -attr @rip count_out[0] -pin Binary_2_BCD binary_in[0] -pin Counter16_PWM count_out[0]
load net output_tmp0_out -pin output_tmp_i O -pin output_tmp_reg D
netloc output_tmp0_out 1 5 1 1490
load net SW[11] -attr @rip SW[11] -pin Counter16_PWM SW[11] -port SW[11]
load net bcd[6] -attr @rip bcd[6] -pin Binary_2_BCD bcd[6] -pin Seven_Seg bcd[6]
load net bcd[13] -attr @rip bcd[13] -pin Binary_2_BCD bcd[13] -pin Seven_Seg bcd[13]
load net bcd[3] -attr @rip bcd[3] -pin Binary_2_BCD bcd[3] -pin Seven_Seg bcd[3]
load net counter_out[7] -attr @rip count_out[7] -pin Binary_2_BCD binary_in[7] -pin Counter16_PWM count_out[7]
load net bcd[10] -attr @rip bcd[10] -pin Binary_2_BCD bcd[10] -pin Seven_Seg bcd[10]
load net SW[7] -attr @rip SW[7] -pin Counter16_PWM SW[7] -port SW[7]
load net SW[14] -attr @rip SW[14] -pin Counter16_PWM SW[14] -port SW[14]
load net BTNC -port BTNC -pin Counter16_PWM BTNC
netloc BTNC 1 0 6 NJ 300 NJ 300 NJ 300 NJ 300 NJ 290 NJ
load net SW[4] -attr @rip SW[4] -pin Counter16_PWM SW[4] -port SW[4]
load net LED[8] -attr @rip LED[8] -pin Counter16_PWM LED[8] -port LED[8]
load net CLK100MHZ -port CLK100MHZ -pin CLK_i I3 -pin CLK_reg C -pin Clock1000Hz in_clock -pin Clock100Hz in_clock -pin Clock5Hz in_clock -pin JA_reg[1] C -pin RESET_reg C
netloc CLK100MHZ 1 0 10 20 900 NJ 900 560 910 890 800 1170 840 NJ 830 NJ 830 NJ 830 NJ 830 NJ
load net BTND -port BTND -pin Debounce_BTND but
netloc BTND 1 0 3 NJ 570 NJ 570 NJ
load net counter_out[8] -attr @rip count_out[8] -pin Binary_2_BCD binary_in[8] -pin Counter16_PWM count_out[8]
load net AN[6] -attr @rip AN[6] -port AN[6] -pin Seven_Seg AN[6]
load net PWM_state[1] -attr @rip State[1] -pin LED16_B_i S[1] -pin LED16_G_i S[1] -pin LED16_R_i S[1] -pin LED17_R_i S[1] -pin PWM_FSM State[1] -pin output_tmp_i S[1] -pin output_tmp_i__0 S[1]
load net AN[5] -attr @rip AN[5] -port AN[5] -pin Seven_Seg AN[5]
load net bcd[4] -attr @rip bcd[4] -pin Binary_2_BCD bcd[4] -pin Seven_Seg bcd[4]
load net bcd[1] -attr @rip bcd[1] -pin Binary_2_BCD bcd[1] -pin Seven_Seg bcd[1]
load net counter_out[5] -attr @rip count_out[5] -pin Binary_2_BCD binary_in[5] -pin Counter16_PWM count_out[5]
load net SW[13] -attr @rip SW[13] -pin Counter16_PWM SW[13] -port SW[13]
load net CLK100HZ -pin CLK_i I1 -pin Clock100Hz out_clock
netloc CLK100HZ 1 3 1 850
load net LED[11] -attr @rip LED[11] -pin Counter16_PWM LED[11] -port LED[11]
load net LED[2] -attr @rip LED[2] -pin Counter16_PWM LED[2] -port LED[2]
load net LED[7] -attr @rip LED[7] -pin Counter16_PWM LED[7] -port LED[7]
load net bcd[18] -attr @rip bcd[18] -pin Binary_2_BCD bcd[18] -pin Seven_Seg bcd[18]
load net SW[5] -attr @rip SW[5] -pin Counter16_PWM SW[5] -port SW[5]
load net bcd[15] -attr @rip bcd[15] -pin Binary_2_BCD bcd[15] -pin Seven_Seg bcd[15]
load net output_tmp1 -pin LED17_R_i I3 -pin output_tmp1_i O -pin output_tmp_i__1 S
netloc output_tmp1 1 8 2 2200 N 2530
load net output_tmp_i__1_n_0 -pin LED17_R_i I1 -pin output_tmp_i I1 -pin output_tmp_i I2 -pin output_tmp_i__1 O
netloc output_tmp_i__1_n_0 1 4 6 1210 640 NJ 640 NJ 630 NJ 630 NJ 630 2470
load net toggle_output -pin Counter16_PWM toggle_output -pin LED17_R_i I2
netloc toggle_output 1 6 4 1800 590 NJ 590 NJ 590 NJ
load net LED[10] -attr @rip LED[10] -pin Counter16_PWM LED[10] -port LED[10]
load net count_zero -pin Counter16_PWM count_zero -pin output_tmp2_i I0
netloc count_zero 1 6 1 1820
load net output_tmp2 -pin output_tmp1_i I0 -pin output_tmp2_i O
netloc output_tmp2 1 7 1 NJ
load net BTNL -port BTNL -pin Debounce_BTNL but
netloc BTNL 1 0 2 NJ 660 NJ
load net PWM_state[0] -attr @rip State[0] -pin LED16_B_i S[0] -pin LED16_G_i S[0] -pin LED16_R_i S[0] -pin LED17_R_i S[0] -pin PWM_FSM State[0] -pin output_tmp_i S[0] -pin output_tmp_i__0 S[0]
load net LED[1] -attr @rip LED[1] -pin Counter16_PWM LED[1] -port LED[1]
load net bcd[12] -attr @rip bcd[12] -pin Binary_2_BCD bcd[12] -pin Seven_Seg bcd[12]
load net bcd[2] -attr @rip bcd[2] -pin Binary_2_BCD bcd[2] -pin Seven_Seg bcd[2]
load net counter_out[14] -attr @rip count_out[14] -pin Binary_2_BCD binary_in[14] -pin Counter16_PWM count_out[14]
load net SW[2] -attr @rip SW[2] -pin Counter16_PWM SW[2] -port SW[2]
load net counter_out[6] -attr @rip count_out[6] -pin Binary_2_BCD binary_in[6] -pin Counter16_PWM count_out[6]
load net AN[3] -attr @rip AN[3] -port AN[3] -pin Seven_Seg AN[3]
load net bcd[9] -attr @rip bcd[9] -pin Binary_2_BCD bcd[9] -pin Seven_Seg bcd[9]
load net counter_out[3] -attr @rip count_out[3] -pin Binary_2_BCD binary_in[3] -pin Counter16_PWM count_out[3]
load net out_clock -pin CLK_i I0 -pin Clock5Hz out_clock
netloc out_clock 1 3 1 N
load net LED16_B -port LED16_B -pin LED16_B_i O
netloc LED16_B 1 10 1 NJ
load net <const0> -ground -pin CLK_FSM RESET -pin LED16_B_i I0 -pin LED16_B_i I2 -pin LED16_G_i I0 -pin LED16_G_i I1 -pin LED16_R_i I1 -pin LED16_R_i I2 -pin PWM_FSM RESET -pin output_tmp2_i I1 -pin output_tmp2_i__0 I1 -pin output_tmp_i I0 -pin output_tmp_i__0 I2 -pin output_tmp_i__1 I0
load net JA[1] -attr @rip 1 -port JA[1] -pin JA_reg[1] Q
load net BTNR -port BTNR -pin RESET_reg D
netloc BTNR 1 0 1 NJ
load net SW[3] -attr @rip SW[3] -pin Counter16_PWM SW[3] -port SW[3]
load net counter_out[15] -attr @rip count_out[15] -pin Binary_2_BCD binary_in[15] -pin Counter16_PWM count_out[15]
load net LED[13] -attr @rip LED[13] -pin Counter16_PWM LED[13] -port LED[13]
load net CLK -pin CLK_reg Q -pin Counter16_PWM clk -pin JA_reg[1] D
netloc CLK 1 5 5 1530 850 NJ 850 NJ 850 NJ 850 NJ
load net AN[4] -attr @rip AN[4] -port AN[4] -pin Seven_Seg AN[4]
load net SW[15] -attr @rip SW[15] -pin Counter16_PWM SW[15] -port SW[15]
load net BTNU -port BTNU -pin Debounce_BTNU but
netloc BTNU 1 0 5 NJ 360 NJ 360 NJ 360 NJ 360 NJ
load net LED[9] -attr @rip LED[9] -pin Counter16_PWM LED[9] -port LED[9]
load net CLK_state[0] -attr @rip State[0] -pin CLK_FSM State[0] -pin CLK_i S[0]
load net LED[4] -attr @rip LED[4] -pin Counter16_PWM LED[4] -port LED[4]
load net bcd[0] -attr @rip bcd[0] -pin Binary_2_BCD bcd[0] -pin Seven_Seg bcd[0]
load net counter_out[12] -attr @rip count_out[12] -pin Binary_2_BCD binary_in[12] -pin Counter16_PWM count_out[12]
load net counter_out[4] -attr @rip count_out[4] -pin Binary_2_BCD binary_in[4] -pin Counter16_PWM count_out[4]
load net LED16_G -port LED16_G -pin LED16_G_i O
netloc LED16_G 1 10 1 NJ
load net SW[10] -attr @rip SW[10] -pin Counter16_PWM SW[10] -port SW[10]
load net SW[0] -attr @rip SW[0] -pin Counter16_PWM SW[0] -port SW[0]
load net AN[7] -attr @rip AN[7] -port AN[7] -pin Seven_Seg AN[7]
load netBundle @LED 16 LED[15] LED[14] LED[13] LED[12] LED[11] LED[10] LED[9] LED[8] LED[7] LED[6] LED[5] LED[4] LED[3] LED[2] LED[1] LED[0] -autobundled
netbloc @LED 1 6 5 NJ 400 NJ 400 NJ 400 NJ 400 NJ
load netBundle @bcd 20 bcd[19] bcd[18] bcd[17] bcd[16] bcd[15] bcd[14] bcd[13] bcd[12] bcd[11] bcd[10] bcd[9] bcd[8] bcd[7] bcd[6] bcd[5] bcd[4] bcd[3] bcd[2] bcd[1] bcd[0] -autobundled
netbloc @bcd 1 9 1 2470
load netBundle @SW 16 SW[15] SW[14] SW[13] SW[12] SW[11] SW[10] SW[9] SW[8] SW[7] SW[6] SW[5] SW[4] SW[3] SW[2] SW[1] SW[0] -autobundled
netbloc @SW 1 0 6 NJ 460 NJ 460 NJ 460 NJ 460 NJ 450 NJ
load netBundle @counter_out 16 counter_out[15] counter_out[14] counter_out[13] counter_out[12] counter_out[11] counter_out[10] counter_out[9] counter_out[8] counter_out[7] counter_out[6] counter_out[5] counter_out[4] counter_out[3] counter_out[2] counter_out[1] counter_out[0] -autobundled
netbloc @counter_out 1 6 3 1840 300 NJ 300 NJ
load netBundle @PWM_state 2 PWM_state[1] PWM_state[0] -autobundled
netbloc @PWM_state 1 4 6 1190 N N 610 NJ 610 NJ 610 NJ 610 2510
load netBundle @AN 8 AN[7] AN[6] AN[5] AN[4] AN[3] AN[2] AN[1] AN[0] -autobundled
netbloc @AN 1 10 1 NJ
load netBundle @JA 2 JA[2] JA[1] -autobundled
netbloc @JA 1 10 1 2800
load netBundle @CLK_state 2 CLK_state[1] CLK_state[0] -autobundled
netbloc @CLK_state 1 3 1 870
levelinfo -pg 1 0 140 380 690 1010 1310 1630 1880 2080 2330 2670 2820 -top -10 -bot 1230
show
fullfit
#
# initialize ictrl to current module main_pwm work:main_pwm:NOFILE
ictrl init topinfo |
ictrl layer glayer install
ictrl layer glayer config ibundle 1
ictrl layer glayer config nbundle 0
ictrl layer glayer config pbundle 0
ictrl layer glayer config cache 1
