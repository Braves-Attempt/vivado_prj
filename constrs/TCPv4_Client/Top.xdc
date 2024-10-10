set_property BITSTREAM.CONFIG.CONFIGRATE 22 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


create_clock -period 8.000 -name PHY_RXC -waveform {0.000 4.000} [get_ports PHY_RXC]

############## SYS_CLK ##################
create_clock -period 20.000 [get_ports SYS_CLK]
set_property PACKAGE_PIN Y18 [get_ports SYS_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports SYS_CLK]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
