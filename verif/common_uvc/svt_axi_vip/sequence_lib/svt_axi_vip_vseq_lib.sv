/*************************************************************

    Filename    : svt_axi_vip_vseq_lib.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-15 02:09:24
    Modify Time : 2025-03-15 02:09:24

*************************************************************/
`ifndef SVT_AXI_VIP_VSEQ_LIB__SV
`define SVT_AXI_VIP_VSEQ_LIB__SV

`include "uvm_pkg.sv"
`include "svt_axi.uvm.pkg"

package svt_axi_vseq_pkg;

    import uvm_pkg::*;
    import svt_uvm_pkg::*;
    import svt_axi_uvm_pkg::*;


    `include "axi_master_wr_rd_sequence.sv"
    `include "axi_slave_mem_response_sequence.sv"

endpackage
`endif
