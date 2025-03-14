`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "svt_axi.uvm.pkg"
`include "svt_axi_if.svi"
import uvm_pkg::*;
import svt_uvm_pkg::*;
import svt_axi_uvm_pkg::*;
`include "simple_soc_base_test.sv"

module simple_soc_test_top();

`include "simple_soc_connect.sv"

initial begin
	run_test();
end

simple_soc_top u_soc();
     
 initial begin
    $fsdbDumpfile("sim.fsdb");
    $fsdbDumpvars(0,simple_soc_test_top);
    $fsdbDumpMDA();
 end
endmodule
