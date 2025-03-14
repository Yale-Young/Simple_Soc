/*************************************************************

    Filename    : simple_soc_vseq_lib.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-12 02:18:29
    Modify Time : 2025-03-12 02:18:29

*************************************************************/
`ifndef SIMPLE_SOC_VSEQ_LIB__SV
`define SIMPLE_SOC_VSEQ_LIB__SV

`include "simple_soc_base_vseq.sv"

class soc_debug_vseq extends simple_soc_base_vseq;

  /** UVM Object Utility macro */
  `uvm_object_utils(soc_debug_vseq)

  /** Class Constructor */
  function new (string name = "soc_debug_vseq");
     super.new(name);
  endfunction : new

  virtual task pre_body();
  endtask
  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask
  virtual task post_body();
  endtask

endclass : soc_debug_vseq 




`endif
