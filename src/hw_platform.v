module hw_platform
(
  input                   [15:0] pcie_rxp,
  input                   [15:0] pcie_rxn,
  output                  [15:0] pcie_txp,
  output                  [15:0] pcie_txn,
  input                          pcie_refclk_p,
  input                          pcie_refclk_n,
  input                          pcie_rstn,

  input    [4*2-1:0]             qsfp_rxp,
  input    [4*2-1:0]             qsfp_rxn,
  output   [4*2-1:0]             qsfp_txp,
  output   [4*2-1:0]             qsfp_txn,
  input      [2-1:0]             qsfp_refclk_p,
  input      [2-1:0]             qsfp_refclk_n,

  input                          c0_sys_clk_p,
  input                          c0_sys_clk_n,
  output                         c0_ddr4_act_n,
  output [16:0]                  c0_ddr4_adr,
  output [1:0]                   c0_ddr4_ba,
  output [1:0]                   c0_ddr4_bg,
  output [0:0]                   c0_ddr4_cke,
  output [0:0]                   c0_ddr4_odt,
  output [0:0]                   c0_ddr4_cs_n,
  output [0:0]                   c0_ddr4_ck_t,
  output [0:0]                   c0_ddr4_ck_c,
  output                         c0_ddr4_reset_n,
  inout  [8:0]                   c0_ddr4_dm_dbi_n,
  inout  [71:0]                  c0_ddr4_dq,
  inout  [8:0]                   c0_ddr4_dqs_c,
  inout  [8:0]                   c0_ddr4_dqs_t,

  input                          c1_sys_clk_p,
  input                          c1_sys_clk_n,
  output                         c1_ddr4_act_n,
  output [16:0]                  c1_ddr4_adr,
  output [1:0]                   c1_ddr4_ba,
  output [1:0]                   c1_ddr4_bg,
  output [0:0]                   c1_ddr4_cke,
  output [0:0]                   c1_ddr4_odt,
  output [0:0]                   c1_ddr4_cs_n,
  output [0:0]                   c1_ddr4_ck_t,
  output [0:0]                   c1_ddr4_ck_c,
  output                         c1_ddr4_reset_n,
  inout  [8:0]                   c1_ddr4_dm_dbi_n,
  inout  [71:0]                  c1_ddr4_dq,
  inout  [8:0]                   c1_ddr4_dqs_c,
  inout  [8:0]                   c1_ddr4_dqs_t,

  input                          c2_sys_clk_p,
  input                          c2_sys_clk_n,
  output                         c2_ddr4_act_n,
  output [16:0]                  c2_ddr4_adr,
  output [1:0]                   c2_ddr4_ba,
  output [1:0]                   c2_ddr4_bg,
  output [0:0]                   c2_ddr4_cke,
  output [0:0]                   c2_ddr4_odt,
  output [0:0]                   c2_ddr4_cs_n,
  output [0:0]                   c2_ddr4_ck_t,
  output [0:0]                   c2_ddr4_ck_c,
  output                         c2_ddr4_reset_n,
  inout  [8:0]                   c2_ddr4_dm_dbi_n,
  inout  [71:0]                  c2_ddr4_dq,
  inout  [8:0]                   c2_ddr4_dqs_c,
  inout  [8:0]                   c2_ddr4_dqs_t,

  input                          c3_sys_clk_p,
  input                          c3_sys_clk_n,
  output                         c3_ddr4_act_n,
  output [16:0]                  c3_ddr4_adr,
  output [1:0]                   c3_ddr4_ba,
  output [1:0]                   c3_ddr4_bg,
  output [0:0]                   c3_ddr4_cke,
  output [0:0]                   c3_ddr4_odt,
  output [0:0]                   c3_ddr4_cs_n,
  output [0:0]                   c3_ddr4_ck_t,
  output [0:0]                   c3_ddr4_ck_c,
  output                         c3_ddr4_reset_n,
  inout  [8:0]                   c3_ddr4_dm_dbi_n,
  inout  [71:0]                  c3_ddr4_dq,
  inout  [8:0]                   c3_ddr4_dqs_c,
  inout  [8:0]                   c3_ddr4_dqs_t
);

wire          pcie_refclk_gt;
wire          pcie_refclk;
wire          axi_aclk;
wire          axi_aresetn;

