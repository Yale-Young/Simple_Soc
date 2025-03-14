/*************************************************************

    Filename    : simple_soc_env_pkg.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-11 01:50:12
    Modify Time : 2025-03-11 01:50:12

*************************************************************/
`ifndef SIMPLE_SOC_ENV_PKG__SV
`define SIMPLE_SOC_ENV_PKG__SV

`include "uvm_pkg.sv"
`include "svt_axi.uvm.pkg"
`include "svt_axi_if.svi"

package simple_soc_env_pkg;

    import uvm_pkg::*;
    import svt_uvm_pkg::*;
    import svt_axi_uvm_pkg::*;


    `include "simple_soc_virtual_sequencer.sv"
    `include "simple_soc_env.sv"

endpackage

`endif
