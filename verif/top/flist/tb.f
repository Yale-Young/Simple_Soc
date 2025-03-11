/////////////DUT///////////////
-f $VERILOG_HOME/flist/dut.f
/////////////TB/////////////////
+incdir+$UVM_HOME
$UVM_HOME/dpi/uvm_dpi.cc
$UVM_HOME/uvm.sv
+incdir+$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/include/
+incdir+$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/src/
+incdir+$VERIF_HOME/top/env/
$VERIF_HOME/top/env/simple_soc_env_pkg.sv
+incdir+$VERIF_HOME/top/test/
$VERIF_HOME/top/test/simple_soc_test_top.sv
