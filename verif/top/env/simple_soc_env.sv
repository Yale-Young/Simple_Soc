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
    simple_soc_virtual_sequencer  soc_sequencer;

   
   function new(string name = "simple_soc_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...",UVM_LOW)
      super.build_phase(phase);

      axi_sys_cfg = svt_axi_system_configuration::type_id::create("axi_sys_cfg");
      axi_sys_cfg.num_masters = 1;
      axi_sys_cfg.num_slaves  = 1;
      axi_sys_cfg.system_monitor_enable = 1;

      axi_sys_cfg.create_sub_cfgs(1,1);

      axi_sys_cfg.master_cfg[0].enable_xml_gen = 1;
      axi_sys_cfg.slave_cfg[0].enable_xml_gen = 1;
      axi_sys_cfg.master_cfg[0].pa_format_type = svt_xml_writer::FSDB;
      axi_sys_cfg.slave_cfg[0].pa_format_type= svt_xml_writer::FSDB;

      axi_sys_cfg.master_cfg[0].transaction_coverage_enable = 1;
      axi_sys_cfg.slave_cfg[0].transaction_coverage_enable = 1;

      axi_sys_cfg.master_cfg[0].data_width = 256;
      axi_sys_cfg.slave_cfg[0].data_width = 256;
      axi_sys_cfg.master_cfg[0].id_width = 8;
      axi_sys_cfg.slave_cfg[0].id_width = 8;

      axi_sys_cfg.master_cfg[0].reordering_algorithm = svt_axi_port_configuration::RANDOM;
      axi_sys_cfg.slave_cfg[0].reordering_algorithm = svt_axi_port_configuration::RANDOM;
      axi_sys_cfg.master_cfg[0].write_resp_reordering_depth = `SVT_AXI_MAX_WRITE_RESP_REORDERING_DEPTH;
      axi_sys_cfg.slave_cfg[0].write_resp_reordering_depth = `SVT_AXI_MAX_WRITE_RESP_REORDERING_DEPTH;
      axi_sys_cfg.set_addr_range(0,64'h0,64'hffff_ffff_ffff_ffff);

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
   soc_sequencer.axi_mst_sqr = axi_system_env.master[0].sequencer;
   soc_sequencer.axi_slv_sqr = axi_system_env.slave[0].sequencer;
endfunction

`endif
