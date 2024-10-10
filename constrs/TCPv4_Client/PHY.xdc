create_clock -period 8.000 [get_ports PHY_RXC]
set_property IOSTANDARD LVCMOS33 [get_ports {PHY_RXD[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {PHY_TXD[*]}]
set_property SLEW FAST [get_ports {PHY_TXD[*]}]


set_property PACKAGE_PIN AA18 [get_ports PHY_MDC]
set_property PACKAGE_PIN AB18 [get_ports PHY_MDIO]
set_property PACKAGE_PIN AB17 [get_ports PHY_RSTN]

set_property PACKAGE_PIN U15 [get_ports PHY_RXC]
set_property PACKAGE_PIN Y17 [get_ports PHY_RXCTL]
set_property PACKAGE_PIN Y16 [get_ports {PHY_RXD[0]}]
set_property PACKAGE_PIN W14 [get_ports {PHY_RXD[1]}]
set_property PACKAGE_PIN Y14 [get_ports {PHY_RXD[2]}]
set_property PACKAGE_PIN Y13 [get_ports {PHY_RXD[3]}]

set_property PACKAGE_PIN AB16 [get_ports PHY_TXC]
set_property PACKAGE_PIN AB12 [get_ports PHY_TXCTL]
set_property PACKAGE_PIN AA15 [get_ports {PHY_TXD[0]}]
set_property PACKAGE_PIN AB15 [get_ports {PHY_TXD[1]}]
set_property PACKAGE_PIN AA13 [get_ports {PHY_TXD[2]}]
set_property PACKAGE_PIN AB13 [get_ports {PHY_TXD[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDIO]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RSTN]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXCTL]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXCTL]

set_property SLEW FAST [get_ports PHY_TXC]
set_property SLEW FAST [get_ports PHY_TXCTL]
