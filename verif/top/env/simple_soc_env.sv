/*************************************************************

    Filename    : simple_soc_env.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-11 01:52:27
    Modify Time : 2025-03-11 01:52:27

*************************************************************/
`ifndef SIMPLE_SOC_ENV__SV
`define SIMPLE_SOC_ENV__SV

class simple_soc_env extends uvm_env;

   
   function new(string name = "simple_soc_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(simple_soc_env)
endclass

function void simple_soc_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
endfunction

`endif
