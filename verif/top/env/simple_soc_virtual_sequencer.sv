/*************************************************************

    Filename    : simple_soc_virtual_sequencer.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-12 01:53:45
    Modify Time : 2025-03-12 01:53:45

*************************************************************/
`ifndef SIMPLE_SOC_VIRTUAL_SEQUENCER__SV
`define SIMPLE_SOC_VIRTUAL_SEQUENCER__SV

class simple_soc_virtual_sequencer extends uvm_sequencer;

    svt_axi_system_sequencer axi_sqr;

  `uvm_component_utils(simple_soc_virtual_sequencer)

  function new(string name="simple_soc_virtual_sequencer", uvm_component parent=null);
    super.new(name,parent);
  endfunction // new


  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

  endfunction

endclass

`endif
