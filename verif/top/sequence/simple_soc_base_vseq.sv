/*************************************************************

    Filename    : simple_soc_base_vseq.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-12 02:11:30
    Modify Time : 2025-03-12 02:11:30

*************************************************************/
`ifndef SIMPLE_SOC_BASE_VSEQ__SV
`define SIMPLE_SOC_BASE_VSEQ__SV

class simple_soc_base_vseq extends uvm_sequence;

  /** UVM Object Utility macro */
  `uvm_object_utils(simple_soc_base_vseq)
  `uvm_declare_p_sequencer(simple_soc_virtual_sequencer)

  /** Class Constructor */
  function new (string name = "simple_soc_base_vseq");
     super.new(name);
  endfunction : new

  virtual task pre_body();
  endtask
  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask
  virtual task post_body();
  endtask

endclass : simple_soc_base_vseq 

`endif
