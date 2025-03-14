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

    svt_axi_system_env            axi_system_env;
    svt_axi_system_configuration  axi_sys_cfg;
    svt_axi_system_sequencer      axi_sqr;
    simple_soc_virtual_sequencer  soc_sequencer;

   
   function new(string name = "simple_soc_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...",UVM_LOW)
      super.build_phase(phase);

      axi_sys_cfg = svt_axi_system_configuration::type_id::create("axi_sys_cfg");

      /** Apply the configuration to the System ENV */
      uvm_config_db#(svt_axi_system_configuration)::set(this, "axi_system_env", "cfg", axi_sys_cfg);

      /** Construct the system agent */
      axi_system_env = svt_axi_system_env::type_id::create("axi_system_env", this);

      /** Construct the virtual sequencer */
      soc_sequencer = simple_soc_virtual_sequencer::type_id::create("soc_sequencer", this);
      
      `uvm_info("build_phase", "Exiting...", UVM_LOW)
   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   
   `uvm_component_utils(simple_soc_env)
endclass

function void simple_soc_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   axi_sqr = axi_system_env.sequencer;
endfunction

`endif