IBUFDS_GTE4 pcie_refclk_buf (
  .CEB   (1'b0),
  .I     (pcie_refclk_p),
  .IB    (pcie_refclk_n),
  .O     (pcie_refclk_gt),
  .ODIV2 (pcie_refclk)
);
wire              m_axi_awready;
wire              m_axi_wready;
wire [3 : 0]      m_axi_bid;
wire [1 : 0]      m_axi_bresp;
wire              m_axi_bvalid;
wire              m_axi_arready;
wire [3 : 0]      m_axi_rid;
wire [511 : 0]    m_axi_rdata;
wire [1 : 0]      m_axi_rresp;
wire              m_axi_rlast;
wire              m_axi_rvalid;
wire [3 : 0]      m_axi_awid;
wire [63 : 0]     m_axi_awaddr;
wire [7 : 0]      m_axi_awlen;
wire [2 : 0]      m_axi_awsize;
wire [1 : 0]      m_axi_awburst;
wire [2 : 0]      m_axi_awprot;
wire              m_axi_awvalid;
wire              m_axi_awlock;
wire [3 : 0]      m_axi_awcache;
wire [511 : 0]    m_axi_wdata;
wire [63 : 0]     m_axi_wstrb;
wire              m_axi_wlast;
wire              m_axi_wvalid;
wire              m_axi_bready;
wire [3 : 0]      m_axi_arid;
wire [63 : 0]     m_axi_araddr;
wire [7 : 0]      m_axi_arlen;
wire [2 : 0]      m_axi_arsize;
wire [1 : 0]      m_axi_arburst;
wire [2 : 0]      m_axi_arprot;
wire              m_axi_arvalid;
wire              m_axi_arlock;
wire [3 : 0]      m_axi_arcache;
wire              m_axi_rready;
wire              user_lnk_up ;


IBUF pcie_rstn_ibuf_inst (.I(pcie_rstn), .O(pcie_rstn_int));
xdma_0  xdma_0(
  .sys_clk                    (pcie_refclk                  ),
  .sys_clk_gt                 (pcie_refclk_gt               ),
  .sys_rst_n                  (pcie_rstn_int                ),
  .user_lnk_up                (user_lnk_up                  ),

  .pci_exp_txp                (pcie_txp                     ),
  .pci_exp_txn                (pcie_txn                     ),
  .pci_exp_rxp                (pcie_rxp                     ),
  .pci_exp_rxn                (pcie_rxn                     ),

  .axi_aclk                   (axi_aclk                     ),
  .axi_aresetn                (axi_aresetn                  ),
  .usr_irq_req                ('d0                          ),
  .usr_irq_ack                (),
  .msi_enable                 (),
  .msi_vector_width           (),

  .m_axi_awready              (m_axi_awready                ),
  .m_axi_wready               (m_axi_wready                 ),
  .m_axi_bid                  (m_axi_bid                    ),
  .m_axi_bresp                (m_axi_bresp                  ),
  .m_axi_bvalid               (m_axi_bvalid                 ),
  .m_axi_arready              (m_axi_arready                ),
  .m_axi_rid                  (m_axi_rid                    ),
  .m_axi_rdata                (m_axi_rdata                  ),
  .m_axi_rresp                (m_axi_rresp                  ),
  .m_axi_rlast                (m_axi_rlast                  ),
  .m_axi_rvalid               (m_axi_rvalid                 ),
  .m_axi_awid                 (m_axi_awid                   ),
  .m_axi_awaddr               (m_axi_awaddr                 ),
  .m_axi_awlen                (m_axi_awlen                  ),
  .m_axi_awsize               (m_axi_awsize                 ),
  .m_axi_awburst              (m_axi_awburst                ),
  .m_axi_awprot               (m_axi_awprot                 ),
  .m_axi_awvalid              (m_axi_awvalid                ),
  .m_axi_awlock               (m_axi_awlock                 ),
  .m_axi_awcache              (m_axi_awcache                ),
  .m_axi_wdata                (m_axi_wdata                  ),
  .m_axi_wstrb                (m_axi_wstrb                  ),
  .m_axi_wlast                (m_axi_wlast                  ),
  .m_axi_wvalid               (m_axi_wvalid                 ),
  .m_axi_bready               (m_axi_bready                 ),
  .m_axi_arid                 (m_axi_arid                   ),   
  .m_axi_araddr               (m_axi_araddr                 ),
  .m_axi_arlen                (m_axi_arlen                  ),
  .m_axi_arsize               (m_axi_arsize                 ),
  .m_axi_arburst              (m_axi_arburst                ),
  .m_axi_arprot               (m_axi_arprot                 ),
  .m_axi_arvalid              (m_axi_arvalid                ),
  .m_axi_arlock               (m_axi_arlock                 ),
  .m_axi_arcache              (m_axi_arcache                ),
  .m_axi_rready               (m_axi_rready                 ),

  .cfg_mgmt_addr              ('d1),
  .cfg_mgmt_write             ('d1),
  .cfg_mgmt_write_data        ('d1),
  .cfg_mgmt_byte_enable       ('d0),
  .cfg_mgmt_read              ('d0),
  .cfg_mgmt_read_data         (),
  .cfg_mgmt_read_write_done   ()

//  .mcap_design_switch         (),
//  .cap_req                    (),
//  .cap_gnt                    ('d0),
//  .cap_rel                    ('d0)
);

ddr_top ddr_top 
(
    .axi_clk            (axi_aclk                 ),
    .axi_rst            (~axi_aresetn             ),
    .m_axi_awready      (m_axi_awready            ),
    .m_axi_awid         (m_axi_awid               ),
    .m_axi_awaddr       (m_axi_awaddr             ),
    .m_axi_awuser       (m_axi_awuser             ),
    .m_axi_awlen        (m_axi_awlen              ),
    .m_axi_awsize       (m_axi_awsize             ),
    .m_axi_awburst      (m_axi_awburst            ),
    .m_axi_awprot       (m_axi_awprot             ),
    .m_axi_awvalid      (m_axi_awvalid            ),
    .m_axi_awlock       (m_axi_awlock             ),
    .m_axi_awcache      (m_axi_awcache            ),

    .m_axi_wready       (m_axi_wready             ),
    .m_axi_wdata        (m_axi_wdata              ),
    .m_axi_wuser        (m_axi_wuser              ),
    .m_axi_wstrb        (m_axi_wstrb              ),
    .m_axi_wlast        (m_axi_wlast              ),
    .m_axi_wvalid       (m_axi_wvalid             ),

    .m_axi_bid          (m_axi_bid                ),
    .m_axi_bresp        (m_axi_bresp              ),
    .m_axi_bvalid       (m_axi_bvalid             ),
    .m_axi_bready       (m_axi_bready             ),

    .m_axi_arready      (m_axi_arready            ),
    .m_axi_arid         (m_axi_arid               ),
    .m_axi_araddr       (m_axi_araddr             ),
    .m_axi_aruser       (m_axi_aruser             ),
    .m_axi_arlen        (m_axi_arlen              ),
    .m_axi_arsize       (m_axi_arsize             ),
    .m_axi_arburst      (m_axi_arburst            ),
    .m_axi_arprot       (m_axi_arprot             ),
    .m_axi_arvalid      (m_axi_arvalid            ),
    .m_axi_arlock       (m_axi_arlock             ),
    .m_axi_arcache      (m_axi_arcache            ), 

    .m_axi_rid          (m_axi_rid                ),
    .m_axi_rdata        (m_axi_rdata              ),
    .m_axi_rresp        (m_axi_rresp              ),
    .m_axi_rlast        (m_axi_rlast              ),
    .m_axi_rvalid       (m_axi_rvalid             ),
    .m_axi_rready       (m_axi_rready             ),

//  user 
  .m_axi_user_awready  (),
  .m_axi_user_awid     ('d1                   ),
  .m_axi_user_awaddr   ('d1                   ),
  .m_axi_user_awuser   ('d1                   ),
  .m_axi_user_awlen    ('d1                   ),
  .m_axi_user_awsize   ('d1                   ),
  .m_axi_user_awburst  ('d1                   ),
  .m_axi_user_awprot   ('d1                   ),
  .m_axi_user_awvalid  ('d1                   ),
  .m_axi_user_awlock   ('d1                   ),
  .m_axi_user_awcache  ('d1                   ),

  .m_axi_user_wready   (                      ),
  .m_axi_user_wdata    ('d1                   ),
  .m_axi_user_wuser    ('d1                   ),
  .m_axi_user_wstrb    ('d1                   ),
  .m_axi_user_wlast    ('d1                   ),
  .m_axi_user_wvalid   ('d1                   ),

  .m_axi_user_bid      (),
  .m_axi_user_bresp    (),
  .m_axi_user_bvalid   (),
  .m_axi_user_bready   ('d1                   ),

  .m_axi_user_arready  (),
  .m_axi_user_arid     ('d1                   ),
  .m_axi_user_araddr   ('d1                   ),
  .m_axi_user_aruser   ('d1                   ),
  .m_axi_user_arlen    ('d1                   ),
  .m_axi_user_arsize   ('d1                   ),
  .m_axi_user_arburst  ('d1                   ),
  .m_axi_user_arprot   ('d1                   ),
  .m_axi_user_arvalid  ('d1                   ),
  .m_axi_user_arlock   ('d1                   ),
  .m_axi_user_arcache  ('d1                   ),

  .m_axi_user_rid      (),
  .m_axi_user_rdata    (),
  .m_axi_user_rresp    (),
  .m_axi_user_rlast    (),
  .m_axi_user_rvalid   (),
  .m_axi_user_rready   ('d1                     ),

    .c0_sys_clk_p       (c0_sys_clk_p               ),
    .c0_sys_clk_n       (c0_sys_clk_n               ),
    .c0_ddr4_act_n      (c0_ddr4_act_n              ),
    .c0_ddr4_adr        (c0_ddr4_adr                ),
    .c0_ddr4_ba         (c0_ddr4_ba                 ),
    .c0_ddr4_bg         (c0_ddr4_bg                 ),
    .c0_ddr4_cke        (c0_ddr4_cke                ),
    .c0_ddr4_odt        (c0_ddr4_odt                ),
    .c0_ddr4_cs_n       (c0_ddr4_cs_n               ),
    .c0_ddr4_ck_t       (c0_ddr4_ck_t               ),
    .c0_ddr4_ck_c       (c0_ddr4_ck_c               ),
    .c0_ddr4_reset_n    (c0_ddr4_reset_n            ),
    .c0_ddr4_dm_dbi_n   (c0_ddr4_dm_dbi_n           ),
    .c0_ddr4_dq         (c0_ddr4_dq                 ),
    .c0_ddr4_dqs_c      (c0_ddr4_dqs_c              ),
    .c0_ddr4_dqs_t      (c0_ddr4_dqs_t              ),  

    .c1_sys_clk_p       (c1_sys_clk_p               ),
    .c1_sys_clk_n       (c1_sys_clk_n               ),
    .c1_ddr4_act_n      (c1_ddr4_act_n              ),
    .c1_ddr4_adr        (c1_ddr4_adr                ),
    .c1_ddr4_ba         (c1_ddr4_ba                 ),
    .c1_ddr4_bg         (c1_ddr4_bg                 ),
    .c1_ddr4_cke        (c1_ddr4_cke                ),
    .c1_ddr4_odt        (c1_ddr4_odt                ),
    .c1_ddr4_cs_n       (c1_ddr4_cs_n               ),
    .c1_ddr4_ck_t       (c1_ddr4_ck_t               ),
    .c1_ddr4_ck_c       (c1_ddr4_ck_c               ),
    .c1_ddr4_reset_n    (c1_ddr4_reset_n            ),
    .c1_ddr4_dm_dbi_n   (c1_ddr4_dm_dbi_n           ),
    .c1_ddr4_dq         (c1_ddr4_dq                 ),
    .c1_ddr4_dqs_c      (c1_ddr4_dqs_c              ),
    .c1_ddr4_dqs_t      (c1_ddr4_dqs_t              ),

    .c2_sys_clk_p       (c2_sys_clk_p               ),
    .c2_sys_clk_n       (c2_sys_clk_n               ),
    .c2_ddr4_act_n      (c2_ddr4_act_n              ),
    .c2_ddr4_adr        (c2_ddr4_adr                ),
    .c2_ddr4_ba         (c2_ddr4_ba                 ),
    .c2_ddr4_bg         (c2_ddr4_bg                 ),
    .c2_ddr4_cke        (c2_ddr4_cke                ),
    .c2_ddr4_odt        (c2_ddr4_odt                ),
    .c2_ddr4_cs_n       (c2_ddr4_cs_n               ),
    .c2_ddr4_ck_t       (c2_ddr4_ck_t               ),
    .c2_ddr4_ck_c       (c2_ddr4_ck_c               ),
    .c2_ddr4_reset_n    (c2_ddr4_reset_n            ),
    .c2_ddr4_dm_dbi_n   (c2_ddr4_dm_dbi_n           ),
    .c2_ddr4_dq         (c2_ddr4_dq                 ),    
    .c2_ddr4_dqs_c      (c2_ddr4_dqs_c              ),
    .c2_ddr4_dqs_t      (c2_ddr4_dqs_t              ),

    .c3_sys_clk_p       (c3_sys_clk_p               ),
    .c3_sys_clk_n       (c3_sys_clk_n               ),
    .c3_ddr4_act_n      (c3_ddr4_act_n              ),
    .c3_ddr4_adr        (c3_ddr4_adr                ),
    .c3_ddr4_ba         (c3_ddr4_ba                 ),
    .c3_ddr4_bg         (c3_ddr4_bg                 ),
    .c3_ddr4_cke        (c3_ddr4_cke                ),
    .c3_ddr4_odt        (c3_ddr4_odt                ),
    .c3_ddr4_cs_n       (c3_ddr4_cs_n               ),
    .c3_ddr4_ck_t       (c3_ddr4_ck_t               ),
    .c3_ddr4_ck_c       (c3_ddr4_ck_c               ),
    .c3_ddr4_reset_n    (c3_ddr4_reset_n            ),
    .c3_ddr4_dm_dbi_n   (c3_ddr4_dm_dbi_n           ),
    .c3_ddr4_dq         (c3_ddr4_dq                 ),
    .c3_ddr4_dqs_c      (c3_ddr4_dqs_c              ),
    .c3_ddr4_dqs_t      (c3_ddr4_dqs_t              )   
);


endmodule