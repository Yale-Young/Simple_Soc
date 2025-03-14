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
import svt_axi_vseq_pkg::*;

`include "simple_soc_vseq_lib.sv"

class simple_soc_base_test extends uvm_test;

   simple_soc_env         soc_env;
   
   function new(string name = "simple_soc_base_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual function void set_axi_slave_sequence(int seq_id);
   `uvm_component_utils(simple_soc_base_test)
endclass


function void simple_soc_base_test::set_axi_slave_sequence(int seq_id);
    case(seq_id)
        0:begin
            uvm_config_db#(uvm_object_wrapper)::set(this,
                "soc_env.axi_system_env.slave[0].sequencer.main_phase",
                "default_sequence",
                axi_slave_mem_response_sequence::type_id::get());
        end
        default:begin
            uvm_config_db#(uvm_object_wrapper)::set(this,
                "soc_env.axi_system_env.slave[0].sequencer.main_phase",
                "default_sequence",
                axi_slave_mem_response_sequence::type_id::get());
        end
    endcase
endfunction
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


`define soc_create_test(name,id) \
\
class simple_soc_``name``_test extends simple_soc_base_test;\
\
   \
   function new(string name = `"simple_soc_``name``_test`", uvm_component parent = null);\
      super.new(name,parent);\
   endfunction\
   \
   extern virtual function void build_phase(uvm_phase phase);\
   `uvm_component_utils(simple_soc_``name``_test)\
endclass\
\
\
function void simple_soc_debug_test::build_phase(uvm_phase phase);\
   super.build_phase(phase);\
   uvm_config_db#(uvm_object_wrapper)::set(this,\
                                              "soc_env.soc_sequencer.main_phase",\
                                              "default_sequence",\
                                               soc_``name``_vseq::type_id::get());\
    set_axi_slave_sequence(id);\
endfunction

`include "simple_soc_test_lib.sv"
`endif
