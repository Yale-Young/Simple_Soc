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

  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
    axi_master_wr_rd_sequence  axi_mst_seq;
    axi_mst_seq = new();
    `uvm_info("body", "Entered ...", UVM_LOW)
    #1000ns;
    `uvm_info(get_full_name,"test",UVM_LOW)
    //axi_mst_seq.start(p_sequencer.axi_mst_sqr);
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask

endclass : soc_debug_vseq 




`endif
