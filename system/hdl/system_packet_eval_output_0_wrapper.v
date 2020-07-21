//-----------------------------------------------------------------------------
// system_packet_eval_output_0_wrapper.v
//-----------------------------------------------------------------------------

module system_packet_eval_output_0_wrapper
  (
    s_axi_aclk,
    s_axi_aresetn,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_rready,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_awready,
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
    s_axis_tlast
  );
  input s_axi_aclk;
  input s_axi_aresetn;
  input [31:0] s_axi_awaddr;
  input s_axi_awvalid;
  input [31:0] s_axi_wdata;
  input [3:0] s_axi_wstrb;
  input s_axi_wvalid;
  input s_axi_bready;
  input [31:0] s_axi_araddr;
  input s_axi_arvalid;
  input s_axi_rready;
  output s_axi_arready;
  output [31:0] s_axi_rdata;
  output [1:0] s_axi_rresp;
  output s_axi_rvalid;
  output s_axi_wready;
  output [1:0] s_axi_bresp;
  output s_axi_bvalid;
  output s_axi_awready;
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

  packet_eval_output
    #(
      .C_S_AXI_DATA_WIDTH ( 32 ),
      .C_S_AXI_ADDR_WIDTH ( 32 ),
      .C_BASEADDR ( 32'h70800000 ),
      .C_HIGHADDR ( 32'h7080ffff ),
      .C_S_AXI_ACLK_FREQ_HZ ( 100000000 ),
      .C_USE_WSTRB ( 0 ),
      .C_DPHASE_TIMEOUT ( 8 ),
      .C_M_AXIS_DATA_WIDTH ( 256 ),
      .C_S_AXIS_DATA_WIDTH ( 256 ),
      .C_M_AXIS_TUSER_WIDTH ( 128 ),
      .C_S_AXIS_TUSER_WIDTH ( 128 )
    )
    packet_eval_output_0 (
      .s_axi_aclk ( s_axi_aclk ),
      .s_axi_aresetn ( s_axi_aresetn ),
      .s_axi_awaddr ( s_axi_awaddr ),
      .s_axi_awvalid ( s_axi_awvalid ),
      .s_axi_wdata ( s_axi_wdata ),
      .s_axi_wstrb ( s_axi_wstrb ),
      .s_axi_wvalid ( s_axi_wvalid ),
      .s_axi_bready ( s_axi_bready ),
      .s_axi_araddr ( s_axi_araddr ),
      .s_axi_arvalid ( s_axi_arvalid ),
      .s_axi_rready ( s_axi_rready ),
      .s_axi_arready ( s_axi_arready ),
      .s_axi_rdata ( s_axi_rdata ),
      .s_axi_rresp ( s_axi_rresp ),
      .s_axi_rvalid ( s_axi_rvalid ),
      .s_axi_wready ( s_axi_wready ),
      .s_axi_bresp ( s_axi_bresp ),
      .s_axi_bvalid ( s_axi_bvalid ),
      .s_axi_awready ( s_axi_awready ),
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
      .s_axis_tlast ( s_axis_tlast )
    );

endmodule

