/*************************************************************

    Filename    : simple_soc_base_test.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-11 01:43:26
    Modify Time : 2025-03-11 01:43:26

*************************************************************/
`ifndef SIMPLE_SOC_BASE_TEST__SV
`define SIMPLE_SOC_BASE_TEST__SV

import simple_soc_env_pkg::*;

class simple_soc_base_test extends uvm_test;

   simple_soc_env         soc_env;
   
   function new(string name = "simple_soc_base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   `uvm_component_utils(simple_soc_base_test)
endclass


function void simple_soc_base_test::build_phase(uvm_phase phase);
   super.build_phase(phase);
   soc_env  =  simple_soc_env::type_id::create("soc_env", this); 
   /*uvm_config_db#(uvm_object_wrapper)::set(this,
                                              "env.i_agt.sqr.main_phase",
                                              "default_sequence",
                                               my_sequence::type_id::get());*/
endfunction

function void simple_soc_base_test::report_phase(uvm_phase phase);
   uvm_report_server server;
   int err_num;
   super.report_phase(phase);

   server = get_report_server();
   err_num = server.get_severity_count(UVM_ERROR);

   if (err_num != 0) begin
      $display("TEST CASE FAILED");
   end
   else begin
      $display("TEST CASE PASSED");
   end
endfunction

`endif
