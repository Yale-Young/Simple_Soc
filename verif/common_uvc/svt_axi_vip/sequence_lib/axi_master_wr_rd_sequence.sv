/*************************************************************

    Filename    : axi_master_wr_rd_sequence.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-15 02:07:19
    Modify Time : 2025-03-15 02:07:19

*************************************************************/
`ifndef AXI_MASTER_WR_RD_SEQUENCE__SV
`define AXI_MASTER_WR_RD_SEQUENCE__SV

class axi_master_wr_rd_sequence extends svt_axi_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_wr_rd_sequence)

  /** Class Constructor */
  function new(string name="axi_master_wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    fork
    forever begin
      get_response(rsp);
    end
    join_none
    
    repeat (sequence_length) begin
    `uvm_info("sequence", "Entered ...", UVM_LOW)
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
        `uvm_do_with(req, 
        { 
          xact_type == svt_axi_transaction::WRITE;
          data_before_addr == 0;
        })
      `else
       `uvm_do(req,,, 
        { 
          xact_type == svt_axi_transaction::WRITE;
          data_before_addr == 0;
        })
      `endif
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
        `uvm_do_with(req, 
        { 
          xact_type == svt_axi_transaction::READ;
          data_before_addr == 0;
        })
      `else 
        `uvm_do(req,,, 
        { 
          xact_type == svt_axi_transaction::READ;
          data_before_addr == 0;
        })
      `endif
    `uvm_info("sequence", "Done ...", UVM_LOW)
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_master_wr_rd_sequence

`endif
