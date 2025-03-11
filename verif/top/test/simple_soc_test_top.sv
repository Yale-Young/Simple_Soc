`include "uvm_macros.svh"

import uvm_pkg::*;
`include "simple_soc_base_test.sv"

module simple_soc_test_top();


logic clk,tt,ss;

initial begin
clk=1'b0;
end

initial begin
	run_test();
end

always #10 clk=!clk;

simple_soc_top dd(.clk(clk),
       .tt(tt),
       .ss(ss));
     
 initial begin
    $fsdbDumpfile("sim.fsdb");
    $fsdbDumpvars(0,simple_soc_test_top);
    $fsdbDumpMDA();
 end
endmodule
