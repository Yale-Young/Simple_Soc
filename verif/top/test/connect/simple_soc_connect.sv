/*************************************************************

    Filename    : simple_soc_connect.sv
    Author      : yyl
    Description : 
    Creat Time  : 2025-03-12 01:00:32
    Modify Time : 2025-03-12 01:00:32

*************************************************************/
`ifndef SIMPLE_SOC_CONNECT__SV
`define SIMPLE_SOC_CONNECT__SV

`include "svt_axi_if.svi"

  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 50;

  /** Signal to generate the clock */
  bit SystemClock,rst_n;

  svt_axi_if axi_if();
  assign axi_if.common_aclk = SystemClock;

  /** TB Interface instance to provide access to the reset signal */

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * interface.
   */
  assign axi_if.master_if[0].aresetn = rst_n;//axi_reset_if.reset;
  assign axi_if.slave_if[0].aresetn =  rst_n;//axi_reset_if.reset;

  initial begin
    rst_n = 1'b1;
    #80ns;
    rst_n = 1'b0;
    #200ns;
    rst_n = 1'b1;

  end

  /** Testbench 'System' Clock Generator */
  initial begin
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
        SystemClock = ~SystemClock ;
    end
  end

  wire local_awvalid;
  wire [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           local_awaddr;
  wire [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   local_awlen;
  wire [`SVT_AXI_SIZE_WIDTH-1:0]               local_awsize;
  wire [`SVT_AXI_BURST_WIDTH-1:0]              local_awburst;
  wire [`SVT_AXI_LOCK_WIDTH-1:0]               local_awlock;
  wire [`SVT_AXI_CACHE_WIDTH-1:0]              local_awcache;
  wire [`SVT_AXI_PROT_WIDTH-1:0]               local_awprot;
  wire [`SVT_AXI_MAX_ID_WIDTH-1:0]             local_awid;

  wire                                         local_arvalid;
  wire [`SVT_AXI_MAX_ADDR_WIDTH-1:0]           local_araddr;
  wire [`SVT_AXI_MAX_BURST_LENGTH_WIDTH-1:0]   local_arlen;
  wire [`SVT_AXI_SIZE_WIDTH-1:0]               local_arsize;
  wire [`SVT_AXI_BURST_WIDTH-1:0]              local_arburst;
  wire [`SVT_AXI_LOCK_WIDTH-1:0]               local_arlock;
  wire [`SVT_AXI_CACHE_WIDTH-1:0]              local_arcache;
  wire [`SVT_AXI_PROT_WIDTH-1:0]               local_arprot;
  wire [`SVT_AXI_MAX_ID_WIDTH-1:0]             local_arid;

  wire                                         local_wvalid;
  wire                                         local_wlast;
  wire [`SVT_AXI_MAX_DATA_WIDTH-1:0]           local_wdata;
  wire [`SVT_AXI_MAX_DATA_WIDTH/8-1:0]         local_wstrb;
  wire [`SVT_AXI_MAX_ID_WIDTH-1:0]             local_wid;

  wire local_rready;
  wire local_bready;
  wire local_awready;
  wire local_arready;
  wire local_rvalid;
  wire local_rlast;
  wire [`SVT_AXI_MAX_DATA_WIDTH-1:0] local_rdata;
  wire [`SVT_AXI_RESP_WIDTH-1:0] local_rresp;
  wire [`SVT_AXI_MAX_ID_WIDTH-1:0] local_rid;
  wire local_wready;
  wire local_bvalid;
  wire [`SVT_AXI_RESP_WIDTH-1:0] local_bresp;
  wire [`SVT_AXI_MAX_ID_WIDTH-1:0] local_bid;
  


  /** 
   * HDL Interconnect Instantiation: Example HDL Interconnect is just
   * pass-through connection. 
   */
    assign u_soc.aclk =axi_if.master_if[0].internal_aclk;
    assign u_soc.aresetn =axi_if.master_if[0].aresetn;

    /**
     * write address channel 
     */
    assign u_soc.awvalid_m1 =axi_if.master_if[0].awvalid;
    assign u_soc.awaddr_m1 =axi_if.master_if[0].awaddr;
    assign u_soc.awlen_m1 =axi_if.master_if[0].awlen;
    assign u_soc.awsize_m1 =axi_if.master_if[0].awsize;
    assign u_soc.awburst_m1 =axi_if.master_if[0].awburst;
    assign u_soc.awlock_m1 =axi_if.master_if[0].awlock;
    assign u_soc.awcache_m1 =axi_if.master_if[0].awcache;
    assign u_soc.awprot_m1 =axi_if.master_if[0].awprot;
    assign u_soc.awid_m1 =axi_if.master_if[0].awid;
    assign local_awready=u_soc.awready_m1;

    /**
     * read address channel 
     */
    assign u_soc.arvalid_m1 =axi_if.master_if[0].arvalid;
    assign u_soc.araddr_m1 =axi_if.master_if[0].araddr;
    assign u_soc.arlen_m1 =axi_if.master_if[0].arlen;
    assign u_soc.arsize_m1 =axi_if.master_if[0].arsize;
    assign u_soc.arburst_m1 =axi_if.master_if[0].arburst;
    assign u_soc.arlock_m1 =axi_if.master_if[0].arlock;
    assign u_soc.arcache_m1 =axi_if.master_if[0].arcache;
    assign u_soc.arprot_m1 =axi_if.master_if[0].arprot;
    assign u_soc.arid_m1 =axi_if.master_if[0].arid;
    assign local_arready = u_soc.arready_m1 ;

    /**
     * read channel 
     */
    assign local_rvalid = u_soc.rvalid_m1  ;
    assign local_rlast  = u_soc.rlast_m1   ;
    assign local_rdata  = u_soc.rdata_m1   ;
    assign local_rresp  = u_soc.rresp_m1   ;
    assign local_rid    = u_soc.rid_m1     ;
    assign u_soc.rready_m1 =axi_if.master_if[0].rready;

    /**
     * write channel 
     */
    assign u_soc.wvalid_m1 =axi_if.master_if[0].wvalid;
    assign u_soc.wlast_m1 =axi_if.master_if[0].wlast;
    assign u_soc.wdata_m1 =axi_if.master_if[0].wdata;
    assign u_soc.wstrb_m1 =axi_if.master_if[0].wstrb;
    assign u_soc.wid_m1 =axi_if.master_if[0].wid;
    assign local_wready = u_soc.wready_m1 ;

    /**
     * write response channel 
     */
    assign local_bvalid = u_soc.bvalid_m1   ;
    assign local_bresp  = u_soc.bresp_m1    ;
    assign local_bid    = u_soc.bid_m1      ;
    assign u_soc.bready_m1 =axi_if.master_if[0].bready;


    /**
     * write address channel 
     */
    assign local_awvalid = u_soc.awvalid_s1     ;
    assign local_awaddr  = u_soc.awaddr_s1      ;
    assign local_awlen   = u_soc.awlen_s1       ;
    assign local_awsize  = u_soc.awsize_s1      ;
    assign local_awburst = u_soc.awburst_s1     ;
    assign local_awlock  = u_soc.awlock_s1      ;
    assign local_awcache = u_soc.awcache_s1     ;
    assign local_awprot  = u_soc.awprot_s1      ;
    assign local_awid    = u_soc.awid_s1        ;
    assign u_soc.awready_s1 =axi_if.slave_if[0].awready;

    /**
     * read address channel 
     */
    assign local_arvalid = u_soc.arvalid_s1     ;
    assign local_araddr  = u_soc.araddr_s1      ;
    assign local_arlen   = u_soc.arlen_s1       ;
    assign local_arsize  = u_soc.arsize_s1      ;
    assign local_arburst = u_soc.arburst_s1     ;
    assign local_arlock  = u_soc.arlock_s1      ;
    assign local_arcache = u_soc.arcache_s1     ;
    assign local_arprot  = u_soc.arprot_s1      ;
    assign local_arid    = u_soc.arid_s1        ;
    assign u_soc.arready_s1 =axi_if.slave_if[0].arready;

    /**
     * read channel 
     */
    assign u_soc.rvalid_s1      =axi_if.slave_if[0].rvalid;
    assign u_soc.rlast_s1       =axi_if.slave_if[0].rlast;
    assign u_soc.rdata_s1       =axi_if.slave_if[0].rdata;
    assign u_soc.rresp_s1       =axi_if.slave_if[0].rresp;
    assign u_soc.rid_s1         =axi_if.slave_if[0].rid;
    assign local_rready = u_soc.rready_s1      ;
                       
    /**                
     * write channel   
     */                
    assign local_wvalid = u_soc.wvalid_s1      ;
    assign local_wlast  = u_soc.wlast_s1       ;
    assign local_wdata  = u_soc.wdata_s1       ;
    assign local_wstrb  = u_soc.wstrb_s1       ;
    assign local_wid    = u_soc.wid_s1         ;
    assign u_soc.wready_s1      =axi_if.slave_if[0].wready;

    /**
     * write response channel 
     */
    assign u_soc.bvalid_s1   =      axi_if.slave_if[0].bvalid;
    assign u_soc.bresp_s1    =      axi_if.slave_if[0].bresp;
    assign u_soc.bid_s1      =      axi_if.slave_if[0].bid;
    assign    local_bready = u_soc.bready_s1 ;

  // Assign local AXI signals to slave and master interface for resolve W,CUVIHR warning in IUS.
  // This updates is applicable to other simulator also because these local signals are  
  // instanstiated inside the module.  
  always @ (*) assign axi_if.master_if[0].awready = local_awready;
  always @ (*) assign axi_if.master_if[0].arready = local_arready;
  always @ (*) assign axi_if.master_if[0].rvalid = local_rvalid;
  always @ (*) assign axi_if.master_if[0].rlast = local_rlast;
  always @ (*) assign axi_if.master_if[0].rdata = local_rdata;
  always @ (*) assign axi_if.master_if[0].rresp = local_rresp;
  always @ (*) assign axi_if.master_if[0].rid = local_rid;
  always @ (*) assign axi_if.master_if[0].wready = local_wready;
  always @ (*) assign axi_if.master_if[0].bvalid = local_bvalid;
  always @ (*) assign axi_if.master_if[0].bresp = local_bresp;
  always @ (*) assign axi_if.master_if[0].bid = local_bid;

  always @ (*) assign axi_if.slave_if[0].awvalid = local_awvalid;
  always @ (*) assign axi_if.slave_if[0].awaddr = local_awaddr;
  always @ (*) assign axi_if.slave_if[0].awlen = local_awlen;
  always @ (*) assign axi_if.slave_if[0].awsize = local_awsize;
  always @ (*) assign axi_if.slave_if[0].awburst = local_awburst;
  always @ (*) assign axi_if.slave_if[0].awlock = local_awlock;
  always @ (*) assign axi_if.slave_if[0].awcache = local_awcache;
  always @ (*) assign axi_if.slave_if[0].awprot = local_awprot;
  always @ (*) assign axi_if.slave_if[0].awid = local_awid;

  always @ (*) assign axi_if.slave_if[0].arvalid = local_arvalid;
  always @ (*) assign axi_if.slave_if[0].araddr = local_araddr;
  always @ (*) assign axi_if.slave_if[0].arlen = local_arlen;
  always @ (*) assign axi_if.slave_if[0].arsize = local_arsize;
  always @ (*) assign axi_if.slave_if[0].arburst = local_arburst;
  always @ (*) assign axi_if.slave_if[0].arlock = local_arlock;
  always @ (*) assign axi_if.slave_if[0].arcache = local_arcache;
  always @ (*) assign axi_if.slave_if[0].arprot = local_arprot;
  always @ (*) assign axi_if.slave_if[0].arid = local_arid;

  always @ (*) assign axi_if.slave_if[0].wvalid = local_wvalid;
  always @ (*) assign axi_if.slave_if[0].wlast = local_wlast;
  always @ (*) assign axi_if.slave_if[0].wdata = local_wdata;
  always @ (*) assign axi_if.slave_if[0].wstrb = local_wstrb;
  always @ (*) assign axi_if.slave_if[0].wid = local_wid;
  always @ (*) assign axi_if.slave_if[0].rready = local_rready;
  always @ (*) assign axi_if.slave_if[0].bready = local_bready;

  initial begin
    uvm_config_db#(svt_axi_vif)::set(uvm_root::get(), "uvm_test_top.soc_env.axi_system_env", "vif", axi_if);

  end

`endif
