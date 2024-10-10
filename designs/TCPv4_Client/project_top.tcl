#*****************************************************
#
#					Copyright  	S&Z   
# 					Author		ÂäÄ«
# 					Version   	1.0
# 					Date		2024.10.10
# 
#***************************************************** 

# Set Project Name
set design_nm "TCPv4_Client"

# Set Device
set device "xc7a100tfgg484-2"

# Set Paths
set project_dir "build/$design_nm"
set ip_dir 		"srcs/ip/$design_nm"
set hdl_dir 	"srcs/hdl/$design_nm"
set sim_dir     "srcs/sim/$design_nm"
set constrs_dir "constrs/$design_nm"
set scripts_dir "designs/$design_nm"

set ip_path		"ip_repo_enc"

# Create Project
create_project -name $design_nm -dir $project_dir -part $device -force

# Add User IP path
set_property  ip_repo_paths  $ip_path [current_project]

# Import Hdl
import_files  -norecurse   $hdl_dir/Clock_Reset/Sys_Rst.v
import_files  -norecurse   $hdl_dir/Clock_Reset/Clock_Reset.sv

import_files  -norecurse   $hdl_dir/Debug/speed_cal.sv

import_files  -norecurse   $hdl_dir/GIG_ETH/Arbiter/arbiter.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/Arbiter/arbiter_next_sel_max16.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/Arbiter/Encoder.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/GIG_IPv4_2023/UDP_TCP_IPv4_Block_all_2023.2.svp
import_files  -norecurse   $hdl_dir/GIG_ETH/GIG_IPv4_2023/GIG_IPv4_Types.svh
import_files  -norecurse   $hdl_dir/GIG_ETH/IO/GMII_2_AXIS.v
import_files  -norecurse   $hdl_dir/GIG_ETH/IO/pin_fix_delay.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/IO/RGMII_DELAY.v
import_files  -norecurse   $hdl_dir/GIG_ETH/IO/RGMII_IO.v
import_files  -norecurse   $hdl_dir/GIG_ETH/xpm_lib/xpm_sdpram.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/xpm_lib/xpm_sync_fifo.sv
import_files  -norecurse   $hdl_dir/GIG_ETH/xpm_lib/xpm_tdpram.sv

import_files  -norecurse   $hdl_dir/$design_nm/TCPv4_Client_all_2023.2.svp

import_files  -norecurse   $hdl_dir/TCPv4_Common/TCPv4_CS_Common_2023.2.svp

import_files  -norecurse   $hdl_dir/Top/TCPv4_Client_Test_Top.sv
import_files  -norecurse   $hdl_dir/Top/TCPv4_Client_Top.sv

import_files  -norecurse   $hdl_dir/report/Seq_Check.v

# Add IP
import_files  -norecurse   $ip_dir/clk_wiz_200/clk_wiz_200.xci
import_files  -norecurse   $ip_dir/vio_tcp_test/vio_tcp_test.xci
import_files  -norecurse   $ip_dir/ila_tcpv4_test/ila_tcpv4_test.xci
# Set top level
set_property top TCPv4_Client_Test_Top [current_fileset]


# Import xdc

import_files -fileset constrs_1  -norecurse $constrs_dir/PHY.xdc
import_files -fileset constrs_1  -norecurse $constrs_dir/Top.xdc

# Add sim file
# add_files -norecurse  -scan_for_includes $sim_dir



#Generate bit file
#reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 12
wait_on_run impl_1

close_project
