//-----------------------------------------------------------------------------
// system_nf1_cml_interface_0_wrapper.v
//-----------------------------------------------------------------------------

module system_nf1_cml_interface_0_wrapper
  (
    glbl_rstn,
    gtx_clk,
    gtx_clk90,
    refclk,
    axi_aclk,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tuser,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    rgmii_txd,
    rgmii_tx_ctl,
    rgmii_txc,
    rgmii_rxd,
    rgmii_rx_ctl,
    rgmii_rxc,
    s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready
  );
  input glbl_rstn;
  input gtx_clk;
  input gtx_clk90;
  input refclk;
  input axi_aclk;
  output [255:0] m_axis_tdata;
  output [31:0] m_axis_tstrb;
  output [127:0] m_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output m_axis_tlast;
  input [255:0] s_axis_tdata;
  input [31:0] s_axis_tstrb;
  input [127:0] s_axis_tuser;
  input s_axis_tvalid;
  output s_axis_tready;
  input s_axis_tlast;
  output [3:0] rgmii_txd;
  output rgmii_tx_ctl;
  output rgmii_txc;
  input [3:0] rgmii_rxd;
  input rgmii_rx_ctl;
  input rgmii_rxc;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [31:0] s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0] s_axi_wdata;
  input s_axi_wvalid;
  output s_axi_wready;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [31:0] s_axi_araddr;
  input s_axi_arvalid;
  output s_axi_arready;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rvalid;
  input s_axi_rready;

  nf1_cml_interface
    #(
      .C_FAMILY ( "kintex7" ),
      .C_MAC_SEL ( 2 ),
      .C_INCLUDE_IDELAYCTRL ( 1 ),
      .C_M_AXIS_DATA_WIDTH ( 256 ),
      .C_S_AXIS_DATA_WIDTH ( 256 ),
      .C_M_AXIS_TUSER_WIDTH ( 128 ),
      .C_S_AXIS_TUSER_WIDTH ( 128 ),
      .C_DEFAULT_VALUE_ENABLE ( 1 ),
      .C_DEFAULT_SRC_PORT ( 8'h01 ),
      .C_DEFAULT_DST_PORT ( 8'h00 ),
      .C_S_AXI_ADDR_WIDTH ( 32 ),
      .C_S_AXI_DATA_WIDTH ( 32 ),
      .C_BASEADDR ( 32'h77e60000 ),
      .C_HIGHADDR ( 32'h77e6ffff ),
      .C_TX_VLAN_EN ( 0 ),
      .C_TX_FCS_EN ( 0 ),
      .C_TX_JUMBO_EN ( 0 ),
      .C_TX_FC_EN ( 0 ),
      .C_TX_HD_EN ( 0 ),
      .C_TX_IFG_ADJUST_EN ( 0 ),
      .C_TX_MAX_FRAME_EN ( 0 ),
      .C_TX_MAX_FRAME_SIZE ( 1518 ),
      .C_TX_PAUSE_MAC_ADDR ( 0 ),
      .C_TX_EN ( 1 ),
      .C_TX_RESET ( 0 ),
      .C_RX_VLAN_EN ( 0 ),
      .C_RX_FCS_EN ( 0 ),
      .C_RX_JUMBO_EN ( 0 ),
      .C_RX_FC_EN ( 0 ),
      .C_RX_HD_EN ( 0 ),
      .C_RX_PROMISCUOUS_EN ( 0 ),
      .C_RX_LEN_TYPE_CHK_DIS ( 0 ),
      .C_RX_CONTROL_LEN_CHK_DIS ( 0 ),
      .C_RX_MAX_FRAME_EN ( 0 ),
      .C_RX_MAX_FRAME_SIZE ( 1518 ),
      .C_RX_PAUSE_MAC_ADDR ( 0 ),
      .C_RX_EN ( 1 ),
      .C_RX_RESET ( 0 )
    )
    nf1_cml_interface_0 (
      .glbl_rstn ( glbl_rstn ),
      .gtx_clk ( gtx_clk ),
      .gtx_clk90 ( gtx_clk90 ),
      .refclk ( refclk ),
      .axi_aclk ( axi_aclk ),
      .m_axis_tdata ( m_axis_tdata ),
      .m_axis_tstrb ( m_axis_tstrb ),
      .m_axis_tuser ( m_axis_tuser ),
      .m_axis_tvalid ( m_axis_tvalid ),
      .m_axis_tready ( m_axis_tready ),
      .m_axis_tlast ( m_axis_tlast ),
      .s_axis_tdata ( s_axis_tdata ),
      .s_axis_tstrb ( s_axis_tstrb ),
      .s_axis_tuser ( s_axis_tuser ),
      .s_axis_tvalid ( s_axis_tvalid ),
      .s_axis_tready ( s_axis_tready ),
      .s_axis_tlast ( s_axis_tlast ),
      .rgmii_txd ( rgmii_txd ),
      .rgmii_tx_ctl ( rgmii_tx_ctl ),
      .rgmii_txc ( rgmii_txc ),
      .rgmii_rxd ( rgmii_rxd ),
      .rgmii_rx_ctl ( rgmii_rx_ctl ),
      .rgmii_rxc ( rgmii_rxc ),
      .s_axi_aclk ( s_axi_aclk ),
      .s_axi_aresetn ( s_axi_aresetn ),
      .s_axi_awaddr ( s_axi_awaddr ),
      .s_axi_awvalid ( s_axi_awvalid ),
      .s_axi_awready ( s_axi_awready ),
      .s_axi_wdata ( s_axi_wdata ),
      .s_axi_wvalid ( s_axi_wvalid ),
      .s_axi_wready ( s_axi_wready ),
      .s_axi_bresp ( s_axi_bresp ),
      .s_axi_bvalid ( s_axi_bvalid ),
      .s_axi_bready ( s_axi_bready ),
      .s_axi_araddr ( s_axi_araddr ),
      .s_axi_arvalid ( s_axi_arvalid ),
      .s_axi_arready ( s_axi_arready ),
      .s_axi_rdata ( s_axi_rdata ),
      .s_axi_rresp ( s_axi_rresp ),
      .s_axi_rvalid ( s_axi_rvalid ),
      .s_axi_rready ( s_axi_rready )
    );

endmodule

