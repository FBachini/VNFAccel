//-----------------------------------------------------------------------------
// system.v
//-----------------------------------------------------------------------------

module system
  (
    uart_tx,
    uart_rx,
    reset_n,
    clk_in_p,
    clk_in_n,
    rgmii_tx_ctl_1,
    rgmii_txd_1,
    rgmii_rxd_1,
    rgmii_rxc_1,
    rgmii_rx_ctl_1,
    rgmii_txc_1,
    rgmii_tx_ctl_2,
    rgmii_txd_2,
    rgmii_rxd_2,
    rgmii_rxc_2,
    rgmii_rx_ctl_2,
    rgmii_txc_2,
    rgmii_tx_ctl_3,
    rgmii_txd_3,
    rgmii_rxd_3,
    rgmii_rxc_3,
    rgmii_rx_ctl_3,
    rgmii_txc_3,
    rgmii_txc_4,
    rgmii_txd_4,
    rgmii_rxd_4,
    rgmii_rxc_4,
    rgmii_rx_ctl_4,
    rgmii_tx_ctl_4,
    dma_0_pci_exp_1_txn_pin,
    dma_0_pci_exp_1_rxp_pin,
    dma_0_pci_exp_0_txp_pin,
    dma_0_pci_exp_0_txn_pin,
    dma_0_pci_exp_0_rxn_pin,
    dma_0_pci_exp_1_txp_pin,
    dma_0_pci_exp_1_rxn_pin,
    dma_0_pci_exp_2_txp_pin,
    dma_0_pci_exp_2_txn_pin,
    dma_0_pci_exp_2_rxp_pin,
    dma_0_pci_exp_2_rxn_pin,
    dma_0_pci_exp_3_txp_pin,
    dma_0_pci_exp_3_txn_pin,
    dma_0_pci_exp_3_rxp_pin,
    dma_0_pci_exp_3_rxn_pin,
    dma_0_pci_exp_0_rxp_pin,
    dma_0_pcie_clk_n_pin,
    dma_0_pcie_clk_p_pin,
    util_ds_buf_0_IBUF_DS_P_pin,
    mdc,
    mdio,
    phy_rstn,
    bpi_addr_cmd,
    bpi_data
  );
  output uart_tx;
  input uart_rx;
  input reset_n;
  input clk_in_p;
  input clk_in_n;
  output rgmii_tx_ctl_1;
  output [3:0] rgmii_txd_1;
  input [3:0] rgmii_rxd_1;
  input rgmii_rxc_1;
  input rgmii_rx_ctl_1;
  output rgmii_txc_1;
  output rgmii_tx_ctl_2;
  output [3:0] rgmii_txd_2;
  input [3:0] rgmii_rxd_2;
  input rgmii_rxc_2;
  input rgmii_rx_ctl_2;
  output rgmii_txc_2;
  output rgmii_tx_ctl_3;
  output [3:0] rgmii_txd_3;
  input [3:0] rgmii_rxd_3;
  input rgmii_rxc_3;
  input rgmii_rx_ctl_3;
  output rgmii_txc_3;
  output rgmii_txc_4;
  output [3:0] rgmii_txd_4;
  input [3:0] rgmii_rxd_4;
  input rgmii_rxc_4;
  input rgmii_rx_ctl_4;
  output rgmii_tx_ctl_4;
  output dma_0_pci_exp_1_txn_pin;
  input dma_0_pci_exp_1_rxp_pin;
  output dma_0_pci_exp_0_txp_pin;
  output dma_0_pci_exp_0_txn_pin;
  input dma_0_pci_exp_0_rxn_pin;
  output dma_0_pci_exp_1_txp_pin;
  input dma_0_pci_exp_1_rxn_pin;
  output dma_0_pci_exp_2_txp_pin;
  output dma_0_pci_exp_2_txn_pin;
  input dma_0_pci_exp_2_rxp_pin;
  input dma_0_pci_exp_2_rxn_pin;
  output dma_0_pci_exp_3_txp_pin;
  output dma_0_pci_exp_3_txn_pin;
  input dma_0_pci_exp_3_rxp_pin;
  input dma_0_pci_exp_3_rxn_pin;
  input dma_0_pci_exp_0_rxp_pin;
  input dma_0_pcie_clk_n_pin;
  input dma_0_pcie_clk_p_pin;
  input util_ds_buf_0_IBUF_DS_P_pin;
  output mdc;
  inout mdio;
  output [3:0] phy_rstn;
  inout [29:0] bpi_addr_cmd;
  inout [15:0] bpi_data;

  // Internal signals

  wire CLK;
  wire Ext_BRK;
  wire Ext_NM_BRK;
  wire RESET;
  wire RS232_Interrupt;
  wire RS232_Uart_1_sin;
  wire RS232_Uart_1_sout;
  wire [15:0] axi_gpio_0_GPIO2_IO_I;
  wire [15:0] axi_gpio_0_GPIO2_IO_O;
  wire [15:0] axi_gpio_0_GPIO2_IO_T;
  wire [29:0] axi_gpio_0_GPIO_IO_I;
  wire [29:0] axi_gpio_0_GPIO_IO_O;
  wire [29:0] axi_gpio_0_GPIO_IO_T;
  wire [511:0] axi_interconnect_0_M_ARADDR;
  wire [15:0] axi_interconnect_0_M_ARESETN;
  wire [15:0] axi_interconnect_0_M_ARREADY;
  wire [15:0] axi_interconnect_0_M_ARVALID;
  wire [511:0] axi_interconnect_0_M_AWADDR;
  wire [15:0] axi_interconnect_0_M_AWREADY;
  wire [15:0] axi_interconnect_0_M_AWVALID;
  wire [15:0] axi_interconnect_0_M_BREADY;
  wire [31:0] axi_interconnect_0_M_BRESP;
  wire [15:0] axi_interconnect_0_M_BVALID;
  wire [511:0] axi_interconnect_0_M_RDATA;
  wire [15:0] axi_interconnect_0_M_RREADY;
  wire [31:0] axi_interconnect_0_M_RRESP;
  wire [15:0] axi_interconnect_0_M_RVALID;
  wire [511:0] axi_interconnect_0_M_WDATA;
  wire [15:0] axi_interconnect_0_M_WREADY;
  wire [63:0] axi_interconnect_0_M_WSTRB;
  wire [15:0] axi_interconnect_0_M_WVALID;
  wire [63:0] axi_interconnect_0_S_ARADDR;
  wire [3:0] axi_interconnect_0_S_ARBURST;
  wire [7:0] axi_interconnect_0_S_ARCACHE;
  wire [1:0] axi_interconnect_0_S_ARESETN;
  wire [1:0] axi_interconnect_0_S_ARID;
  wire [15:0] axi_interconnect_0_S_ARLEN;
  wire [3:0] axi_interconnect_0_S_ARLOCK;
  wire [5:0] axi_interconnect_0_S_ARPROT;
  wire [7:0] axi_interconnect_0_S_ARQOS;
  wire [1:0] axi_interconnect_0_S_ARREADY;
  wire [5:0] axi_interconnect_0_S_ARSIZE;
  wire [1:0] axi_interconnect_0_S_ARVALID;
  wire [63:0] axi_interconnect_0_S_AWADDR;
  wire [3:0] axi_interconnect_0_S_AWBURST;
  wire [7:0] axi_interconnect_0_S_AWCACHE;
  wire [1:0] axi_interconnect_0_S_AWID;
  wire [15:0] axi_interconnect_0_S_AWLEN;
  wire [3:0] axi_interconnect_0_S_AWLOCK;
  wire [5:0] axi_interconnect_0_S_AWPROT;
  wire [7:0] axi_interconnect_0_S_AWQOS;
  wire [1:0] axi_interconnect_0_S_AWREADY;
  wire [5:0] axi_interconnect_0_S_AWSIZE;
  wire [1:0] axi_interconnect_0_S_AWVALID;
  wire [1:0] axi_interconnect_0_S_BID;
  wire [1:0] axi_interconnect_0_S_BREADY;
  wire [3:0] axi_interconnect_0_S_BRESP;
  wire [1:0] axi_interconnect_0_S_BVALID;
  wire [63:0] axi_interconnect_0_S_RDATA;
  wire [1:0] axi_interconnect_0_S_RID;
  wire [1:0] axi_interconnect_0_S_RLAST;
  wire [1:0] axi_interconnect_0_S_RREADY;
  wire [3:0] axi_interconnect_0_S_RRESP;
  wire [1:0] axi_interconnect_0_S_RVALID;
  wire [63:0] axi_interconnect_0_S_WDATA;
  wire [1:0] axi_interconnect_0_S_WLAST;
  wire [1:0] axi_interconnect_0_S_WREADY;
  wire [7:0] axi_interconnect_0_S_WSTRB;
  wire [1:0] axi_interconnect_0_S_WVALID;
  wire axi_timebase_wdt_0_Timebase_Interrupt;
  wire axi_timebase_wdt_0_WDT_Interrupt;
  wire clk_100_0000MHz;
  wire clk_125_0000MHz;
  wire clk_200_0000MHz;
  wire clk_gen_pre_lock;
  wire clock_generator_1_CLKOUT0;
  wire [255:0] dma_0_M_AXIS_TDATA;
  wire dma_0_M_AXIS_TLAST;
  wire dma_0_M_AXIS_TREADY;
  wire [31:0] dma_0_M_AXIS_TSTRB;
  wire [127:0] dma_0_M_AXIS_TUSER;
  wire dma_0_M_AXIS_TVALID;
  wire dma_0_pci_exp_0_rxn;
  wire dma_0_pci_exp_0_rxp;
  wire dma_0_pci_exp_0_txn;
  wire dma_0_pci_exp_0_txp;
  wire dma_0_pci_exp_1_rxn;
  wire dma_0_pci_exp_1_rxp;
  wire dma_0_pci_exp_1_txn;
  wire dma_0_pci_exp_1_txp;
  wire dma_0_pci_exp_2_rxn;
  wire dma_0_pci_exp_2_rxp;
  wire dma_0_pci_exp_2_txn;
  wire dma_0_pci_exp_2_txp;
  wire dma_0_pci_exp_3_rxn;
  wire dma_0_pci_exp_3_rxp;
  wire dma_0_pci_exp_3_txn;
  wire dma_0_pci_exp_3_txp;
  wire dma_0_pcie_clk_n;
  wire dma_0_pcie_clk_p;
  wire gtx_clk_125_0000MHz_90;
  wire gtx_clk_125_0000Mhz;
  wire [3:0] mdio_ctrl_0_phy_rstn;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din;
  wire [0:31] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN;
  wire microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst;
  wire [0:3] microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN;
  wire microblaze_0_debug_Dbg_Capture;
  wire microblaze_0_debug_Dbg_Clk;
  wire [0:7] microblaze_0_debug_Dbg_Reg_En;
  wire microblaze_0_debug_Dbg_Shift;
  wire microblaze_0_debug_Dbg_TDI;
  wire microblaze_0_debug_Dbg_TDO;
  wire microblaze_0_debug_Dbg_Update;
  wire microblaze_0_debug_Debug_Rst;
  wire [0:31] microblaze_0_dlmb_LMB_ABus;
  wire microblaze_0_dlmb_LMB_AddrStrobe;
  wire [0:3] microblaze_0_dlmb_LMB_BE;
  wire microblaze_0_dlmb_LMB_CE;
  wire [0:31] microblaze_0_dlmb_LMB_ReadDBus;
  wire microblaze_0_dlmb_LMB_ReadStrobe;
  wire microblaze_0_dlmb_LMB_Ready;
  wire microblaze_0_dlmb_LMB_Rst;
  wire microblaze_0_dlmb_LMB_UE;
  wire microblaze_0_dlmb_LMB_Wait;
  wire [0:31] microblaze_0_dlmb_LMB_WriteDBus;
  wire microblaze_0_dlmb_LMB_WriteStrobe;
  wire [0:31] microblaze_0_dlmb_M_ABus;
  wire microblaze_0_dlmb_M_AddrStrobe;
  wire [0:3] microblaze_0_dlmb_M_BE;
  wire [0:31] microblaze_0_dlmb_M_DBus;
  wire microblaze_0_dlmb_M_ReadStrobe;
  wire microblaze_0_dlmb_M_WriteStrobe;
  wire [0:0] microblaze_0_dlmb_Sl_CE;
  wire [0:31] microblaze_0_dlmb_Sl_DBus;
  wire [0:0] microblaze_0_dlmb_Sl_Ready;
  wire [0:0] microblaze_0_dlmb_Sl_UE;
  wire [0:0] microblaze_0_dlmb_Sl_Wait;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din;
  wire [0:31] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN;
  wire microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst;
  wire [0:3] microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN;
  wire [0:31] microblaze_0_ilmb_LMB_ABus;
  wire microblaze_0_ilmb_LMB_AddrStrobe;
  wire [0:3] microblaze_0_ilmb_LMB_BE;
  wire microblaze_0_ilmb_LMB_CE;
  wire [0:31] microblaze_0_ilmb_LMB_ReadDBus;
  wire microblaze_0_ilmb_LMB_ReadStrobe;
  wire microblaze_0_ilmb_LMB_Ready;
  wire microblaze_0_ilmb_LMB_Rst;
  wire microblaze_0_ilmb_LMB_UE;
  wire microblaze_0_ilmb_LMB_Wait;
  wire [0:31] microblaze_0_ilmb_LMB_WriteDBus;
  wire microblaze_0_ilmb_LMB_WriteStrobe;
  wire [0:31] microblaze_0_ilmb_M_ABus;
  wire microblaze_0_ilmb_M_AddrStrobe;
  wire microblaze_0_ilmb_M_ReadStrobe;
  wire [0:0] microblaze_0_ilmb_Sl_CE;
  wire [0:31] microblaze_0_ilmb_Sl_DBus;
  wire [0:0] microblaze_0_ilmb_Sl_Ready;
  wire [0:0] microblaze_0_ilmb_Sl_UE;
  wire [0:0] microblaze_0_ilmb_Sl_Wait;
  wire microblaze_0_interrupt_Interrupt;
  wire [1:0] microblaze_0_interrupt_Interrupt_Ack;
  wire [0:31] microblaze_0_interrupt_Interrupt_Address;
  wire net_gnd0;
  wire [0:0] net_gnd1;
  wire [1:0] net_gnd2;
  wire [0:2] net_gnd3;
  wire [0:3] net_gnd4;
  wire [15:0] net_gnd16;
  wire [31:0] net_gnd32;
  wire [0:4095] net_gnd4096;
  wire net_vcc0;
  wire [255:0] nf1_cml_interface_1_M_AXIS_TDATA;
  wire nf1_cml_interface_1_M_AXIS_TLAST;
  wire nf1_cml_interface_1_M_AXIS_TREADY;
  wire [31:0] nf1_cml_interface_1_M_AXIS_TSTRB;
  wire [127:0] nf1_cml_interface_1_M_AXIS_TUSER;
  wire nf1_cml_interface_1_M_AXIS_TVALID;
  wire nf1_cml_interface_1_rgmii_rx_ctl;
  wire nf1_cml_interface_1_rgmii_rxc;
  wire [3:0] nf1_cml_interface_1_rgmii_rxd;
  wire nf1_cml_interface_1_rgmii_tx_ctl;
  wire nf1_cml_interface_1_rgmii_txc;
  wire [3:0] nf1_cml_interface_1_rgmii_txd;
  wire [255:0] nf1_cml_interface_2_M_AXIS_TDATA;
  wire nf1_cml_interface_2_M_AXIS_TLAST;
  wire nf1_cml_interface_2_M_AXIS_TREADY;
  wire [31:0] nf1_cml_interface_2_M_AXIS_TSTRB;
  wire [127:0] nf1_cml_interface_2_M_AXIS_TUSER;
  wire nf1_cml_interface_2_M_AXIS_TVALID;
  wire nf1_cml_interface_2_rgmii_rx_ctl;
  wire nf1_cml_interface_2_rgmii_rxc;
  wire [3:0] nf1_cml_interface_2_rgmii_rxd;
  wire nf1_cml_interface_2_rgmii_tx_ctl;
  wire nf1_cml_interface_2_rgmii_txc;
  wire [3:0] nf1_cml_interface_2_rgmii_txd;
  wire [255:0] nf1_cml_interface_3_M_AXIS_TDATA;
  wire nf1_cml_interface_3_M_AXIS_TLAST;
  wire nf1_cml_interface_3_M_AXIS_TREADY;
  wire [31:0] nf1_cml_interface_3_M_AXIS_TSTRB;
  wire [127:0] nf1_cml_interface_3_M_AXIS_TUSER;
  wire nf1_cml_interface_3_M_AXIS_TVALID;
  wire nf1_cml_interface_3_rgmii_rx_ctl;
  wire nf1_cml_interface_3_rgmii_rxc;
  wire [3:0] nf1_cml_interface_3_rgmii_rxd;
  wire nf1_cml_interface_3_rgmii_tx_ctl;
  wire nf1_cml_interface_3_rgmii_txc;
  wire [3:0] nf1_cml_interface_3_rgmii_txd;
  wire [255:0] nf1_cml_interface_4_M_AXIS_TDATA;
  wire nf1_cml_interface_4_M_AXIS_TLAST;
  wire nf1_cml_interface_4_M_AXIS_TREADY;
  wire [31:0] nf1_cml_interface_4_M_AXIS_TSTRB;
  wire [127:0] nf1_cml_interface_4_M_AXIS_TUSER;
  wire nf1_cml_interface_4_M_AXIS_TVALID;
  wire nf1_cml_interface_4_rgmii_rx_ctl;
  wire nf1_cml_interface_4_rgmii_rxc;
  wire [3:0] nf1_cml_interface_4_rgmii_rxd;
  wire nf1_cml_interface_4_rgmii_tx_ctl;
  wire nf1_cml_interface_4_rgmii_txc;
  wire [3:0] nf1_cml_interface_4_rgmii_txd;
  wire [255:0] nf10_bram_output_queues_0_M_AXIS_0_TDATA;
  wire nf10_bram_output_queues_0_M_AXIS_0_TLAST;
  wire nf10_bram_output_queues_0_M_AXIS_0_TREADY;
  wire [31:0] nf10_bram_output_queues_0_M_AXIS_0_TSTRB;
  wire [127:0] nf10_bram_output_queues_0_M_AXIS_0_TUSER;
  wire nf10_bram_output_queues_0_M_AXIS_0_TVALID;
  wire [255:0] nf10_bram_output_queues_0_M_AXIS_1_TDATA;
  wire nf10_bram_output_queues_0_M_AXIS_1_TLAST;
  wire nf10_bram_output_queues_0_M_AXIS_1_TREADY;
  wire [31:0] nf10_bram_output_queues_0_M_AXIS_1_TSTRB;
  wire [127:0] nf10_bram_output_queues_0_M_AXIS_1_TUSER;
  wire nf10_bram_output_queues_0_M_AXIS_1_TVALID;
  wire [255:0] nf10_bram_output_queues_0_M_AXIS_2_TDATA;
  wire nf10_bram_output_queues_0_M_AXIS_2_TLAST;
  wire nf10_bram_output_queues_0_M_AXIS_2_TREADY;
  wire [31:0] nf10_bram_output_queues_0_M_AXIS_2_TSTRB;
  wire [127:0] nf10_bram_output_queues_0_M_AXIS_2_TUSER;
  wire nf10_bram_output_queues_0_M_AXIS_2_TVALID;
  wire [255:0] nf10_bram_output_queues_0_M_AXIS_3_TDATA;
  wire nf10_bram_output_queues_0_M_AXIS_3_TLAST;
  wire nf10_bram_output_queues_0_M_AXIS_3_TREADY;
  wire [31:0] nf10_bram_output_queues_0_M_AXIS_3_TSTRB;
  wire [127:0] nf10_bram_output_queues_0_M_AXIS_3_TUSER;
  wire nf10_bram_output_queues_0_M_AXIS_3_TVALID;
  wire [255:0] nf10_bram_output_queues_0_M_AXIS_4_TDATA;
  wire nf10_bram_output_queues_0_M_AXIS_4_TLAST;
  wire nf10_bram_output_queues_0_M_AXIS_4_TREADY;
  wire [31:0] nf10_bram_output_queues_0_M_AXIS_4_TSTRB;
  wire [127:0] nf10_bram_output_queues_0_M_AXIS_4_TUSER;
  wire nf10_bram_output_queues_0_M_AXIS_4_TVALID;
  wire [255:0] nf10_input_arbiter_0_M_AXIS_TDATA;
  wire nf10_input_arbiter_0_M_AXIS_TLAST;
  wire nf10_input_arbiter_0_M_AXIS_TREADY;
  wire [31:0] nf10_input_arbiter_0_M_AXIS_TSTRB;
  wire [127:0] nf10_input_arbiter_0_M_AXIS_TUSER;
  wire nf10_input_arbiter_0_M_AXIS_TVALID;
  wire [255:0] packet_eval_output_0_M_AXIS_TDATA;
  wire packet_eval_output_0_M_AXIS_TLAST;
  wire packet_eval_output_0_M_AXIS_TREADY;
  wire [31:0] packet_eval_output_0_M_AXIS_TSTRB;
  wire [127:0] packet_eval_output_0_M_AXIS_TUSER;
  wire packet_eval_output_0_M_AXIS_TVALID;
  wire [2:0] pgassign1;
  wire [1:0] pgassign2;
  wire [15:0] pgassign3;
  wire [0:0] proc_sys_reset_0_BUS_STRUCT_RESET;
  wire proc_sys_reset_0_Dcm_locked;
  wire [0:0] proc_sys_reset_0_Interconnect_aresetn;
  wire proc_sys_reset_0_MB_Debug_Sys_Rst;
  wire proc_sys_reset_0_MB_Reset;
  wire [0:0] proc_sys_reset_0_Peripheral_aresetn;

  // Internal assignments

  assign uart_tx = RS232_Uart_1_sout;
  assign RS232_Uart_1_sin = uart_rx;
  assign RESET = reset_n;
  assign rgmii_tx_ctl_1 = nf1_cml_interface_1_rgmii_tx_ctl;
  assign rgmii_txd_1 = nf1_cml_interface_1_rgmii_txd;
  assign nf1_cml_interface_1_rgmii_rxd = rgmii_rxd_1;
  assign nf1_cml_interface_1_rgmii_rxc = rgmii_rxc_1;
  assign nf1_cml_interface_1_rgmii_rx_ctl = rgmii_rx_ctl_1;
  assign rgmii_txc_1 = nf1_cml_interface_1_rgmii_txc;
  assign rgmii_tx_ctl_2 = nf1_cml_interface_2_rgmii_tx_ctl;
  assign rgmii_txd_2 = nf1_cml_interface_2_rgmii_txd;
  assign nf1_cml_interface_2_rgmii_rxd = rgmii_rxd_2;
  assign nf1_cml_interface_2_rgmii_rxc = rgmii_rxc_2;
  assign nf1_cml_interface_2_rgmii_rx_ctl = rgmii_rx_ctl_2;
  assign rgmii_txc_2 = nf1_cml_interface_2_rgmii_txc;
  assign rgmii_tx_ctl_3 = nf1_cml_interface_3_rgmii_tx_ctl;
  assign rgmii_txd_3 = nf1_cml_interface_3_rgmii_txd;
  assign nf1_cml_interface_3_rgmii_rxd = rgmii_rxd_3;
  assign nf1_cml_interface_3_rgmii_rxc = rgmii_rxc_3;
  assign nf1_cml_interface_3_rgmii_rx_ctl = rgmii_rx_ctl_3;
  assign rgmii_txc_3 = nf1_cml_interface_3_rgmii_txc;
  assign rgmii_txc_4 = nf1_cml_interface_4_rgmii_txc;
  assign rgmii_txd_4 = nf1_cml_interface_4_rgmii_txd;
  assign nf1_cml_interface_4_rgmii_rxd = rgmii_rxd_4;
  assign nf1_cml_interface_4_rgmii_rxc = rgmii_rxc_4;
  assign nf1_cml_interface_4_rgmii_rx_ctl = rgmii_rx_ctl_4;
  assign rgmii_tx_ctl_4 = nf1_cml_interface_4_rgmii_tx_ctl;
  assign dma_0_pci_exp_1_txn_pin = dma_0_pci_exp_1_txn;
  assign dma_0_pci_exp_1_rxp = dma_0_pci_exp_1_rxp_pin;
  assign dma_0_pci_exp_0_txp_pin = dma_0_pci_exp_0_txp;
  assign dma_0_pci_exp_0_txn_pin = dma_0_pci_exp_0_txn;
  assign dma_0_pci_exp_0_rxn = dma_0_pci_exp_0_rxn_pin;
  assign dma_0_pci_exp_1_txp_pin = dma_0_pci_exp_1_txp;
  assign dma_0_pci_exp_1_rxn = dma_0_pci_exp_1_rxn_pin;
  assign dma_0_pci_exp_2_txp_pin = dma_0_pci_exp_2_txp;
  assign dma_0_pci_exp_2_txn_pin = dma_0_pci_exp_2_txn;
  assign dma_0_pci_exp_2_rxp = dma_0_pci_exp_2_rxp_pin;
  assign dma_0_pci_exp_2_rxn = dma_0_pci_exp_2_rxn_pin;
  assign dma_0_pci_exp_3_txp_pin = dma_0_pci_exp_3_txp;
  assign dma_0_pci_exp_3_txn_pin = dma_0_pci_exp_3_txn;
  assign dma_0_pci_exp_3_rxp = dma_0_pci_exp_3_rxp_pin;
  assign dma_0_pci_exp_3_rxn = dma_0_pci_exp_3_rxn_pin;
  assign dma_0_pci_exp_0_rxp = dma_0_pci_exp_0_rxp_pin;
  assign dma_0_pcie_clk_n = dma_0_pcie_clk_n_pin;
  assign dma_0_pcie_clk_p = dma_0_pcie_clk_p_pin;
  assign phy_rstn = mdio_ctrl_0_phy_rstn;
  assign axi_interconnect_0_S_AWID[1:1] = 1'b0;
  assign axi_interconnect_0_S_AWLEN[15:8] = 8'b00000000;
  assign axi_interconnect_0_S_AWSIZE[5:3] = 3'b000;
  assign axi_interconnect_0_S_AWBURST[3:2] = 2'b00;
  assign axi_interconnect_0_S_AWLOCK[3:2] = 2'b00;
  assign axi_interconnect_0_S_AWCACHE[7:4] = 4'b0000;
  assign axi_interconnect_0_S_AWPROT[5:3] = 3'b000;
  assign axi_interconnect_0_S_AWQOS[7:4] = 4'b0000;
  assign axi_interconnect_0_S_WLAST[1:1] = 1'b0;
  assign axi_interconnect_0_S_ARID[1:1] = 1'b0;
  assign axi_interconnect_0_S_ARLEN[15:8] = 8'b00000000;
  assign axi_interconnect_0_S_ARSIZE[5:3] = 3'b000;
  assign axi_interconnect_0_S_ARBURST[3:2] = 2'b00;
  assign axi_interconnect_0_S_ARLOCK[3:2] = 2'b00;
  assign axi_interconnect_0_S_ARCACHE[7:4] = 4'b0000;
  assign axi_interconnect_0_S_ARPROT[5:3] = 3'b000;
  assign axi_interconnect_0_S_ARQOS[7:4] = 4'b0000;
  assign pgassign1[2] = axi_timebase_wdt_0_Timebase_Interrupt;
  assign pgassign1[1] = axi_timebase_wdt_0_WDT_Interrupt;
  assign pgassign1[0] = RS232_Interrupt;
  assign pgassign2[1] = clk_100_0000MHz;
  assign pgassign2[0] = clk_100_0000MHz;
  assign pgassign3[15] = clk_125_0000MHz;
  assign pgassign3[14] = clk_100_0000MHz;
  assign pgassign3[13] = clk_100_0000MHz;
  assign pgassign3[12] = clk_100_0000MHz;
  assign pgassign3[11] = clk_100_0000MHz;
  assign pgassign3[10] = clk_100_0000MHz;
  assign pgassign3[9] = clk_125_0000MHz;
  assign pgassign3[8] = clk_125_0000MHz;
  assign pgassign3[7] = clk_100_0000MHz;
  assign pgassign3[6] = clk_100_0000MHz;
  assign pgassign3[5] = clk_100_0000MHz;
  assign pgassign3[4] = clk_100_0000MHz;
  assign pgassign3[3] = clk_100_0000MHz;
  assign pgassign3[2] = clk_100_0000MHz;
  assign pgassign3[1] = clk_100_0000MHz;
  assign pgassign3[0] = clk_100_0000MHz;
  assign net_gnd0 = 1'b0;
  assign net_gnd1[0:0] = 1'b0;
  assign net_gnd16[15:0] = 16'b0000000000000000;
  assign net_gnd2[1:0] = 2'b00;
  assign net_gnd3[0:2] = 3'b000;
  assign net_gnd32[31:0] = 32'b00000000000000000000000000000000;
  assign net_gnd4[0:3] = 4'b0000;
  assign net_gnd4096[0:4095] = 4096'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  assign net_vcc0 = 1'b1;

  (* BOX_TYPE = "user_black_box" *)
  system_proc_sys_reset_0_wrapper
    proc_sys_reset_0 (
      .Slowest_sync_clk ( clk_100_0000MHz ),
      .Ext_Reset_In ( RESET ),
      .Aux_Reset_In ( net_gnd0 ),
      .MB_Debug_Sys_Rst ( proc_sys_reset_0_MB_Debug_Sys_Rst ),
      .Core_Reset_Req_0 ( net_gnd0 ),
      .Chip_Reset_Req_0 ( net_gnd0 ),
      .System_Reset_Req_0 ( net_gnd0 ),
      .Core_Reset_Req_1 ( net_gnd0 ),
      .Chip_Reset_Req_1 ( net_gnd0 ),
      .System_Reset_Req_1 ( net_gnd0 ),
      .Dcm_locked ( proc_sys_reset_0_Dcm_locked ),
      .RstcPPCresetcore_0 (  ),
      .RstcPPCresetchip_0 (  ),
      .RstcPPCresetsys_0 (  ),
      .RstcPPCresetcore_1 (  ),
      .RstcPPCresetchip_1 (  ),
      .RstcPPCresetsys_1 (  ),
      .MB_Reset ( proc_sys_reset_0_MB_Reset ),
      .Bus_Struct_Reset ( proc_sys_reset_0_BUS_STRUCT_RESET[0:0] ),
      .Peripheral_Reset (  ),
      .Interconnect_aresetn ( proc_sys_reset_0_Interconnect_aresetn[0:0] ),
      .Peripheral_aresetn ( proc_sys_reset_0_Peripheral_aresetn[0:0] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_intc_wrapper
    microblaze_0_intc (
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[0] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[8:0] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[0] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[0] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[31:0] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[3:0] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[0] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[0] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[1:0] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[0] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[0] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[8:0] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[0] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[0] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[31:0] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[1:0] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[0] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[0] ),
      .Intr ( pgassign1 ),
      .Irq ( microblaze_0_interrupt_Interrupt ),
      .Interrupt_address ( microblaze_0_interrupt_Interrupt_Address[0:31] ),
      .Processor_ack ( microblaze_0_interrupt_Interrupt_Ack ),
      .Processor_clk ( net_gnd0 ),
      .Processor_rst ( net_gnd0 ),
      .Interrupt_address_in ( net_gnd32 ),
      .Processor_ack_out (  )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_ilmb_wrapper
    microblaze_0_ilmb (
      .LMB_Clk ( clk_100_0000MHz ),
      .SYS_Rst ( proc_sys_reset_0_BUS_STRUCT_RESET[0] ),
      .LMB_Rst ( microblaze_0_ilmb_LMB_Rst ),
      .M_ABus ( microblaze_0_ilmb_M_ABus ),
      .M_ReadStrobe ( microblaze_0_ilmb_M_ReadStrobe ),
      .M_WriteStrobe ( net_gnd0 ),
      .M_AddrStrobe ( microblaze_0_ilmb_M_AddrStrobe ),
      .M_DBus ( net_gnd32[31:0] ),
      .M_BE ( net_gnd4 ),
      .Sl_DBus ( microblaze_0_ilmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_ilmb_Sl_Ready[0:0] ),
      .Sl_Wait ( microblaze_0_ilmb_Sl_Wait[0:0] ),
      .Sl_UE ( microblaze_0_ilmb_Sl_UE[0:0] ),
      .Sl_CE ( microblaze_0_ilmb_Sl_CE[0:0] ),
      .LMB_ABus ( microblaze_0_ilmb_LMB_ABus ),
      .LMB_ReadStrobe ( microblaze_0_ilmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_ilmb_LMB_WriteStrobe ),
      .LMB_AddrStrobe ( microblaze_0_ilmb_LMB_AddrStrobe ),
      .LMB_ReadDBus ( microblaze_0_ilmb_LMB_ReadDBus ),
      .LMB_WriteDBus ( microblaze_0_ilmb_LMB_WriteDBus ),
      .LMB_Ready ( microblaze_0_ilmb_LMB_Ready ),
      .LMB_Wait ( microblaze_0_ilmb_LMB_Wait ),
      .LMB_UE ( microblaze_0_ilmb_LMB_UE ),
      .LMB_CE ( microblaze_0_ilmb_LMB_CE ),
      .LMB_BE ( microblaze_0_ilmb_LMB_BE )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_i_bram_ctrl_wrapper
    microblaze_0_i_bram_ctrl (
      .LMB_Clk ( clk_100_0000MHz ),
      .LMB_Rst ( microblaze_0_ilmb_LMB_Rst ),
      .LMB_ABus ( microblaze_0_ilmb_LMB_ABus ),
      .LMB_WriteDBus ( microblaze_0_ilmb_LMB_WriteDBus ),
      .LMB_AddrStrobe ( microblaze_0_ilmb_LMB_AddrStrobe ),
      .LMB_ReadStrobe ( microblaze_0_ilmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_ilmb_LMB_WriteStrobe ),
      .LMB_BE ( microblaze_0_ilmb_LMB_BE ),
      .Sl_DBus ( microblaze_0_ilmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_ilmb_Sl_Ready[0] ),
      .Sl_Wait ( microblaze_0_ilmb_Sl_Wait[0] ),
      .Sl_UE ( microblaze_0_ilmb_Sl_UE[0] ),
      .Sl_CE ( microblaze_0_ilmb_Sl_CE[0] ),
      .LMB1_ABus ( net_gnd32[31:0] ),
      .LMB1_WriteDBus ( net_gnd32[31:0] ),
      .LMB1_AddrStrobe ( net_gnd0 ),
      .LMB1_ReadStrobe ( net_gnd0 ),
      .LMB1_WriteStrobe ( net_gnd0 ),
      .LMB1_BE ( net_gnd4 ),
      .Sl1_DBus (  ),
      .Sl1_Ready (  ),
      .Sl1_Wait (  ),
      .Sl1_UE (  ),
      .Sl1_CE (  ),
      .LMB2_ABus ( net_gnd32[31:0] ),
      .LMB2_WriteDBus ( net_gnd32[31:0] ),
      .LMB2_AddrStrobe ( net_gnd0 ),
      .LMB2_ReadStrobe ( net_gnd0 ),
      .LMB2_WriteStrobe ( net_gnd0 ),
      .LMB2_BE ( net_gnd4 ),
      .Sl2_DBus (  ),
      .Sl2_Ready (  ),
      .Sl2_Wait (  ),
      .Sl2_UE (  ),
      .Sl2_CE (  ),
      .LMB3_ABus ( net_gnd32[31:0] ),
      .LMB3_WriteDBus ( net_gnd32[31:0] ),
      .LMB3_AddrStrobe ( net_gnd0 ),
      .LMB3_ReadStrobe ( net_gnd0 ),
      .LMB3_WriteStrobe ( net_gnd0 ),
      .LMB3_BE ( net_gnd4 ),
      .Sl3_DBus (  ),
      .Sl3_Ready (  ),
      .Sl3_Wait (  ),
      .Sl3_UE (  ),
      .Sl3_CE (  ),
      .BRAM_Rst_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .Interrupt (  ),
      .UE (  ),
      .CE (  ),
      .SPLB_CTRL_PLB_ABus ( net_gnd32[31:0] ),
      .SPLB_CTRL_PLB_PAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_masterID ( net_gnd1[0:0] ),
      .SPLB_CTRL_PLB_RNW ( net_gnd0 ),
      .SPLB_CTRL_PLB_BE ( net_gnd4 ),
      .SPLB_CTRL_PLB_size ( net_gnd4 ),
      .SPLB_CTRL_PLB_type ( net_gnd3 ),
      .SPLB_CTRL_PLB_wrDBus ( net_gnd32[31:0] ),
      .SPLB_CTRL_Sl_addrAck (  ),
      .SPLB_CTRL_Sl_SSize (  ),
      .SPLB_CTRL_Sl_wait (  ),
      .SPLB_CTRL_Sl_rearbitrate (  ),
      .SPLB_CTRL_Sl_wrDAck (  ),
      .SPLB_CTRL_Sl_wrComp (  ),
      .SPLB_CTRL_Sl_rdDBus (  ),
      .SPLB_CTRL_Sl_rdDAck (  ),
      .SPLB_CTRL_Sl_rdComp (  ),
      .SPLB_CTRL_Sl_MBusy (  ),
      .SPLB_CTRL_Sl_MWrErr (  ),
      .SPLB_CTRL_Sl_MRdErr (  ),
      .SPLB_CTRL_PLB_UABus ( net_gnd32[31:0] ),
      .SPLB_CTRL_PLB_SAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_abort ( net_gnd0 ),
      .SPLB_CTRL_PLB_busLock ( net_gnd0 ),
      .SPLB_CTRL_PLB_MSize ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_lockErr ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_rdPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_reqPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_TAttribute ( net_gnd16[15:0] ),
      .SPLB_CTRL_Sl_wrBTerm (  ),
      .SPLB_CTRL_Sl_rdWdAddr (  ),
      .SPLB_CTRL_Sl_rdBTerm (  ),
      .SPLB_CTRL_Sl_MIRQ (  ),
      .S_AXI_CTRL_ACLK ( net_vcc0 ),
      .S_AXI_CTRL_ARESETN ( net_gnd0 ),
      .S_AXI_CTRL_AWADDR ( net_gnd32 ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32 ),
      .S_AXI_CTRL_WSTRB ( net_gnd4[0:3] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32 ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_dlmb_wrapper
    microblaze_0_dlmb (
      .LMB_Clk ( clk_100_0000MHz ),
      .SYS_Rst ( proc_sys_reset_0_BUS_STRUCT_RESET[0] ),
      .LMB_Rst ( microblaze_0_dlmb_LMB_Rst ),
      .M_ABus ( microblaze_0_dlmb_M_ABus ),
      .M_ReadStrobe ( microblaze_0_dlmb_M_ReadStrobe ),
      .M_WriteStrobe ( microblaze_0_dlmb_M_WriteStrobe ),
      .M_AddrStrobe ( microblaze_0_dlmb_M_AddrStrobe ),
      .M_DBus ( microblaze_0_dlmb_M_DBus ),
      .M_BE ( microblaze_0_dlmb_M_BE ),
      .Sl_DBus ( microblaze_0_dlmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_dlmb_Sl_Ready[0:0] ),
      .Sl_Wait ( microblaze_0_dlmb_Sl_Wait[0:0] ),
      .Sl_UE ( microblaze_0_dlmb_Sl_UE[0:0] ),
      .Sl_CE ( microblaze_0_dlmb_Sl_CE[0:0] ),
      .LMB_ABus ( microblaze_0_dlmb_LMB_ABus ),
      .LMB_ReadStrobe ( microblaze_0_dlmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_dlmb_LMB_WriteStrobe ),
      .LMB_AddrStrobe ( microblaze_0_dlmb_LMB_AddrStrobe ),
      .LMB_ReadDBus ( microblaze_0_dlmb_LMB_ReadDBus ),
      .LMB_WriteDBus ( microblaze_0_dlmb_LMB_WriteDBus ),
      .LMB_Ready ( microblaze_0_dlmb_LMB_Ready ),
      .LMB_Wait ( microblaze_0_dlmb_LMB_Wait ),
      .LMB_UE ( microblaze_0_dlmb_LMB_UE ),
      .LMB_CE ( microblaze_0_dlmb_LMB_CE ),
      .LMB_BE ( microblaze_0_dlmb_LMB_BE )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_d_bram_ctrl_wrapper
    microblaze_0_d_bram_ctrl (
      .LMB_Clk ( clk_100_0000MHz ),
      .LMB_Rst ( microblaze_0_dlmb_LMB_Rst ),
      .LMB_ABus ( microblaze_0_dlmb_LMB_ABus ),
      .LMB_WriteDBus ( microblaze_0_dlmb_LMB_WriteDBus ),
      .LMB_AddrStrobe ( microblaze_0_dlmb_LMB_AddrStrobe ),
      .LMB_ReadStrobe ( microblaze_0_dlmb_LMB_ReadStrobe ),
      .LMB_WriteStrobe ( microblaze_0_dlmb_LMB_WriteStrobe ),
      .LMB_BE ( microblaze_0_dlmb_LMB_BE ),
      .Sl_DBus ( microblaze_0_dlmb_Sl_DBus ),
      .Sl_Ready ( microblaze_0_dlmb_Sl_Ready[0] ),
      .Sl_Wait ( microblaze_0_dlmb_Sl_Wait[0] ),
      .Sl_UE ( microblaze_0_dlmb_Sl_UE[0] ),
      .Sl_CE ( microblaze_0_dlmb_Sl_CE[0] ),
      .LMB1_ABus ( net_gnd32[31:0] ),
      .LMB1_WriteDBus ( net_gnd32[31:0] ),
      .LMB1_AddrStrobe ( net_gnd0 ),
      .LMB1_ReadStrobe ( net_gnd0 ),
      .LMB1_WriteStrobe ( net_gnd0 ),
      .LMB1_BE ( net_gnd4 ),
      .Sl1_DBus (  ),
      .Sl1_Ready (  ),
      .Sl1_Wait (  ),
      .Sl1_UE (  ),
      .Sl1_CE (  ),
      .LMB2_ABus ( net_gnd32[31:0] ),
      .LMB2_WriteDBus ( net_gnd32[31:0] ),
      .LMB2_AddrStrobe ( net_gnd0 ),
      .LMB2_ReadStrobe ( net_gnd0 ),
      .LMB2_WriteStrobe ( net_gnd0 ),
      .LMB2_BE ( net_gnd4 ),
      .Sl2_DBus (  ),
      .Sl2_Ready (  ),
      .Sl2_Wait (  ),
      .Sl2_UE (  ),
      .Sl2_CE (  ),
      .LMB3_ABus ( net_gnd32[31:0] ),
      .LMB3_WriteDBus ( net_gnd32[31:0] ),
      .LMB3_AddrStrobe ( net_gnd0 ),
      .LMB3_ReadStrobe ( net_gnd0 ),
      .LMB3_WriteStrobe ( net_gnd0 ),
      .LMB3_BE ( net_gnd4 ),
      .Sl3_DBus (  ),
      .Sl3_Ready (  ),
      .Sl3_Wait (  ),
      .Sl3_UE (  ),
      .Sl3_CE (  ),
      .BRAM_Rst_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .Interrupt (  ),
      .UE (  ),
      .CE (  ),
      .SPLB_CTRL_PLB_ABus ( net_gnd32[31:0] ),
      .SPLB_CTRL_PLB_PAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_masterID ( net_gnd1[0:0] ),
      .SPLB_CTRL_PLB_RNW ( net_gnd0 ),
      .SPLB_CTRL_PLB_BE ( net_gnd4 ),
      .SPLB_CTRL_PLB_size ( net_gnd4 ),
      .SPLB_CTRL_PLB_type ( net_gnd3 ),
      .SPLB_CTRL_PLB_wrDBus ( net_gnd32[31:0] ),
      .SPLB_CTRL_Sl_addrAck (  ),
      .SPLB_CTRL_Sl_SSize (  ),
      .SPLB_CTRL_Sl_wait (  ),
      .SPLB_CTRL_Sl_rearbitrate (  ),
      .SPLB_CTRL_Sl_wrDAck (  ),
      .SPLB_CTRL_Sl_wrComp (  ),
      .SPLB_CTRL_Sl_rdDBus (  ),
      .SPLB_CTRL_Sl_rdDAck (  ),
      .SPLB_CTRL_Sl_rdComp (  ),
      .SPLB_CTRL_Sl_MBusy (  ),
      .SPLB_CTRL_Sl_MWrErr (  ),
      .SPLB_CTRL_Sl_MRdErr (  ),
      .SPLB_CTRL_PLB_UABus ( net_gnd32[31:0] ),
      .SPLB_CTRL_PLB_SAValid ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPrim ( net_gnd0 ),
      .SPLB_CTRL_PLB_abort ( net_gnd0 ),
      .SPLB_CTRL_PLB_busLock ( net_gnd0 ),
      .SPLB_CTRL_PLB_MSize ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_lockErr ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdBurst ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_rdPendReq ( net_gnd0 ),
      .SPLB_CTRL_PLB_wrPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_rdPendPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_reqPri ( net_gnd2[1:0] ),
      .SPLB_CTRL_PLB_TAttribute ( net_gnd16[15:0] ),
      .SPLB_CTRL_Sl_wrBTerm (  ),
      .SPLB_CTRL_Sl_rdWdAddr (  ),
      .SPLB_CTRL_Sl_rdBTerm (  ),
      .SPLB_CTRL_Sl_MIRQ (  ),
      .S_AXI_CTRL_ACLK ( net_vcc0 ),
      .S_AXI_CTRL_ARESETN ( net_gnd0 ),
      .S_AXI_CTRL_AWADDR ( net_gnd32 ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32 ),
      .S_AXI_CTRL_WSTRB ( net_gnd4[0:3] ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32 ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_bram_block_wrapper
    microblaze_0_bram_block (
      .BRAM_Rst_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_A ( microblaze_0_i_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout ),
      .BRAM_Rst_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Rst ),
      .BRAM_Clk_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Clk ),
      .BRAM_EN_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_EN ),
      .BRAM_WEN_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_WEN ),
      .BRAM_Addr_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Addr ),
      .BRAM_Din_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Din ),
      .BRAM_Dout_B ( microblaze_0_d_bram_ctrl_2_microblaze_0_bram_block_BRAM_Dout )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_microblaze_0_wrapper
    microblaze_0 (
      .CLK ( clk_100_0000MHz ),
      .RESET ( microblaze_0_dlmb_LMB_Rst ),
      .MB_RESET ( proc_sys_reset_0_MB_Reset ),
      .INTERRUPT ( microblaze_0_interrupt_Interrupt ),
      .INTERRUPT_ADDRESS ( microblaze_0_interrupt_Interrupt_Address ),
      .INTERRUPT_ACK ( microblaze_0_interrupt_Interrupt_Ack[1:0] ),
      .EXT_BRK ( Ext_BRK ),
      .EXT_NM_BRK ( Ext_NM_BRK ),
      .DBG_STOP ( net_gnd0 ),
      .MB_Halted (  ),
      .MB_Error (  ),
      .WAKEUP ( net_gnd2[1:0] ),
      .SLEEP (  ),
      .DBG_WAKEUP (  ),
      .LOCKSTEP_MASTER_OUT (  ),
      .LOCKSTEP_SLAVE_IN ( net_gnd4096 ),
      .LOCKSTEP_OUT (  ),
      .INSTR ( microblaze_0_ilmb_LMB_ReadDBus ),
      .IREADY ( microblaze_0_ilmb_LMB_Ready ),
      .IWAIT ( microblaze_0_ilmb_LMB_Wait ),
      .ICE ( microblaze_0_ilmb_LMB_CE ),
      .IUE ( microblaze_0_ilmb_LMB_UE ),
      .INSTR_ADDR ( microblaze_0_ilmb_M_ABus ),
      .IFETCH ( microblaze_0_ilmb_M_ReadStrobe ),
      .I_AS ( microblaze_0_ilmb_M_AddrStrobe ),
      .IPLB_M_ABort (  ),
      .IPLB_M_ABus (  ),
      .IPLB_M_UABus (  ),
      .IPLB_M_BE (  ),
      .IPLB_M_busLock (  ),
      .IPLB_M_lockErr (  ),
      .IPLB_M_MSize (  ),
      .IPLB_M_priority (  ),
      .IPLB_M_rdBurst (  ),
      .IPLB_M_request (  ),
      .IPLB_M_RNW (  ),
      .IPLB_M_size (  ),
      .IPLB_M_TAttribute (  ),
      .IPLB_M_type (  ),
      .IPLB_M_wrBurst (  ),
      .IPLB_M_wrDBus (  ),
      .IPLB_MBusy ( net_gnd0 ),
      .IPLB_MRdErr ( net_gnd0 ),
      .IPLB_MWrErr ( net_gnd0 ),
      .IPLB_MIRQ ( net_gnd0 ),
      .IPLB_MWrBTerm ( net_gnd0 ),
      .IPLB_MWrDAck ( net_gnd0 ),
      .IPLB_MAddrAck ( net_gnd0 ),
      .IPLB_MRdBTerm ( net_gnd0 ),
      .IPLB_MRdDAck ( net_gnd0 ),
      .IPLB_MRdDBus ( net_gnd32[31:0] ),
      .IPLB_MRdWdAddr ( net_gnd4 ),
      .IPLB_MRearbitrate ( net_gnd0 ),
      .IPLB_MSSize ( net_gnd2[1:0] ),
      .IPLB_MTimeout ( net_gnd0 ),
      .DATA_READ ( microblaze_0_dlmb_LMB_ReadDBus ),
      .DREADY ( microblaze_0_dlmb_LMB_Ready ),
      .DWAIT ( microblaze_0_dlmb_LMB_Wait ),
      .DCE ( microblaze_0_dlmb_LMB_CE ),
      .DUE ( microblaze_0_dlmb_LMB_UE ),
      .DATA_WRITE ( microblaze_0_dlmb_M_DBus ),
      .DATA_ADDR ( microblaze_0_dlmb_M_ABus ),
      .D_AS ( microblaze_0_dlmb_M_AddrStrobe ),
      .READ_STROBE ( microblaze_0_dlmb_M_ReadStrobe ),
      .WRITE_STROBE ( microblaze_0_dlmb_M_WriteStrobe ),
      .BYTE_ENABLE ( microblaze_0_dlmb_M_BE ),
      .DPLB_M_ABort (  ),
      .DPLB_M_ABus (  ),
      .DPLB_M_UABus (  ),
      .DPLB_M_BE (  ),
      .DPLB_M_busLock (  ),
      .DPLB_M_lockErr (  ),
      .DPLB_M_MSize (  ),
      .DPLB_M_priority (  ),
      .DPLB_M_rdBurst (  ),
      .DPLB_M_request (  ),
      .DPLB_M_RNW (  ),
      .DPLB_M_size (  ),
      .DPLB_M_TAttribute (  ),
      .DPLB_M_type (  ),
      .DPLB_M_wrBurst (  ),
      .DPLB_M_wrDBus (  ),
      .DPLB_MBusy ( net_gnd0 ),
      .DPLB_MRdErr ( net_gnd0 ),
      .DPLB_MWrErr ( net_gnd0 ),
      .DPLB_MIRQ ( net_gnd0 ),
      .DPLB_MWrBTerm ( net_gnd0 ),
      .DPLB_MWrDAck ( net_gnd0 ),
      .DPLB_MAddrAck ( net_gnd0 ),
      .DPLB_MRdBTerm ( net_gnd0 ),
      .DPLB_MRdDAck ( net_gnd0 ),
      .DPLB_MRdDBus ( net_gnd32[31:0] ),
      .DPLB_MRdWdAddr ( net_gnd4 ),
      .DPLB_MRearbitrate ( net_gnd0 ),
      .DPLB_MSSize ( net_gnd2[1:0] ),
      .DPLB_MTimeout ( net_gnd0 ),
      .M_AXI_IP_AWID (  ),
      .M_AXI_IP_AWADDR (  ),
      .M_AXI_IP_AWLEN (  ),
      .M_AXI_IP_AWSIZE (  ),
      .M_AXI_IP_AWBURST (  ),
      .M_AXI_IP_AWLOCK (  ),
      .M_AXI_IP_AWCACHE (  ),
      .M_AXI_IP_AWPROT (  ),
      .M_AXI_IP_AWQOS (  ),
      .M_AXI_IP_AWVALID (  ),
      .M_AXI_IP_AWREADY ( net_gnd0 ),
      .M_AXI_IP_WDATA (  ),
      .M_AXI_IP_WSTRB (  ),
      .M_AXI_IP_WLAST (  ),
      .M_AXI_IP_WVALID (  ),
      .M_AXI_IP_WREADY ( net_gnd0 ),
      .M_AXI_IP_BID ( net_gnd1[0:0] ),
      .M_AXI_IP_BRESP ( net_gnd2 ),
      .M_AXI_IP_BVALID ( net_gnd0 ),
      .M_AXI_IP_BREADY (  ),
      .M_AXI_IP_ARID (  ),
      .M_AXI_IP_ARADDR (  ),
      .M_AXI_IP_ARLEN (  ),
      .M_AXI_IP_ARSIZE (  ),
      .M_AXI_IP_ARBURST (  ),
      .M_AXI_IP_ARLOCK (  ),
      .M_AXI_IP_ARCACHE (  ),
      .M_AXI_IP_ARPROT (  ),
      .M_AXI_IP_ARQOS (  ),
      .M_AXI_IP_ARVALID (  ),
      .M_AXI_IP_ARREADY ( net_gnd0 ),
      .M_AXI_IP_RID ( net_gnd1[0:0] ),
      .M_AXI_IP_RDATA ( net_gnd32 ),
      .M_AXI_IP_RRESP ( net_gnd2 ),
      .M_AXI_IP_RLAST ( net_gnd0 ),
      .M_AXI_IP_RVALID ( net_gnd0 ),
      .M_AXI_IP_RREADY (  ),
      .M_AXI_DP_AWID ( axi_interconnect_0_S_AWID[0:0] ),
      .M_AXI_DP_AWADDR ( axi_interconnect_0_S_AWADDR[31:0] ),
      .M_AXI_DP_AWLEN ( axi_interconnect_0_S_AWLEN[7:0] ),
      .M_AXI_DP_AWSIZE ( axi_interconnect_0_S_AWSIZE[2:0] ),
      .M_AXI_DP_AWBURST ( axi_interconnect_0_S_AWBURST[1:0] ),
      .M_AXI_DP_AWLOCK ( axi_interconnect_0_S_AWLOCK[0] ),
      .M_AXI_DP_AWCACHE ( axi_interconnect_0_S_AWCACHE[3:0] ),
      .M_AXI_DP_AWPROT ( axi_interconnect_0_S_AWPROT[2:0] ),
      .M_AXI_DP_AWQOS ( axi_interconnect_0_S_AWQOS[3:0] ),
      .M_AXI_DP_AWVALID ( axi_interconnect_0_S_AWVALID[0] ),
      .M_AXI_DP_AWREADY ( axi_interconnect_0_S_AWREADY[0] ),
      .M_AXI_DP_WDATA ( axi_interconnect_0_S_WDATA[31:0] ),
      .M_AXI_DP_WSTRB ( axi_interconnect_0_S_WSTRB[3:0] ),
      .M_AXI_DP_WLAST ( axi_interconnect_0_S_WLAST[0] ),
      .M_AXI_DP_WVALID ( axi_interconnect_0_S_WVALID[0] ),
      .M_AXI_DP_WREADY ( axi_interconnect_0_S_WREADY[0] ),
      .M_AXI_DP_BID ( axi_interconnect_0_S_BID[0:0] ),
      .M_AXI_DP_BRESP ( axi_interconnect_0_S_BRESP[1:0] ),
      .M_AXI_DP_BVALID ( axi_interconnect_0_S_BVALID[0] ),
      .M_AXI_DP_BREADY ( axi_interconnect_0_S_BREADY[0] ),
      .M_AXI_DP_ARID ( axi_interconnect_0_S_ARID[0:0] ),
      .M_AXI_DP_ARADDR ( axi_interconnect_0_S_ARADDR[31:0] ),
      .M_AXI_DP_ARLEN ( axi_interconnect_0_S_ARLEN[7:0] ),
      .M_AXI_DP_ARSIZE ( axi_interconnect_0_S_ARSIZE[2:0] ),
      .M_AXI_DP_ARBURST ( axi_interconnect_0_S_ARBURST[1:0] ),
      .M_AXI_DP_ARLOCK ( axi_interconnect_0_S_ARLOCK[0] ),
      .M_AXI_DP_ARCACHE ( axi_interconnect_0_S_ARCACHE[3:0] ),
      .M_AXI_DP_ARPROT ( axi_interconnect_0_S_ARPROT[2:0] ),
      .M_AXI_DP_ARQOS ( axi_interconnect_0_S_ARQOS[3:0] ),
      .M_AXI_DP_ARVALID ( axi_interconnect_0_S_ARVALID[0] ),
      .M_AXI_DP_ARREADY ( axi_interconnect_0_S_ARREADY[0] ),
      .M_AXI_DP_RID ( axi_interconnect_0_S_RID[0:0] ),
      .M_AXI_DP_RDATA ( axi_interconnect_0_S_RDATA[31:0] ),
      .M_AXI_DP_RRESP ( axi_interconnect_0_S_RRESP[1:0] ),
      .M_AXI_DP_RLAST ( axi_interconnect_0_S_RLAST[0] ),
      .M_AXI_DP_RVALID ( axi_interconnect_0_S_RVALID[0] ),
      .M_AXI_DP_RREADY ( axi_interconnect_0_S_RREADY[0] ),
      .M_AXI_IC_AWID (  ),
      .M_AXI_IC_AWADDR (  ),
      .M_AXI_IC_AWLEN (  ),
      .M_AXI_IC_AWSIZE (  ),
      .M_AXI_IC_AWBURST (  ),
      .M_AXI_IC_AWLOCK (  ),
      .M_AXI_IC_AWCACHE (  ),
      .M_AXI_IC_AWPROT (  ),
      .M_AXI_IC_AWQOS (  ),
      .M_AXI_IC_AWVALID (  ),
      .M_AXI_IC_AWREADY ( net_gnd0 ),
      .M_AXI_IC_AWUSER (  ),
      .M_AXI_IC_AWDOMAIN (  ),
      .M_AXI_IC_AWSNOOP (  ),
      .M_AXI_IC_AWBAR (  ),
      .M_AXI_IC_WDATA (  ),
      .M_AXI_IC_WSTRB (  ),
      .M_AXI_IC_WLAST (  ),
      .M_AXI_IC_WVALID (  ),
      .M_AXI_IC_WREADY ( net_gnd0 ),
      .M_AXI_IC_WUSER (  ),
      .M_AXI_IC_BID ( net_gnd1[0:0] ),
      .M_AXI_IC_BRESP ( net_gnd2 ),
      .M_AXI_IC_BVALID ( net_gnd0 ),
      .M_AXI_IC_BREADY (  ),
      .M_AXI_IC_BUSER ( net_gnd1[0:0] ),
      .M_AXI_IC_WACK (  ),
      .M_AXI_IC_ARID (  ),
      .M_AXI_IC_ARADDR (  ),
      .M_AXI_IC_ARLEN (  ),
      .M_AXI_IC_ARSIZE (  ),
      .M_AXI_IC_ARBURST (  ),
      .M_AXI_IC_ARLOCK (  ),
      .M_AXI_IC_ARCACHE (  ),
      .M_AXI_IC_ARPROT (  ),
      .M_AXI_IC_ARQOS (  ),
      .M_AXI_IC_ARVALID (  ),
      .M_AXI_IC_ARREADY ( net_gnd0 ),
      .M_AXI_IC_ARUSER (  ),
      .M_AXI_IC_ARDOMAIN (  ),
      .M_AXI_IC_ARSNOOP (  ),
      .M_AXI_IC_ARBAR (  ),
      .M_AXI_IC_RID ( net_gnd1[0:0] ),
      .M_AXI_IC_RDATA ( net_gnd32 ),
      .M_AXI_IC_RRESP ( net_gnd2 ),
      .M_AXI_IC_RLAST ( net_gnd0 ),
      .M_AXI_IC_RVALID ( net_gnd0 ),
      .M_AXI_IC_RREADY (  ),
      .M_AXI_IC_RUSER ( net_gnd1[0:0] ),
      .M_AXI_IC_RACK (  ),
      .M_AXI_IC_ACVALID ( net_gnd0 ),
      .M_AXI_IC_ACADDR ( net_gnd32 ),
      .M_AXI_IC_ACSNOOP ( net_gnd4[0:3] ),
      .M_AXI_IC_ACPROT ( net_gnd3[0:2] ),
      .M_AXI_IC_ACREADY (  ),
      .M_AXI_IC_CRREADY ( net_gnd0 ),
      .M_AXI_IC_CRVALID (  ),
      .M_AXI_IC_CRRESP (  ),
      .M_AXI_IC_CDVALID (  ),
      .M_AXI_IC_CDREADY ( net_gnd0 ),
      .M_AXI_IC_CDDATA (  ),
      .M_AXI_IC_CDLAST (  ),
      .M_AXI_DC_AWID (  ),
      .M_AXI_DC_AWADDR (  ),
      .M_AXI_DC_AWLEN (  ),
      .M_AXI_DC_AWSIZE (  ),
      .M_AXI_DC_AWBURST (  ),
      .M_AXI_DC_AWLOCK (  ),
      .M_AXI_DC_AWCACHE (  ),
      .M_AXI_DC_AWPROT (  ),
      .M_AXI_DC_AWQOS (  ),
      .M_AXI_DC_AWVALID (  ),
      .M_AXI_DC_AWREADY ( net_gnd0 ),
      .M_AXI_DC_AWUSER (  ),
      .M_AXI_DC_AWDOMAIN (  ),
      .M_AXI_DC_AWSNOOP (  ),
      .M_AXI_DC_AWBAR (  ),
      .M_AXI_DC_WDATA (  ),
      .M_AXI_DC_WSTRB (  ),
      .M_AXI_DC_WLAST (  ),
      .M_AXI_DC_WVALID (  ),
      .M_AXI_DC_WREADY ( net_gnd0 ),
      .M_AXI_DC_WUSER (  ),
      .M_AXI_DC_BID ( net_gnd1[0:0] ),
      .M_AXI_DC_BRESP ( net_gnd2 ),
      .M_AXI_DC_BVALID ( net_gnd0 ),
      .M_AXI_DC_BREADY (  ),
      .M_AXI_DC_BUSER ( net_gnd1[0:0] ),
      .M_AXI_DC_WACK (  ),
      .M_AXI_DC_ARID (  ),
      .M_AXI_DC_ARADDR (  ),
      .M_AXI_DC_ARLEN (  ),
      .M_AXI_DC_ARSIZE (  ),
      .M_AXI_DC_ARBURST (  ),
      .M_AXI_DC_ARLOCK (  ),
      .M_AXI_DC_ARCACHE (  ),
      .M_AXI_DC_ARPROT (  ),
      .M_AXI_DC_ARQOS (  ),
      .M_AXI_DC_ARVALID (  ),
      .M_AXI_DC_ARREADY ( net_gnd0 ),
      .M_AXI_DC_ARUSER (  ),
      .M_AXI_DC_ARDOMAIN (  ),
      .M_AXI_DC_ARSNOOP (  ),
      .M_AXI_DC_ARBAR (  ),
      .M_AXI_DC_RID ( net_gnd1[0:0] ),
      .M_AXI_DC_RDATA ( net_gnd32 ),
      .M_AXI_DC_RRESP ( net_gnd2 ),
      .M_AXI_DC_RLAST ( net_gnd0 ),
      .M_AXI_DC_RVALID ( net_gnd0 ),
      .M_AXI_DC_RREADY (  ),
      .M_AXI_DC_RUSER ( net_gnd1[0:0] ),
      .M_AXI_DC_RACK (  ),
      .M_AXI_DC_ACVALID ( net_gnd0 ),
      .M_AXI_DC_ACADDR ( net_gnd32 ),
      .M_AXI_DC_ACSNOOP ( net_gnd4[0:3] ),
      .M_AXI_DC_ACPROT ( net_gnd3[0:2] ),
      .M_AXI_DC_ACREADY (  ),
      .M_AXI_DC_CRREADY ( net_gnd0 ),
      .M_AXI_DC_CRVALID (  ),
      .M_AXI_DC_CRRESP (  ),
      .M_AXI_DC_CDVALID (  ),
      .M_AXI_DC_CDREADY ( net_gnd0 ),
      .M_AXI_DC_CDDATA (  ),
      .M_AXI_DC_CDLAST (  ),
      .DBG_CLK ( microblaze_0_debug_Dbg_Clk ),
      .DBG_TDI ( microblaze_0_debug_Dbg_TDI ),
      .DBG_TDO ( microblaze_0_debug_Dbg_TDO ),
      .DBG_REG_EN ( microblaze_0_debug_Dbg_Reg_En ),
      .DBG_SHIFT ( microblaze_0_debug_Dbg_Shift ),
      .DBG_CAPTURE ( microblaze_0_debug_Dbg_Capture ),
      .DBG_UPDATE ( microblaze_0_debug_Dbg_Update ),
      .DEBUG_RST ( microblaze_0_debug_Debug_Rst ),
      .Trace_Instruction (  ),
      .Trace_Valid_Instr (  ),
      .Trace_PC (  ),
      .Trace_Reg_Write (  ),
      .Trace_Reg_Addr (  ),
      .Trace_MSR_Reg (  ),
      .Trace_PID_Reg (  ),
      .Trace_New_Reg_Value (  ),
      .Trace_Exception_Taken (  ),
      .Trace_Exception_Kind (  ),
      .Trace_Jump_Taken (  ),
      .Trace_Delay_Slot (  ),
      .Trace_Data_Address (  ),
      .Trace_Data_Access (  ),
      .Trace_Data_Read (  ),
      .Trace_Data_Write (  ),
      .Trace_Data_Write_Value (  ),
      .Trace_Data_Byte_Enable (  ),
      .Trace_DCache_Req (  ),
      .Trace_DCache_Hit (  ),
      .Trace_DCache_Rdy (  ),
      .Trace_DCache_Read (  ),
      .Trace_ICache_Req (  ),
      .Trace_ICache_Hit (  ),
      .Trace_ICache_Rdy (  ),
      .Trace_OF_PipeRun (  ),
      .Trace_EX_PipeRun (  ),
      .Trace_MEM_PipeRun (  ),
      .Trace_MB_Halted (  ),
      .Trace_Jump_Hit (  ),
      .FSL0_S_CLK (  ),
      .FSL0_S_READ (  ),
      .FSL0_S_DATA ( net_gnd32[31:0] ),
      .FSL0_S_CONTROL ( net_gnd0 ),
      .FSL0_S_EXISTS ( net_gnd0 ),
      .FSL0_M_CLK (  ),
      .FSL0_M_WRITE (  ),
      .FSL0_M_DATA (  ),
      .FSL0_M_CONTROL (  ),
      .FSL0_M_FULL ( net_gnd0 ),
      .FSL1_S_CLK (  ),
      .FSL1_S_READ (  ),
      .FSL1_S_DATA ( net_gnd32[31:0] ),
      .FSL1_S_CONTROL ( net_gnd0 ),
      .FSL1_S_EXISTS ( net_gnd0 ),
      .FSL1_M_CLK (  ),
      .FSL1_M_WRITE (  ),
      .FSL1_M_DATA (  ),
      .FSL1_M_CONTROL (  ),
      .FSL1_M_FULL ( net_gnd0 ),
      .FSL2_S_CLK (  ),
      .FSL2_S_READ (  ),
      .FSL2_S_DATA ( net_gnd32[31:0] ),
      .FSL2_S_CONTROL ( net_gnd0 ),
      .FSL2_S_EXISTS ( net_gnd0 ),
      .FSL2_M_CLK (  ),
      .FSL2_M_WRITE (  ),
      .FSL2_M_DATA (  ),
      .FSL2_M_CONTROL (  ),
      .FSL2_M_FULL ( net_gnd0 ),
      .FSL3_S_CLK (  ),
      .FSL3_S_READ (  ),
      .FSL3_S_DATA ( net_gnd32[31:0] ),
      .FSL3_S_CONTROL ( net_gnd0 ),
      .FSL3_S_EXISTS ( net_gnd0 ),
      .FSL3_M_CLK (  ),
      .FSL3_M_WRITE (  ),
      .FSL3_M_DATA (  ),
      .FSL3_M_CONTROL (  ),
      .FSL3_M_FULL ( net_gnd0 ),
      .FSL4_S_CLK (  ),
      .FSL4_S_READ (  ),
      .FSL4_S_DATA ( net_gnd32[31:0] ),
      .FSL4_S_CONTROL ( net_gnd0 ),
      .FSL4_S_EXISTS ( net_gnd0 ),
      .FSL4_M_CLK (  ),
      .FSL4_M_WRITE (  ),
      .FSL4_M_DATA (  ),
      .FSL4_M_CONTROL (  ),
      .FSL4_M_FULL ( net_gnd0 ),
      .FSL5_S_CLK (  ),
      .FSL5_S_READ (  ),
      .FSL5_S_DATA ( net_gnd32[31:0] ),
      .FSL5_S_CONTROL ( net_gnd0 ),
      .FSL5_S_EXISTS ( net_gnd0 ),
      .FSL5_M_CLK (  ),
      .FSL5_M_WRITE (  ),
      .FSL5_M_DATA (  ),
      .FSL5_M_CONTROL (  ),
      .FSL5_M_FULL ( net_gnd0 ),
      .FSL6_S_CLK (  ),
      .FSL6_S_READ (  ),
      .FSL6_S_DATA ( net_gnd32[31:0] ),
      .FSL6_S_CONTROL ( net_gnd0 ),
      .FSL6_S_EXISTS ( net_gnd0 ),
      .FSL6_M_CLK (  ),
      .FSL6_M_WRITE (  ),
      .FSL6_M_DATA (  ),
      .FSL6_M_CONTROL (  ),
      .FSL6_M_FULL ( net_gnd0 ),
      .FSL7_S_CLK (  ),
      .FSL7_S_READ (  ),
      .FSL7_S_DATA ( net_gnd32[31:0] ),
      .FSL7_S_CONTROL ( net_gnd0 ),
      .FSL7_S_EXISTS ( net_gnd0 ),
      .FSL7_M_CLK (  ),
      .FSL7_M_WRITE (  ),
      .FSL7_M_DATA (  ),
      .FSL7_M_CONTROL (  ),
      .FSL7_M_FULL ( net_gnd0 ),
      .FSL8_S_CLK (  ),
      .FSL8_S_READ (  ),
      .FSL8_S_DATA ( net_gnd32[31:0] ),
      .FSL8_S_CONTROL ( net_gnd0 ),
      .FSL8_S_EXISTS ( net_gnd0 ),
      .FSL8_M_CLK (  ),
      .FSL8_M_WRITE (  ),
      .FSL8_M_DATA (  ),
      .FSL8_M_CONTROL (  ),
      .FSL8_M_FULL ( net_gnd0 ),
      .FSL9_S_CLK (  ),
      .FSL9_S_READ (  ),
      .FSL9_S_DATA ( net_gnd32[31:0] ),
      .FSL9_S_CONTROL ( net_gnd0 ),
      .FSL9_S_EXISTS ( net_gnd0 ),
      .FSL9_M_CLK (  ),
      .FSL9_M_WRITE (  ),
      .FSL9_M_DATA (  ),
      .FSL9_M_CONTROL (  ),
      .FSL9_M_FULL ( net_gnd0 ),
      .FSL10_S_CLK (  ),
      .FSL10_S_READ (  ),
      .FSL10_S_DATA ( net_gnd32[31:0] ),
      .FSL10_S_CONTROL ( net_gnd0 ),
      .FSL10_S_EXISTS ( net_gnd0 ),
      .FSL10_M_CLK (  ),
      .FSL10_M_WRITE (  ),
      .FSL10_M_DATA (  ),
      .FSL10_M_CONTROL (  ),
      .FSL10_M_FULL ( net_gnd0 ),
      .FSL11_S_CLK (  ),
      .FSL11_S_READ (  ),
      .FSL11_S_DATA ( net_gnd32[31:0] ),
      .FSL11_S_CONTROL ( net_gnd0 ),
      .FSL11_S_EXISTS ( net_gnd0 ),
      .FSL11_M_CLK (  ),
      .FSL11_M_WRITE (  ),
      .FSL11_M_DATA (  ),
      .FSL11_M_CONTROL (  ),
      .FSL11_M_FULL ( net_gnd0 ),
      .FSL12_S_CLK (  ),
      .FSL12_S_READ (  ),
      .FSL12_S_DATA ( net_gnd32[31:0] ),
      .FSL12_S_CONTROL ( net_gnd0 ),
      .FSL12_S_EXISTS ( net_gnd0 ),
      .FSL12_M_CLK (  ),
      .FSL12_M_WRITE (  ),
      .FSL12_M_DATA (  ),
      .FSL12_M_CONTROL (  ),
      .FSL12_M_FULL ( net_gnd0 ),
      .FSL13_S_CLK (  ),
      .FSL13_S_READ (  ),
      .FSL13_S_DATA ( net_gnd32[31:0] ),
      .FSL13_S_CONTROL ( net_gnd0 ),
      .FSL13_S_EXISTS ( net_gnd0 ),
      .FSL13_M_CLK (  ),
      .FSL13_M_WRITE (  ),
      .FSL13_M_DATA (  ),
      .FSL13_M_CONTROL (  ),
      .FSL13_M_FULL ( net_gnd0 ),
      .FSL14_S_CLK (  ),
      .FSL14_S_READ (  ),
      .FSL14_S_DATA ( net_gnd32[31:0] ),
      .FSL14_S_CONTROL ( net_gnd0 ),
      .FSL14_S_EXISTS ( net_gnd0 ),
      .FSL14_M_CLK (  ),
      .FSL14_M_WRITE (  ),
      .FSL14_M_DATA (  ),
      .FSL14_M_CONTROL (  ),
      .FSL14_M_FULL ( net_gnd0 ),
      .FSL15_S_CLK (  ),
      .FSL15_S_READ (  ),
      .FSL15_S_DATA ( net_gnd32[31:0] ),
      .FSL15_S_CONTROL ( net_gnd0 ),
      .FSL15_S_EXISTS ( net_gnd0 ),
      .FSL15_M_CLK (  ),
      .FSL15_M_WRITE (  ),
      .FSL15_M_DATA (  ),
      .FSL15_M_CONTROL (  ),
      .FSL15_M_FULL ( net_gnd0 ),
      .M0_AXIS_TLAST (  ),
      .M0_AXIS_TDATA (  ),
      .M0_AXIS_TVALID (  ),
      .M0_AXIS_TREADY ( net_gnd0 ),
      .S0_AXIS_TLAST ( net_gnd0 ),
      .S0_AXIS_TDATA ( net_gnd32 ),
      .S0_AXIS_TVALID ( net_gnd0 ),
      .S0_AXIS_TREADY (  ),
      .M1_AXIS_TLAST (  ),
      .M1_AXIS_TDATA (  ),
      .M1_AXIS_TVALID (  ),
      .M1_AXIS_TREADY ( net_gnd0 ),
      .S1_AXIS_TLAST ( net_gnd0 ),
      .S1_AXIS_TDATA ( net_gnd32 ),
      .S1_AXIS_TVALID ( net_gnd0 ),
      .S1_AXIS_TREADY (  ),
      .M2_AXIS_TLAST (  ),
      .M2_AXIS_TDATA (  ),
      .M2_AXIS_TVALID (  ),
      .M2_AXIS_TREADY ( net_gnd0 ),
      .S2_AXIS_TLAST ( net_gnd0 ),
      .S2_AXIS_TDATA ( net_gnd32 ),
      .S2_AXIS_TVALID ( net_gnd0 ),
      .S2_AXIS_TREADY (  ),
      .M3_AXIS_TLAST (  ),
      .M3_AXIS_TDATA (  ),
      .M3_AXIS_TVALID (  ),
      .M3_AXIS_TREADY ( net_gnd0 ),
      .S3_AXIS_TLAST ( net_gnd0 ),
      .S3_AXIS_TDATA ( net_gnd32 ),
      .S3_AXIS_TVALID ( net_gnd0 ),
      .S3_AXIS_TREADY (  ),
      .M4_AXIS_TLAST (  ),
      .M4_AXIS_TDATA (  ),
      .M4_AXIS_TVALID (  ),
      .M4_AXIS_TREADY ( net_gnd0 ),
      .S4_AXIS_TLAST ( net_gnd0 ),
      .S4_AXIS_TDATA ( net_gnd32 ),
      .S4_AXIS_TVALID ( net_gnd0 ),
      .S4_AXIS_TREADY (  ),
      .M5_AXIS_TLAST (  ),
      .M5_AXIS_TDATA (  ),
      .M5_AXIS_TVALID (  ),
      .M5_AXIS_TREADY ( net_gnd0 ),
      .S5_AXIS_TLAST ( net_gnd0 ),
      .S5_AXIS_TDATA ( net_gnd32 ),
      .S5_AXIS_TVALID ( net_gnd0 ),
      .S5_AXIS_TREADY (  ),
      .M6_AXIS_TLAST (  ),
      .M6_AXIS_TDATA (  ),
      .M6_AXIS_TVALID (  ),
      .M6_AXIS_TREADY ( net_gnd0 ),
      .S6_AXIS_TLAST ( net_gnd0 ),
      .S6_AXIS_TDATA ( net_gnd32 ),
      .S6_AXIS_TVALID ( net_gnd0 ),
      .S6_AXIS_TREADY (  ),
      .M7_AXIS_TLAST (  ),
      .M7_AXIS_TDATA (  ),
      .M7_AXIS_TVALID (  ),
      .M7_AXIS_TREADY ( net_gnd0 ),
      .S7_AXIS_TLAST ( net_gnd0 ),
      .S7_AXIS_TDATA ( net_gnd32 ),
      .S7_AXIS_TVALID ( net_gnd0 ),
      .S7_AXIS_TREADY (  ),
      .M8_AXIS_TLAST (  ),
      .M8_AXIS_TDATA (  ),
      .M8_AXIS_TVALID (  ),
      .M8_AXIS_TREADY ( net_gnd0 ),
      .S8_AXIS_TLAST ( net_gnd0 ),
      .S8_AXIS_TDATA ( net_gnd32 ),
      .S8_AXIS_TVALID ( net_gnd0 ),
      .S8_AXIS_TREADY (  ),
      .M9_AXIS_TLAST (  ),
      .M9_AXIS_TDATA (  ),
      .M9_AXIS_TVALID (  ),
      .M9_AXIS_TREADY ( net_gnd0 ),
      .S9_AXIS_TLAST ( net_gnd0 ),
      .S9_AXIS_TDATA ( net_gnd32 ),
      .S9_AXIS_TVALID ( net_gnd0 ),
      .S9_AXIS_TREADY (  ),
      .M10_AXIS_TLAST (  ),
      .M10_AXIS_TDATA (  ),
      .M10_AXIS_TVALID (  ),
      .M10_AXIS_TREADY ( net_gnd0 ),
      .S10_AXIS_TLAST ( net_gnd0 ),
      .S10_AXIS_TDATA ( net_gnd32 ),
      .S10_AXIS_TVALID ( net_gnd0 ),
      .S10_AXIS_TREADY (  ),
      .M11_AXIS_TLAST (  ),
      .M11_AXIS_TDATA (  ),
      .M11_AXIS_TVALID (  ),
      .M11_AXIS_TREADY ( net_gnd0 ),
      .S11_AXIS_TLAST ( net_gnd0 ),
      .S11_AXIS_TDATA ( net_gnd32 ),
      .S11_AXIS_TVALID ( net_gnd0 ),
      .S11_AXIS_TREADY (  ),
      .M12_AXIS_TLAST (  ),
      .M12_AXIS_TDATA (  ),
      .M12_AXIS_TVALID (  ),
      .M12_AXIS_TREADY ( net_gnd0 ),
      .S12_AXIS_TLAST ( net_gnd0 ),
      .S12_AXIS_TDATA ( net_gnd32 ),
      .S12_AXIS_TVALID ( net_gnd0 ),
      .S12_AXIS_TREADY (  ),
      .M13_AXIS_TLAST (  ),
      .M13_AXIS_TDATA (  ),
      .M13_AXIS_TVALID (  ),
      .M13_AXIS_TREADY ( net_gnd0 ),
      .S13_AXIS_TLAST ( net_gnd0 ),
      .S13_AXIS_TDATA ( net_gnd32 ),
      .S13_AXIS_TVALID ( net_gnd0 ),
      .S13_AXIS_TREADY (  ),
      .M14_AXIS_TLAST (  ),
      .M14_AXIS_TDATA (  ),
      .M14_AXIS_TVALID (  ),
      .M14_AXIS_TREADY ( net_gnd0 ),
      .S14_AXIS_TLAST ( net_gnd0 ),
      .S14_AXIS_TDATA ( net_gnd32 ),
      .S14_AXIS_TVALID ( net_gnd0 ),
      .S14_AXIS_TREADY (  ),
      .M15_AXIS_TLAST (  ),
      .M15_AXIS_TDATA (  ),
      .M15_AXIS_TVALID (  ),
      .M15_AXIS_TREADY ( net_gnd0 ),
      .S15_AXIS_TLAST ( net_gnd0 ),
      .S15_AXIS_TDATA ( net_gnd32 ),
      .S15_AXIS_TVALID ( net_gnd0 ),
      .S15_AXIS_TREADY (  ),
      .ICACHE_FSL_IN_CLK (  ),
      .ICACHE_FSL_IN_READ (  ),
      .ICACHE_FSL_IN_DATA ( net_gnd32[31:0] ),
      .ICACHE_FSL_IN_CONTROL ( net_gnd0 ),
      .ICACHE_FSL_IN_EXISTS ( net_gnd0 ),
      .ICACHE_FSL_OUT_CLK (  ),
      .ICACHE_FSL_OUT_WRITE (  ),
      .ICACHE_FSL_OUT_DATA (  ),
      .ICACHE_FSL_OUT_CONTROL (  ),
      .ICACHE_FSL_OUT_FULL ( net_gnd0 ),
      .DCACHE_FSL_IN_CLK (  ),
      .DCACHE_FSL_IN_READ (  ),
      .DCACHE_FSL_IN_DATA ( net_gnd32[31:0] ),
      .DCACHE_FSL_IN_CONTROL ( net_gnd0 ),
      .DCACHE_FSL_IN_EXISTS ( net_gnd0 ),
      .DCACHE_FSL_OUT_CLK (  ),
      .DCACHE_FSL_OUT_WRITE (  ),
      .DCACHE_FSL_OUT_DATA (  ),
      .DCACHE_FSL_OUT_CONTROL (  ),
      .DCACHE_FSL_OUT_FULL ( net_gnd0 )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_debug_module_wrapper
    debug_module (
      .Interrupt (  ),
      .Debug_SYS_Rst ( proc_sys_reset_0_MB_Debug_Sys_Rst ),
      .Ext_BRK ( Ext_BRK ),
      .Ext_NM_BRK ( Ext_NM_BRK ),
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[1] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[63:32] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[1] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[1] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[63:32] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[7:4] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[1] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[1] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[3:2] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[1] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[1] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[63:32] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[1] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[1] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[63:32] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[3:2] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[1] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[1] ),
      .SPLB_Clk ( net_gnd0 ),
      .SPLB_Rst ( net_gnd0 ),
      .PLB_ABus ( net_gnd32[31:0] ),
      .PLB_UABus ( net_gnd32[31:0] ),
      .PLB_PAValid ( net_gnd0 ),
      .PLB_SAValid ( net_gnd0 ),
      .PLB_rdPrim ( net_gnd0 ),
      .PLB_wrPrim ( net_gnd0 ),
      .PLB_masterID ( net_gnd3 ),
      .PLB_abort ( net_gnd0 ),
      .PLB_busLock ( net_gnd0 ),
      .PLB_RNW ( net_gnd0 ),
      .PLB_BE ( net_gnd4 ),
      .PLB_MSize ( net_gnd2[1:0] ),
      .PLB_size ( net_gnd4 ),
      .PLB_type ( net_gnd3 ),
      .PLB_lockErr ( net_gnd0 ),
      .PLB_wrDBus ( net_gnd32[31:0] ),
      .PLB_wrBurst ( net_gnd0 ),
      .PLB_rdBurst ( net_gnd0 ),
      .PLB_wrPendReq ( net_gnd0 ),
      .PLB_rdPendReq ( net_gnd0 ),
      .PLB_wrPendPri ( net_gnd2[1:0] ),
      .PLB_rdPendPri ( net_gnd2[1:0] ),
      .PLB_reqPri ( net_gnd2[1:0] ),
      .PLB_TAttribute ( net_gnd16[15:0] ),
      .Sl_addrAck (  ),
      .Sl_SSize (  ),
      .Sl_wait (  ),
      .Sl_rearbitrate (  ),
      .Sl_wrDAck (  ),
      .Sl_wrComp (  ),
      .Sl_wrBTerm (  ),
      .Sl_rdDBus (  ),
      .Sl_rdWdAddr (  ),
      .Sl_rdDAck (  ),
      .Sl_rdComp (  ),
      .Sl_rdBTerm (  ),
      .Sl_MBusy (  ),
      .Sl_MWrErr (  ),
      .Sl_MRdErr (  ),
      .Sl_MIRQ (  ),
      .Dbg_Clk_0 ( microblaze_0_debug_Dbg_Clk ),
      .Dbg_TDI_0 ( microblaze_0_debug_Dbg_TDI ),
      .Dbg_TDO_0 ( microblaze_0_debug_Dbg_TDO ),
      .Dbg_Reg_En_0 ( microblaze_0_debug_Dbg_Reg_En ),
      .Dbg_Capture_0 ( microblaze_0_debug_Dbg_Capture ),
      .Dbg_Shift_0 ( microblaze_0_debug_Dbg_Shift ),
      .Dbg_Update_0 ( microblaze_0_debug_Dbg_Update ),
      .Dbg_Rst_0 ( microblaze_0_debug_Debug_Rst ),
      .Dbg_Clk_1 (  ),
      .Dbg_TDI_1 (  ),
      .Dbg_TDO_1 ( net_gnd0 ),
      .Dbg_Reg_En_1 (  ),
      .Dbg_Capture_1 (  ),
      .Dbg_Shift_1 (  ),
      .Dbg_Update_1 (  ),
      .Dbg_Rst_1 (  ),
      .Dbg_Clk_2 (  ),
      .Dbg_TDI_2 (  ),
      .Dbg_TDO_2 ( net_gnd0 ),
      .Dbg_Reg_En_2 (  ),
      .Dbg_Capture_2 (  ),
      .Dbg_Shift_2 (  ),
      .Dbg_Update_2 (  ),
      .Dbg_Rst_2 (  ),
      .Dbg_Clk_3 (  ),
      .Dbg_TDI_3 (  ),
      .Dbg_TDO_3 ( net_gnd0 ),
      .Dbg_Reg_En_3 (  ),
      .Dbg_Capture_3 (  ),
      .Dbg_Shift_3 (  ),
      .Dbg_Update_3 (  ),
      .Dbg_Rst_3 (  ),
      .Dbg_Clk_4 (  ),
      .Dbg_TDI_4 (  ),
      .Dbg_TDO_4 ( net_gnd0 ),
      .Dbg_Reg_En_4 (  ),
      .Dbg_Capture_4 (  ),
      .Dbg_Shift_4 (  ),
      .Dbg_Update_4 (  ),
      .Dbg_Rst_4 (  ),
      .Dbg_Clk_5 (  ),
      .Dbg_TDI_5 (  ),
      .Dbg_TDO_5 ( net_gnd0 ),
      .Dbg_Reg_En_5 (  ),
      .Dbg_Capture_5 (  ),
      .Dbg_Shift_5 (  ),
      .Dbg_Update_5 (  ),
      .Dbg_Rst_5 (  ),
      .Dbg_Clk_6 (  ),
      .Dbg_TDI_6 (  ),
      .Dbg_TDO_6 ( net_gnd0 ),
      .Dbg_Reg_En_6 (  ),
      .Dbg_Capture_6 (  ),
      .Dbg_Shift_6 (  ),
      .Dbg_Update_6 (  ),
      .Dbg_Rst_6 (  ),
      .Dbg_Clk_7 (  ),
      .Dbg_TDI_7 (  ),
      .Dbg_TDO_7 ( net_gnd0 ),
      .Dbg_Reg_En_7 (  ),
      .Dbg_Capture_7 (  ),
      .Dbg_Shift_7 (  ),
      .Dbg_Update_7 (  ),
      .Dbg_Rst_7 (  ),
      .Dbg_Clk_8 (  ),
      .Dbg_TDI_8 (  ),
      .Dbg_TDO_8 ( net_gnd0 ),
      .Dbg_Reg_En_8 (  ),
      .Dbg_Capture_8 (  ),
      .Dbg_Shift_8 (  ),
      .Dbg_Update_8 (  ),
      .Dbg_Rst_8 (  ),
      .Dbg_Clk_9 (  ),
      .Dbg_TDI_9 (  ),
      .Dbg_TDO_9 ( net_gnd0 ),
      .Dbg_Reg_En_9 (  ),
      .Dbg_Capture_9 (  ),
      .Dbg_Shift_9 (  ),
      .Dbg_Update_9 (  ),
      .Dbg_Rst_9 (  ),
      .Dbg_Clk_10 (  ),
      .Dbg_TDI_10 (  ),
      .Dbg_TDO_10 ( net_gnd0 ),
      .Dbg_Reg_En_10 (  ),
      .Dbg_Capture_10 (  ),
      .Dbg_Shift_10 (  ),
      .Dbg_Update_10 (  ),
      .Dbg_Rst_10 (  ),
      .Dbg_Clk_11 (  ),
      .Dbg_TDI_11 (  ),
      .Dbg_TDO_11 ( net_gnd0 ),
      .Dbg_Reg_En_11 (  ),
      .Dbg_Capture_11 (  ),
      .Dbg_Shift_11 (  ),
      .Dbg_Update_11 (  ),
      .Dbg_Rst_11 (  ),
      .Dbg_Clk_12 (  ),
      .Dbg_TDI_12 (  ),
      .Dbg_TDO_12 ( net_gnd0 ),
      .Dbg_Reg_En_12 (  ),
      .Dbg_Capture_12 (  ),
      .Dbg_Shift_12 (  ),
      .Dbg_Update_12 (  ),
      .Dbg_Rst_12 (  ),
      .Dbg_Clk_13 (  ),
      .Dbg_TDI_13 (  ),
      .Dbg_TDO_13 ( net_gnd0 ),
      .Dbg_Reg_En_13 (  ),
      .Dbg_Capture_13 (  ),
      .Dbg_Shift_13 (  ),
      .Dbg_Update_13 (  ),
      .Dbg_Rst_13 (  ),
      .Dbg_Clk_14 (  ),
      .Dbg_TDI_14 (  ),
      .Dbg_TDO_14 ( net_gnd0 ),
      .Dbg_Reg_En_14 (  ),
      .Dbg_Capture_14 (  ),
      .Dbg_Shift_14 (  ),
      .Dbg_Update_14 (  ),
      .Dbg_Rst_14 (  ),
      .Dbg_Clk_15 (  ),
      .Dbg_TDI_15 (  ),
      .Dbg_TDO_15 ( net_gnd0 ),
      .Dbg_Reg_En_15 (  ),
      .Dbg_Capture_15 (  ),
      .Dbg_Shift_15 (  ),
      .Dbg_Update_15 (  ),
      .Dbg_Rst_15 (  ),
      .Dbg_Clk_16 (  ),
      .Dbg_TDI_16 (  ),
      .Dbg_TDO_16 ( net_gnd0 ),
      .Dbg_Reg_En_16 (  ),
      .Dbg_Capture_16 (  ),
      .Dbg_Shift_16 (  ),
      .Dbg_Update_16 (  ),
      .Dbg_Rst_16 (  ),
      .Dbg_Clk_17 (  ),
      .Dbg_TDI_17 (  ),
      .Dbg_TDO_17 ( net_gnd0 ),
      .Dbg_Reg_En_17 (  ),
      .Dbg_Capture_17 (  ),
      .Dbg_Shift_17 (  ),
      .Dbg_Update_17 (  ),
      .Dbg_Rst_17 (  ),
      .Dbg_Clk_18 (  ),
      .Dbg_TDI_18 (  ),
      .Dbg_TDO_18 ( net_gnd0 ),
      .Dbg_Reg_En_18 (  ),
      .Dbg_Capture_18 (  ),
      .Dbg_Shift_18 (  ),
      .Dbg_Update_18 (  ),
      .Dbg_Rst_18 (  ),
      .Dbg_Clk_19 (  ),
      .Dbg_TDI_19 (  ),
      .Dbg_TDO_19 ( net_gnd0 ),
      .Dbg_Reg_En_19 (  ),
      .Dbg_Capture_19 (  ),
      .Dbg_Shift_19 (  ),
      .Dbg_Update_19 (  ),
      .Dbg_Rst_19 (  ),
      .Dbg_Clk_20 (  ),
      .Dbg_TDI_20 (  ),
      .Dbg_TDO_20 ( net_gnd0 ),
      .Dbg_Reg_En_20 (  ),
      .Dbg_Capture_20 (  ),
      .Dbg_Shift_20 (  ),
      .Dbg_Update_20 (  ),
      .Dbg_Rst_20 (  ),
      .Dbg_Clk_21 (  ),
      .Dbg_TDI_21 (  ),
      .Dbg_TDO_21 ( net_gnd0 ),
      .Dbg_Reg_En_21 (  ),
      .Dbg_Capture_21 (  ),
      .Dbg_Shift_21 (  ),
      .Dbg_Update_21 (  ),
      .Dbg_Rst_21 (  ),
      .Dbg_Clk_22 (  ),
      .Dbg_TDI_22 (  ),
      .Dbg_TDO_22 ( net_gnd0 ),
      .Dbg_Reg_En_22 (  ),
      .Dbg_Capture_22 (  ),
      .Dbg_Shift_22 (  ),
      .Dbg_Update_22 (  ),
      .Dbg_Rst_22 (  ),
      .Dbg_Clk_23 (  ),
      .Dbg_TDI_23 (  ),
      .Dbg_TDO_23 ( net_gnd0 ),
      .Dbg_Reg_En_23 (  ),
      .Dbg_Capture_23 (  ),
      .Dbg_Shift_23 (  ),
      .Dbg_Update_23 (  ),
      .Dbg_Rst_23 (  ),
      .Dbg_Clk_24 (  ),
      .Dbg_TDI_24 (  ),
      .Dbg_TDO_24 ( net_gnd0 ),
      .Dbg_Reg_En_24 (  ),
      .Dbg_Capture_24 (  ),
      .Dbg_Shift_24 (  ),
      .Dbg_Update_24 (  ),
      .Dbg_Rst_24 (  ),
      .Dbg_Clk_25 (  ),
      .Dbg_TDI_25 (  ),
      .Dbg_TDO_25 ( net_gnd0 ),
      .Dbg_Reg_En_25 (  ),
      .Dbg_Capture_25 (  ),
      .Dbg_Shift_25 (  ),
      .Dbg_Update_25 (  ),
      .Dbg_Rst_25 (  ),
      .Dbg_Clk_26 (  ),
      .Dbg_TDI_26 (  ),
      .Dbg_TDO_26 ( net_gnd0 ),
      .Dbg_Reg_En_26 (  ),
      .Dbg_Capture_26 (  ),
      .Dbg_Shift_26 (  ),
      .Dbg_Update_26 (  ),
      .Dbg_Rst_26 (  ),
      .Dbg_Clk_27 (  ),
      .Dbg_TDI_27 (  ),
      .Dbg_TDO_27 ( net_gnd0 ),
      .Dbg_Reg_En_27 (  ),
      .Dbg_Capture_27 (  ),
      .Dbg_Shift_27 (  ),
      .Dbg_Update_27 (  ),
      .Dbg_Rst_27 (  ),
      .Dbg_Clk_28 (  ),
      .Dbg_TDI_28 (  ),
      .Dbg_TDO_28 ( net_gnd0 ),
      .Dbg_Reg_En_28 (  ),
      .Dbg_Capture_28 (  ),
      .Dbg_Shift_28 (  ),
      .Dbg_Update_28 (  ),
      .Dbg_Rst_28 (  ),
      .Dbg_Clk_29 (  ),
      .Dbg_TDI_29 (  ),
      .Dbg_TDO_29 ( net_gnd0 ),
      .Dbg_Reg_En_29 (  ),
      .Dbg_Capture_29 (  ),
      .Dbg_Shift_29 (  ),
      .Dbg_Update_29 (  ),
      .Dbg_Rst_29 (  ),
      .Dbg_Clk_30 (  ),
      .Dbg_TDI_30 (  ),
      .Dbg_TDO_30 ( net_gnd0 ),
      .Dbg_Reg_En_30 (  ),
      .Dbg_Capture_30 (  ),
      .Dbg_Shift_30 (  ),
      .Dbg_Update_30 (  ),
      .Dbg_Rst_30 (  ),
      .Dbg_Clk_31 (  ),
      .Dbg_TDI_31 (  ),
      .Dbg_TDO_31 ( net_gnd0 ),
      .Dbg_Reg_En_31 (  ),
      .Dbg_Capture_31 (  ),
      .Dbg_Shift_31 (  ),
      .Dbg_Update_31 (  ),
      .Dbg_Rst_31 (  ),
      .bscan_tdi (  ),
      .bscan_reset (  ),
      .bscan_shift (  ),
      .bscan_update (  ),
      .bscan_capture (  ),
      .bscan_sel1 (  ),
      .bscan_drck1 (  ),
      .bscan_tdo1 ( net_gnd0 ),
      .bscan_ext_tdi ( net_gnd0 ),
      .bscan_ext_reset ( net_gnd0 ),
      .bscan_ext_shift ( net_gnd0 ),
      .bscan_ext_update ( net_gnd0 ),
      .bscan_ext_capture ( net_gnd0 ),
      .bscan_ext_sel ( net_gnd0 ),
      .bscan_ext_drck ( net_gnd0 ),
      .bscan_ext_tdo (  ),
      .Ext_JTAG_DRCK (  ),
      .Ext_JTAG_RESET (  ),
      .Ext_JTAG_SEL (  ),
      .Ext_JTAG_CAPTURE (  ),
      .Ext_JTAG_SHIFT (  ),
      .Ext_JTAG_UPDATE (  ),
      .Ext_JTAG_TDI (  ),
      .Ext_JTAG_TDO ( net_gnd0 )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_clock_generator_0_wrapper
    clock_generator_0 (
      .CLKIN ( clock_generator_1_CLKOUT0 ),
      .CLKOUT0 ( clk_100_0000MHz ),
      .CLKOUT1 ( clk_125_0000MHz ),
      .CLKOUT2 ( clk_200_0000MHz ),
      .CLKOUT3 (  ),
      .CLKOUT4 ( gtx_clk_125_0000Mhz ),
      .CLKOUT5 ( gtx_clk_125_0000MHz_90 ),
      .CLKOUT6 (  ),
      .CLKOUT7 (  ),
      .CLKOUT8 (  ),
      .CLKOUT9 (  ),
      .CLKOUT10 (  ),
      .CLKOUT11 (  ),
      .CLKOUT12 (  ),
      .CLKOUT13 (  ),
      .CLKOUT14 (  ),
      .CLKOUT15 (  ),
      .CLKFBIN ( net_gnd0 ),
      .CLKFBOUT (  ),
      .PSCLK ( net_gnd0 ),
      .PSEN ( net_gnd0 ),
      .PSINCDEC ( net_gnd0 ),
      .PSDONE (  ),
      .RST ( clk_gen_pre_lock ),
      .LOCKED ( proc_sys_reset_0_Dcm_locked )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_axi_timebase_wdt_0_wrapper
    axi_timebase_wdt_0 (
      .WDT_Reset (  ),
      .Timebase_Interrupt ( axi_timebase_wdt_0_Timebase_Interrupt ),
      .WDT_Interrupt ( axi_timebase_wdt_0_WDT_Interrupt ),
      .Freeze ( net_gnd0 ),
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[2] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[67:64] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[2] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[2] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[95:64] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[11:8] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[2] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[2] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[5:4] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[2] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[2] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[67:64] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[2] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[2] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[95:64] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[5:4] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[2] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[2] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_axi_interconnect_0_wrapper
    axi_interconnect_0 (
      .INTERCONNECT_ACLK ( clk_100_0000MHz ),
      .INTERCONNECT_ARESETN ( proc_sys_reset_0_Interconnect_aresetn[0] ),
      .S_AXI_ARESET_OUT_N ( axi_interconnect_0_S_ARESETN ),
      .M_AXI_ARESET_OUT_N ( axi_interconnect_0_M_ARESETN ),
      .IRQ (  ),
      .S_AXI_ACLK ( pgassign2 ),
      .S_AXI_AWID ( axi_interconnect_0_S_AWID ),
      .S_AXI_AWADDR ( axi_interconnect_0_S_AWADDR ),
      .S_AXI_AWLEN ( axi_interconnect_0_S_AWLEN ),
      .S_AXI_AWSIZE ( axi_interconnect_0_S_AWSIZE ),
      .S_AXI_AWBURST ( axi_interconnect_0_S_AWBURST ),
      .S_AXI_AWLOCK ( axi_interconnect_0_S_AWLOCK ),
      .S_AXI_AWCACHE ( axi_interconnect_0_S_AWCACHE ),
      .S_AXI_AWPROT ( axi_interconnect_0_S_AWPROT ),
      .S_AXI_AWQOS ( axi_interconnect_0_S_AWQOS ),
      .S_AXI_AWUSER ( net_gnd2 ),
      .S_AXI_AWVALID ( axi_interconnect_0_S_AWVALID ),
      .S_AXI_AWREADY ( axi_interconnect_0_S_AWREADY ),
      .S_AXI_WID ( net_gnd2 ),
      .S_AXI_WDATA ( axi_interconnect_0_S_WDATA ),
      .S_AXI_WSTRB ( axi_interconnect_0_S_WSTRB ),
      .S_AXI_WLAST ( axi_interconnect_0_S_WLAST ),
      .S_AXI_WUSER ( net_gnd2 ),
      .S_AXI_WVALID ( axi_interconnect_0_S_WVALID ),
      .S_AXI_WREADY ( axi_interconnect_0_S_WREADY ),
      .S_AXI_BID ( axi_interconnect_0_S_BID ),
      .S_AXI_BRESP ( axi_interconnect_0_S_BRESP ),
      .S_AXI_BUSER (  ),
      .S_AXI_BVALID ( axi_interconnect_0_S_BVALID ),
      .S_AXI_BREADY ( axi_interconnect_0_S_BREADY ),
      .S_AXI_ARID ( axi_interconnect_0_S_ARID ),
      .S_AXI_ARADDR ( axi_interconnect_0_S_ARADDR ),
      .S_AXI_ARLEN ( axi_interconnect_0_S_ARLEN ),
      .S_AXI_ARSIZE ( axi_interconnect_0_S_ARSIZE ),
      .S_AXI_ARBURST ( axi_interconnect_0_S_ARBURST ),
      .S_AXI_ARLOCK ( axi_interconnect_0_S_ARLOCK ),
      .S_AXI_ARCACHE ( axi_interconnect_0_S_ARCACHE ),
      .S_AXI_ARPROT ( axi_interconnect_0_S_ARPROT ),
      .S_AXI_ARQOS ( axi_interconnect_0_S_ARQOS ),
      .S_AXI_ARUSER ( net_gnd2 ),
      .S_AXI_ARVALID ( axi_interconnect_0_S_ARVALID ),
      .S_AXI_ARREADY ( axi_interconnect_0_S_ARREADY ),
      .S_AXI_RID ( axi_interconnect_0_S_RID ),
      .S_AXI_RDATA ( axi_interconnect_0_S_RDATA ),
      .S_AXI_RRESP ( axi_interconnect_0_S_RRESP ),
      .S_AXI_RLAST ( axi_interconnect_0_S_RLAST ),
      .S_AXI_RUSER (  ),
      .S_AXI_RVALID ( axi_interconnect_0_S_RVALID ),
      .S_AXI_RREADY ( axi_interconnect_0_S_RREADY ),
      .M_AXI_ACLK ( pgassign3 ),
      .M_AXI_AWID (  ),
      .M_AXI_AWADDR ( axi_interconnect_0_M_AWADDR ),
      .M_AXI_AWLEN (  ),
      .M_AXI_AWSIZE (  ),
      .M_AXI_AWBURST (  ),
      .M_AXI_AWLOCK (  ),
      .M_AXI_AWCACHE (  ),
      .M_AXI_AWPROT (  ),
      .M_AXI_AWREGION (  ),
      .M_AXI_AWQOS (  ),
      .M_AXI_AWUSER (  ),
      .M_AXI_AWVALID ( axi_interconnect_0_M_AWVALID ),
      .M_AXI_AWREADY ( axi_interconnect_0_M_AWREADY ),
      .M_AXI_WID (  ),
      .M_AXI_WDATA ( axi_interconnect_0_M_WDATA ),
      .M_AXI_WSTRB ( axi_interconnect_0_M_WSTRB ),
      .M_AXI_WLAST (  ),
      .M_AXI_WUSER (  ),
      .M_AXI_WVALID ( axi_interconnect_0_M_WVALID ),
      .M_AXI_WREADY ( axi_interconnect_0_M_WREADY ),
      .M_AXI_BID ( net_gnd16 ),
      .M_AXI_BRESP ( axi_interconnect_0_M_BRESP ),
      .M_AXI_BUSER ( net_gnd16 ),
      .M_AXI_BVALID ( axi_interconnect_0_M_BVALID ),
      .M_AXI_BREADY ( axi_interconnect_0_M_BREADY ),
      .M_AXI_ARID (  ),
      .M_AXI_ARADDR ( axi_interconnect_0_M_ARADDR ),
      .M_AXI_ARLEN (  ),
      .M_AXI_ARSIZE (  ),
      .M_AXI_ARBURST (  ),
      .M_AXI_ARLOCK (  ),
      .M_AXI_ARCACHE (  ),
      .M_AXI_ARPROT (  ),
      .M_AXI_ARREGION (  ),
      .M_AXI_ARQOS (  ),
      .M_AXI_ARUSER (  ),
      .M_AXI_ARVALID ( axi_interconnect_0_M_ARVALID ),
      .M_AXI_ARREADY ( axi_interconnect_0_M_ARREADY ),
      .M_AXI_RID ( net_gnd16 ),
      .M_AXI_RDATA ( axi_interconnect_0_M_RDATA ),
      .M_AXI_RRESP ( axi_interconnect_0_M_RRESP ),
      .M_AXI_RLAST ( net_gnd16 ),
      .M_AXI_RUSER ( net_gnd16 ),
      .M_AXI_RVALID ( axi_interconnect_0_M_RVALID ),
      .M_AXI_RREADY ( axi_interconnect_0_M_RREADY ),
      .S_AXI_CTRL_AWADDR ( net_gnd32 ),
      .S_AXI_CTRL_AWVALID ( net_gnd0 ),
      .S_AXI_CTRL_AWREADY (  ),
      .S_AXI_CTRL_WDATA ( net_gnd32 ),
      .S_AXI_CTRL_WVALID ( net_gnd0 ),
      .S_AXI_CTRL_WREADY (  ),
      .S_AXI_CTRL_BRESP (  ),
      .S_AXI_CTRL_BVALID (  ),
      .S_AXI_CTRL_BREADY ( net_gnd0 ),
      .S_AXI_CTRL_ARADDR ( net_gnd32 ),
      .S_AXI_CTRL_ARVALID ( net_gnd0 ),
      .S_AXI_CTRL_ARREADY (  ),
      .S_AXI_CTRL_RDATA (  ),
      .S_AXI_CTRL_RRESP (  ),
      .S_AXI_CTRL_RVALID (  ),
      .S_AXI_CTRL_RREADY ( net_gnd0 ),
      .INTERCONNECT_ARESET_OUT_N (  ),
      .DEBUG_AW_TRANS_SEQ (  ),
      .DEBUG_AW_ARB_GRANT (  ),
      .DEBUG_AR_TRANS_SEQ (  ),
      .DEBUG_AR_ARB_GRANT (  ),
      .DEBUG_AW_TRANS_QUAL (  ),
      .DEBUG_AW_ACCEPT_CNT (  ),
      .DEBUG_AW_ACTIVE_THREAD (  ),
      .DEBUG_AW_ACTIVE_TARGET (  ),
      .DEBUG_AW_ACTIVE_REGION (  ),
      .DEBUG_AW_ERROR (  ),
      .DEBUG_AW_TARGET (  ),
      .DEBUG_AR_TRANS_QUAL (  ),
      .DEBUG_AR_ACCEPT_CNT (  ),
      .DEBUG_AR_ACTIVE_THREAD (  ),
      .DEBUG_AR_ACTIVE_TARGET (  ),
      .DEBUG_AR_ACTIVE_REGION (  ),
      .DEBUG_AR_ERROR (  ),
      .DEBUG_AR_TARGET (  ),
      .DEBUG_B_TRANS_SEQ (  ),
      .DEBUG_R_BEAT_CNT (  ),
      .DEBUG_R_TRANS_SEQ (  ),
      .DEBUG_AW_ISSUING_CNT (  ),
      .DEBUG_AR_ISSUING_CNT (  ),
      .DEBUG_W_BEAT_CNT (  ),
      .DEBUG_W_TRANS_SEQ (  ),
      .DEBUG_BID_TARGET (  ),
      .DEBUG_BID_ERROR (  ),
      .DEBUG_RID_TARGET (  ),
      .DEBUG_RID_ERROR (  ),
      .DEBUG_SR_SC_ARADDR (  ),
      .DEBUG_SR_SC_ARADDRCONTROL (  ),
      .DEBUG_SR_SC_AWADDR (  ),
      .DEBUG_SR_SC_AWADDRCONTROL (  ),
      .DEBUG_SR_SC_BRESP (  ),
      .DEBUG_SR_SC_RDATA (  ),
      .DEBUG_SR_SC_RDATACONTROL (  ),
      .DEBUG_SR_SC_WDATA (  ),
      .DEBUG_SR_SC_WDATACONTROL (  ),
      .DEBUG_SC_SF_ARADDR (  ),
      .DEBUG_SC_SF_ARADDRCONTROL (  ),
      .DEBUG_SC_SF_AWADDR (  ),
      .DEBUG_SC_SF_AWADDRCONTROL (  ),
      .DEBUG_SC_SF_BRESP (  ),
      .DEBUG_SC_SF_RDATA (  ),
      .DEBUG_SC_SF_RDATACONTROL (  ),
      .DEBUG_SC_SF_WDATA (  ),
      .DEBUG_SC_SF_WDATACONTROL (  ),
      .DEBUG_SF_CB_ARADDR (  ),
      .DEBUG_SF_CB_ARADDRCONTROL (  ),
      .DEBUG_SF_CB_AWADDR (  ),
      .DEBUG_SF_CB_AWADDRCONTROL (  ),
      .DEBUG_SF_CB_BRESP (  ),
      .DEBUG_SF_CB_RDATA (  ),
      .DEBUG_SF_CB_RDATACONTROL (  ),
      .DEBUG_SF_CB_WDATA (  ),
      .DEBUG_SF_CB_WDATACONTROL (  ),
      .DEBUG_CB_MF_ARADDR (  ),
      .DEBUG_CB_MF_ARADDRCONTROL (  ),
      .DEBUG_CB_MF_AWADDR (  ),
      .DEBUG_CB_MF_AWADDRCONTROL (  ),
      .DEBUG_CB_MF_BRESP (  ),
      .DEBUG_CB_MF_RDATA (  ),
      .DEBUG_CB_MF_RDATACONTROL (  ),
      .DEBUG_CB_MF_WDATA (  ),
      .DEBUG_CB_MF_WDATACONTROL (  ),
      .DEBUG_MF_MC_ARADDR (  ),
      .DEBUG_MF_MC_ARADDRCONTROL (  ),
      .DEBUG_MF_MC_AWADDR (  ),
      .DEBUG_MF_MC_AWADDRCONTROL (  ),
      .DEBUG_MF_MC_BRESP (  ),
      .DEBUG_MF_MC_RDATA (  ),
      .DEBUG_MF_MC_RDATACONTROL (  ),
      .DEBUG_MF_MC_WDATA (  ),
      .DEBUG_MF_MC_WDATACONTROL (  ),
      .DEBUG_MC_MP_ARADDR (  ),
      .DEBUG_MC_MP_ARADDRCONTROL (  ),
      .DEBUG_MC_MP_AWADDR (  ),
      .DEBUG_MC_MP_AWADDRCONTROL (  ),
      .DEBUG_MC_MP_BRESP (  ),
      .DEBUG_MC_MP_RDATA (  ),
      .DEBUG_MC_MP_RDATACONTROL (  ),
      .DEBUG_MC_MP_WDATA (  ),
      .DEBUG_MC_MP_WDATACONTROL (  ),
      .DEBUG_MP_MR_ARADDR (  ),
      .DEBUG_MP_MR_ARADDRCONTROL (  ),
      .DEBUG_MP_MR_AWADDR (  ),
      .DEBUG_MP_MR_AWADDRCONTROL (  ),
      .DEBUG_MP_MR_BRESP (  ),
      .DEBUG_MP_MR_RDATA (  ),
      .DEBUG_MP_MR_RDATACONTROL (  ),
      .DEBUG_MP_MR_WDATA (  ),
      .DEBUG_MP_MR_WDATACONTROL (  )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_rs232_uart_1_wrapper
    RS232_Uart_1 (
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[3] ),
      .Interrupt ( RS232_Interrupt ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[99:96] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[3] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[3] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[127:96] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[15:12] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[3] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[3] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[7:6] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[3] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[3] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[99:96] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[3] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[3] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[127:96] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[7:6] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[3] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[3] ),
      .RX ( RS232_Uart_1_sin ),
      .TX ( RS232_Uart_1_sout )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf1_cml_interface_0_wrapper
    nf1_cml_interface_0 (
      .glbl_rstn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .gtx_clk ( gtx_clk_125_0000Mhz ),
      .gtx_clk90 ( gtx_clk_125_0000MHz_90 ),
      .refclk ( clk_200_0000MHz ),
      .axi_aclk ( clk_125_0000MHz ),
      .m_axis_tdata ( nf1_cml_interface_1_M_AXIS_TDATA ),
      .m_axis_tstrb ( nf1_cml_interface_1_M_AXIS_TSTRB ),
      .m_axis_tuser ( nf1_cml_interface_1_M_AXIS_TUSER ),
      .m_axis_tvalid ( nf1_cml_interface_1_M_AXIS_TVALID ),
      .m_axis_tready ( nf1_cml_interface_1_M_AXIS_TREADY ),
      .m_axis_tlast ( nf1_cml_interface_1_M_AXIS_TLAST ),
      .s_axis_tdata ( nf10_bram_output_queues_0_M_AXIS_0_TDATA ),
      .s_axis_tstrb ( nf10_bram_output_queues_0_M_AXIS_0_TSTRB ),
      .s_axis_tuser ( nf10_bram_output_queues_0_M_AXIS_0_TUSER ),
      .s_axis_tvalid ( nf10_bram_output_queues_0_M_AXIS_0_TVALID ),
      .s_axis_tready ( nf10_bram_output_queues_0_M_AXIS_0_TREADY ),
      .s_axis_tlast ( nf10_bram_output_queues_0_M_AXIS_0_TLAST ),
      .rgmii_txd ( nf1_cml_interface_1_rgmii_txd ),
      .rgmii_tx_ctl ( nf1_cml_interface_1_rgmii_tx_ctl ),
      .rgmii_txc ( nf1_cml_interface_1_rgmii_txc ),
      .rgmii_rxd ( nf1_cml_interface_1_rgmii_rxd ),
      .rgmii_rx_ctl ( nf1_cml_interface_1_rgmii_rx_ctl ),
      .rgmii_rxc ( nf1_cml_interface_1_rgmii_rxc ),
      .s_axi_aclk ( clk_100_0000MHz ),
      .s_axi_aresetn ( axi_interconnect_0_M_ARESETN[4] ),
      .s_axi_awaddr ( axi_interconnect_0_M_AWADDR[159:128] ),
      .s_axi_awvalid ( axi_interconnect_0_M_AWVALID[4] ),
      .s_axi_awready ( axi_interconnect_0_M_AWREADY[4] ),
      .s_axi_wdata ( axi_interconnect_0_M_WDATA[159:128] ),
      .s_axi_wvalid ( axi_interconnect_0_M_WVALID[4] ),
      .s_axi_wready ( axi_interconnect_0_M_WREADY[4] ),
      .s_axi_bresp ( axi_interconnect_0_M_BRESP[9:8] ),
      .s_axi_bvalid ( axi_interconnect_0_M_BVALID[4] ),
      .s_axi_bready ( axi_interconnect_0_M_BREADY[4] ),
      .s_axi_araddr ( axi_interconnect_0_M_ARADDR[159:128] ),
      .s_axi_arvalid ( axi_interconnect_0_M_ARVALID[4] ),
      .s_axi_arready ( axi_interconnect_0_M_ARREADY[4] ),
      .s_axi_rdata ( axi_interconnect_0_M_RDATA[159:128] ),
      .s_axi_rresp ( axi_interconnect_0_M_RRESP[9:8] ),
      .s_axi_rvalid ( axi_interconnect_0_M_RVALID[4] ),
      .s_axi_rready ( axi_interconnect_0_M_RREADY[4] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf1_cml_interface_1_wrapper
    nf1_cml_interface_1 (
      .glbl_rstn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .gtx_clk ( gtx_clk_125_0000Mhz ),
      .gtx_clk90 ( gtx_clk_125_0000MHz_90 ),
      .refclk ( clk_200_0000MHz ),
      .axi_aclk ( clk_125_0000MHz ),
      .m_axis_tdata ( nf1_cml_interface_2_M_AXIS_TDATA ),
      .m_axis_tstrb ( nf1_cml_interface_2_M_AXIS_TSTRB ),
      .m_axis_tuser ( nf1_cml_interface_2_M_AXIS_TUSER ),
      .m_axis_tvalid ( nf1_cml_interface_2_M_AXIS_TVALID ),
      .m_axis_tready ( nf1_cml_interface_2_M_AXIS_TREADY ),
      .m_axis_tlast ( nf1_cml_interface_2_M_AXIS_TLAST ),
      .s_axis_tdata ( nf10_bram_output_queues_0_M_AXIS_1_TDATA ),
      .s_axis_tstrb ( nf10_bram_output_queues_0_M_AXIS_1_TSTRB ),
      .s_axis_tuser ( nf10_bram_output_queues_0_M_AXIS_1_TUSER ),
      .s_axis_tvalid ( nf10_bram_output_queues_0_M_AXIS_1_TVALID ),
      .s_axis_tready ( nf10_bram_output_queues_0_M_AXIS_1_TREADY ),
      .s_axis_tlast ( nf10_bram_output_queues_0_M_AXIS_1_TLAST ),
      .rgmii_txd ( nf1_cml_interface_2_rgmii_txd ),
      .rgmii_tx_ctl ( nf1_cml_interface_2_rgmii_tx_ctl ),
      .rgmii_txc ( nf1_cml_interface_2_rgmii_txc ),
      .rgmii_rxd ( nf1_cml_interface_2_rgmii_rxd ),
      .rgmii_rx_ctl ( nf1_cml_interface_2_rgmii_rx_ctl ),
      .rgmii_rxc ( nf1_cml_interface_2_rgmii_rxc ),
      .s_axi_aclk ( clk_100_0000MHz ),
      .s_axi_aresetn ( axi_interconnect_0_M_ARESETN[5] ),
      .s_axi_awaddr ( axi_interconnect_0_M_AWADDR[191:160] ),
      .s_axi_awvalid ( axi_interconnect_0_M_AWVALID[5] ),
      .s_axi_awready ( axi_interconnect_0_M_AWREADY[5] ),
      .s_axi_wdata ( axi_interconnect_0_M_WDATA[191:160] ),
      .s_axi_wvalid ( axi_interconnect_0_M_WVALID[5] ),
      .s_axi_wready ( axi_interconnect_0_M_WREADY[5] ),
      .s_axi_bresp ( axi_interconnect_0_M_BRESP[11:10] ),
      .s_axi_bvalid ( axi_interconnect_0_M_BVALID[5] ),
      .s_axi_bready ( axi_interconnect_0_M_BREADY[5] ),
      .s_axi_araddr ( axi_interconnect_0_M_ARADDR[191:160] ),
      .s_axi_arvalid ( axi_interconnect_0_M_ARVALID[5] ),
      .s_axi_arready ( axi_interconnect_0_M_ARREADY[5] ),
      .s_axi_rdata ( axi_interconnect_0_M_RDATA[191:160] ),
      .s_axi_rresp ( axi_interconnect_0_M_RRESP[11:10] ),
      .s_axi_rvalid ( axi_interconnect_0_M_RVALID[5] ),
      .s_axi_rready ( axi_interconnect_0_M_RREADY[5] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf1_cml_interface_2_wrapper
    nf1_cml_interface_2 (
      .glbl_rstn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .gtx_clk ( gtx_clk_125_0000Mhz ),
      .gtx_clk90 ( gtx_clk_125_0000MHz_90 ),
      .refclk ( clk_200_0000MHz ),
      .axi_aclk ( clk_125_0000MHz ),
      .m_axis_tdata ( nf1_cml_interface_3_M_AXIS_TDATA ),
      .m_axis_tstrb ( nf1_cml_interface_3_M_AXIS_TSTRB ),
      .m_axis_tuser ( nf1_cml_interface_3_M_AXIS_TUSER ),
      .m_axis_tvalid ( nf1_cml_interface_3_M_AXIS_TVALID ),
      .m_axis_tready ( nf1_cml_interface_3_M_AXIS_TREADY ),
      .m_axis_tlast ( nf1_cml_interface_3_M_AXIS_TLAST ),
      .s_axis_tdata ( nf10_bram_output_queues_0_M_AXIS_2_TDATA ),
      .s_axis_tstrb ( nf10_bram_output_queues_0_M_AXIS_2_TSTRB ),
      .s_axis_tuser ( nf10_bram_output_queues_0_M_AXIS_2_TUSER ),
      .s_axis_tvalid ( nf10_bram_output_queues_0_M_AXIS_2_TVALID ),
      .s_axis_tready ( nf10_bram_output_queues_0_M_AXIS_2_TREADY ),
      .s_axis_tlast ( nf10_bram_output_queues_0_M_AXIS_2_TLAST ),
      .rgmii_txd ( nf1_cml_interface_3_rgmii_txd ),
      .rgmii_tx_ctl ( nf1_cml_interface_3_rgmii_tx_ctl ),
      .rgmii_txc ( nf1_cml_interface_3_rgmii_txc ),
      .rgmii_rxd ( nf1_cml_interface_3_rgmii_rxd ),
      .rgmii_rx_ctl ( nf1_cml_interface_3_rgmii_rx_ctl ),
      .rgmii_rxc ( nf1_cml_interface_3_rgmii_rxc ),
      .s_axi_aclk ( clk_100_0000MHz ),
      .s_axi_aresetn ( axi_interconnect_0_M_ARESETN[6] ),
      .s_axi_awaddr ( axi_interconnect_0_M_AWADDR[223:192] ),
      .s_axi_awvalid ( axi_interconnect_0_M_AWVALID[6] ),
      .s_axi_awready ( axi_interconnect_0_M_AWREADY[6] ),
      .s_axi_wdata ( axi_interconnect_0_M_WDATA[223:192] ),
      .s_axi_wvalid ( axi_interconnect_0_M_WVALID[6] ),
      .s_axi_wready ( axi_interconnect_0_M_WREADY[6] ),
      .s_axi_bresp ( axi_interconnect_0_M_BRESP[13:12] ),
      .s_axi_bvalid ( axi_interconnect_0_M_BVALID[6] ),
      .s_axi_bready ( axi_interconnect_0_M_BREADY[6] ),
      .s_axi_araddr ( axi_interconnect_0_M_ARADDR[223:192] ),
      .s_axi_arvalid ( axi_interconnect_0_M_ARVALID[6] ),
      .s_axi_arready ( axi_interconnect_0_M_ARREADY[6] ),
      .s_axi_rdata ( axi_interconnect_0_M_RDATA[223:192] ),
      .s_axi_rresp ( axi_interconnect_0_M_RRESP[13:12] ),
      .s_axi_rvalid ( axi_interconnect_0_M_RVALID[6] ),
      .s_axi_rready ( axi_interconnect_0_M_RREADY[6] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf1_cml_interface_3_wrapper
    nf1_cml_interface_3 (
      .glbl_rstn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .gtx_clk ( gtx_clk_125_0000Mhz ),
      .gtx_clk90 ( gtx_clk_125_0000MHz_90 ),
      .refclk ( clk_200_0000MHz ),
      .axi_aclk ( clk_125_0000MHz ),
      .m_axis_tdata ( nf1_cml_interface_4_M_AXIS_TDATA ),
      .m_axis_tstrb ( nf1_cml_interface_4_M_AXIS_TSTRB ),
      .m_axis_tuser ( nf1_cml_interface_4_M_AXIS_TUSER ),
      .m_axis_tvalid ( nf1_cml_interface_4_M_AXIS_TVALID ),
      .m_axis_tready ( nf1_cml_interface_4_M_AXIS_TREADY ),
      .m_axis_tlast ( nf1_cml_interface_4_M_AXIS_TLAST ),
      .s_axis_tdata ( nf10_bram_output_queues_0_M_AXIS_3_TDATA ),
      .s_axis_tstrb ( nf10_bram_output_queues_0_M_AXIS_3_TSTRB ),
      .s_axis_tuser ( nf10_bram_output_queues_0_M_AXIS_3_TUSER ),
      .s_axis_tvalid ( nf10_bram_output_queues_0_M_AXIS_3_TVALID ),
      .s_axis_tready ( nf10_bram_output_queues_0_M_AXIS_3_TREADY ),
      .s_axis_tlast ( nf10_bram_output_queues_0_M_AXIS_3_TLAST ),
      .rgmii_txd ( nf1_cml_interface_4_rgmii_txd ),
      .rgmii_tx_ctl ( nf1_cml_interface_4_rgmii_tx_ctl ),
      .rgmii_txc ( nf1_cml_interface_4_rgmii_txc ),
      .rgmii_rxd ( nf1_cml_interface_4_rgmii_rxd ),
      .rgmii_rx_ctl ( nf1_cml_interface_4_rgmii_rx_ctl ),
      .rgmii_rxc ( nf1_cml_interface_4_rgmii_rxc ),
      .s_axi_aclk ( clk_100_0000MHz ),
      .s_axi_aresetn ( axi_interconnect_0_M_ARESETN[7] ),
      .s_axi_awaddr ( axi_interconnect_0_M_AWADDR[255:224] ),
      .s_axi_awvalid ( axi_interconnect_0_M_AWVALID[7] ),
      .s_axi_awready ( axi_interconnect_0_M_AWREADY[7] ),
      .s_axi_wdata ( axi_interconnect_0_M_WDATA[255:224] ),
      .s_axi_wvalid ( axi_interconnect_0_M_WVALID[7] ),
      .s_axi_wready ( axi_interconnect_0_M_WREADY[7] ),
      .s_axi_bresp ( axi_interconnect_0_M_BRESP[15:14] ),
      .s_axi_bvalid ( axi_interconnect_0_M_BVALID[7] ),
      .s_axi_bready ( axi_interconnect_0_M_BREADY[7] ),
      .s_axi_araddr ( axi_interconnect_0_M_ARADDR[255:224] ),
      .s_axi_arvalid ( axi_interconnect_0_M_ARVALID[7] ),
      .s_axi_arready ( axi_interconnect_0_M_ARREADY[7] ),
      .s_axi_rdata ( axi_interconnect_0_M_RDATA[255:224] ),
      .s_axi_rresp ( axi_interconnect_0_M_RRESP[15:14] ),
      .s_axi_rvalid ( axi_interconnect_0_M_RVALID[7] ),
      .s_axi_rready ( axi_interconnect_0_M_RREADY[7] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf10_bram_output_queues_0_wrapper
    nf10_bram_output_queues_0 (
      .axi_aclk ( clk_125_0000MHz ),
      .axi_resetn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .s_axis_tdata ( packet_eval_output_0_M_AXIS_TDATA ),
      .s_axis_tstrb ( packet_eval_output_0_M_AXIS_TSTRB ),
      .s_axis_tuser ( packet_eval_output_0_M_AXIS_TUSER ),
      .s_axis_tvalid ( packet_eval_output_0_M_AXIS_TVALID ),
      .s_axis_tready ( packet_eval_output_0_M_AXIS_TREADY ),
      .s_axis_tlast ( packet_eval_output_0_M_AXIS_TLAST ),
      .m_axis_tdata_0 ( nf10_bram_output_queues_0_M_AXIS_0_TDATA ),
      .m_axis_tstrb_0 ( nf10_bram_output_queues_0_M_AXIS_0_TSTRB ),
      .m_axis_tuser_0 ( nf10_bram_output_queues_0_M_AXIS_0_TUSER ),
      .m_axis_tvalid_0 ( nf10_bram_output_queues_0_M_AXIS_0_TVALID ),
      .m_axis_tready_0 ( nf10_bram_output_queues_0_M_AXIS_0_TREADY ),
      .m_axis_tlast_0 ( nf10_bram_output_queues_0_M_AXIS_0_TLAST ),
      .m_axis_tdata_1 ( nf10_bram_output_queues_0_M_AXIS_1_TDATA ),
      .m_axis_tstrb_1 ( nf10_bram_output_queues_0_M_AXIS_1_TSTRB ),
      .m_axis_tuser_1 ( nf10_bram_output_queues_0_M_AXIS_1_TUSER ),
      .m_axis_tvalid_1 ( nf10_bram_output_queues_0_M_AXIS_1_TVALID ),
      .m_axis_tready_1 ( nf10_bram_output_queues_0_M_AXIS_1_TREADY ),
      .m_axis_tlast_1 ( nf10_bram_output_queues_0_M_AXIS_1_TLAST ),
      .m_axis_tdata_2 ( nf10_bram_output_queues_0_M_AXIS_2_TDATA ),
      .m_axis_tstrb_2 ( nf10_bram_output_queues_0_M_AXIS_2_TSTRB ),
      .m_axis_tuser_2 ( nf10_bram_output_queues_0_M_AXIS_2_TUSER ),
      .m_axis_tvalid_2 ( nf10_bram_output_queues_0_M_AXIS_2_TVALID ),
      .m_axis_tready_2 ( nf10_bram_output_queues_0_M_AXIS_2_TREADY ),
      .m_axis_tlast_2 ( nf10_bram_output_queues_0_M_AXIS_2_TLAST ),
      .m_axis_tdata_3 ( nf10_bram_output_queues_0_M_AXIS_3_TDATA ),
      .m_axis_tstrb_3 ( nf10_bram_output_queues_0_M_AXIS_3_TSTRB ),
      .m_axis_tuser_3 ( nf10_bram_output_queues_0_M_AXIS_3_TUSER ),
      .m_axis_tvalid_3 ( nf10_bram_output_queues_0_M_AXIS_3_TVALID ),
      .m_axis_tready_3 ( nf10_bram_output_queues_0_M_AXIS_3_TREADY ),
      .m_axis_tlast_3 ( nf10_bram_output_queues_0_M_AXIS_3_TLAST ),
      .m_axis_tdata_4 ( nf10_bram_output_queues_0_M_AXIS_4_TDATA ),
      .m_axis_tstrb_4 ( nf10_bram_output_queues_0_M_AXIS_4_TSTRB ),
      .m_axis_tuser_4 ( nf10_bram_output_queues_0_M_AXIS_4_TUSER ),
      .m_axis_tvalid_4 ( nf10_bram_output_queues_0_M_AXIS_4_TVALID ),
      .m_axis_tready_4 ( nf10_bram_output_queues_0_M_AXIS_4_TREADY ),
      .m_axis_tlast_4 ( nf10_bram_output_queues_0_M_AXIS_4_TLAST ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[287:256] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[8] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[287:256] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[35:32] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[8] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[8] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[287:256] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[8] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[8] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[8] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[287:256] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[17:16] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[8] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[8] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[17:16] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[8] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[8] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf10_input_arbiter_0_wrapper
    nf10_input_arbiter_0 (
      .axi_aclk ( clk_125_0000MHz ),
      .axi_resetn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .m_axis_tdata ( nf10_input_arbiter_0_M_AXIS_TDATA ),
      .m_axis_tstrb ( nf10_input_arbiter_0_M_AXIS_TSTRB ),
      .m_axis_tuser ( nf10_input_arbiter_0_M_AXIS_TUSER ),
      .m_axis_tvalid ( nf10_input_arbiter_0_M_AXIS_TVALID ),
      .m_axis_tready ( nf10_input_arbiter_0_M_AXIS_TREADY ),
      .m_axis_tlast ( nf10_input_arbiter_0_M_AXIS_TLAST ),
      .s_axis_tdata_0 ( nf1_cml_interface_1_M_AXIS_TDATA ),
      .s_axis_tstrb_0 ( nf1_cml_interface_1_M_AXIS_TSTRB ),
      .s_axis_tuser_0 ( nf1_cml_interface_1_M_AXIS_TUSER ),
      .s_axis_tvalid_0 ( nf1_cml_interface_1_M_AXIS_TVALID ),
      .s_axis_tready_0 ( nf1_cml_interface_1_M_AXIS_TREADY ),
      .s_axis_tlast_0 ( nf1_cml_interface_1_M_AXIS_TLAST ),
      .s_axis_tdata_1 ( nf1_cml_interface_2_M_AXIS_TDATA ),
      .s_axis_tstrb_1 ( nf1_cml_interface_2_M_AXIS_TSTRB ),
      .s_axis_tuser_1 ( nf1_cml_interface_2_M_AXIS_TUSER ),
      .s_axis_tvalid_1 ( nf1_cml_interface_2_M_AXIS_TVALID ),
      .s_axis_tready_1 ( nf1_cml_interface_2_M_AXIS_TREADY ),
      .s_axis_tlast_1 ( nf1_cml_interface_2_M_AXIS_TLAST ),
      .s_axis_tdata_2 ( nf1_cml_interface_3_M_AXIS_TDATA ),
      .s_axis_tstrb_2 ( nf1_cml_interface_3_M_AXIS_TSTRB ),
      .s_axis_tuser_2 ( nf1_cml_interface_3_M_AXIS_TUSER ),
      .s_axis_tvalid_2 ( nf1_cml_interface_3_M_AXIS_TVALID ),
      .s_axis_tready_2 ( nf1_cml_interface_3_M_AXIS_TREADY ),
      .s_axis_tlast_2 ( nf1_cml_interface_3_M_AXIS_TLAST ),
      .s_axis_tdata_3 ( nf1_cml_interface_4_M_AXIS_TDATA ),
      .s_axis_tstrb_3 ( nf1_cml_interface_4_M_AXIS_TSTRB ),
      .s_axis_tuser_3 ( nf1_cml_interface_4_M_AXIS_TUSER ),
      .s_axis_tvalid_3 ( nf1_cml_interface_4_M_AXIS_TVALID ),
      .s_axis_tready_3 ( nf1_cml_interface_4_M_AXIS_TREADY ),
      .s_axis_tlast_3 ( nf1_cml_interface_4_M_AXIS_TLAST ),
      .s_axis_tdata_4 ( dma_0_M_AXIS_TDATA ),
      .s_axis_tstrb_4 ( dma_0_M_AXIS_TSTRB ),
      .s_axis_tuser_4 ( dma_0_M_AXIS_TUSER ),
      .s_axis_tvalid_4 ( dma_0_M_AXIS_TVALID ),
      .s_axis_tready_4 ( dma_0_M_AXIS_TREADY ),
      .s_axis_tlast_4 ( dma_0_M_AXIS_TLAST ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[319:288] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[9] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[319:288] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[39:36] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[9] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[9] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[319:288] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[9] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[9] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[9] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[319:288] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[19:18] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[9] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[9] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[19:18] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[9] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[9] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_dma_0_wrapper
    dma_0 (
      .reset_n ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .pcie_clk_p ( dma_0_pcie_clk_p ),
      .pcie_clk_n ( dma_0_pcie_clk_n ),
      .pci_exp_0_txp ( dma_0_pci_exp_0_txp ),
      .pci_exp_0_txn ( dma_0_pci_exp_0_txn ),
      .pci_exp_0_rxp ( dma_0_pci_exp_0_rxp ),
      .pci_exp_0_rxn ( dma_0_pci_exp_0_rxn ),
      .pci_exp_1_txp ( dma_0_pci_exp_1_txp ),
      .pci_exp_1_txn ( dma_0_pci_exp_1_txn ),
      .pci_exp_1_rxp ( dma_0_pci_exp_1_rxp ),
      .pci_exp_1_rxn ( dma_0_pci_exp_1_rxn ),
      .pci_exp_2_txp ( dma_0_pci_exp_2_txp ),
      .pci_exp_2_txn ( dma_0_pci_exp_2_txn ),
      .pci_exp_2_rxp ( dma_0_pci_exp_2_rxp ),
      .pci_exp_2_rxn ( dma_0_pci_exp_2_rxn ),
      .pci_exp_3_txp ( dma_0_pci_exp_3_txp ),
      .pci_exp_3_txn ( dma_0_pci_exp_3_txn ),
      .pci_exp_3_rxp ( dma_0_pci_exp_3_rxp ),
      .pci_exp_3_rxn ( dma_0_pci_exp_3_rxn ),
      .M_AXI_LITE_ACLK ( clk_100_0000MHz ),
      .M_AXI_LITE_ARESETN ( axi_interconnect_0_S_ARESETN[1] ),
      .M_AXI_LITE_AWADDR ( axi_interconnect_0_S_AWADDR[63:32] ),
      .M_AXI_LITE_AWVALID ( axi_interconnect_0_S_AWVALID[1] ),
      .M_AXI_LITE_AWREADY ( axi_interconnect_0_S_AWREADY[1] ),
      .M_AXI_LITE_WDATA ( axi_interconnect_0_S_WDATA[63:32] ),
      .M_AXI_LITE_WSTRB ( axi_interconnect_0_S_WSTRB[7:4] ),
      .M_AXI_LITE_WVALID ( axi_interconnect_0_S_WVALID[1] ),
      .M_AXI_LITE_WREADY ( axi_interconnect_0_S_WREADY[1] ),
      .M_AXI_LITE_BRESP ( axi_interconnect_0_S_BRESP[3:2] ),
      .M_AXI_LITE_BVALID ( axi_interconnect_0_S_BVALID[1] ),
      .M_AXI_LITE_BREADY ( axi_interconnect_0_S_BREADY[1] ),
      .M_AXI_LITE_ARADDR ( axi_interconnect_0_S_ARADDR[63:32] ),
      .M_AXI_LITE_ARVALID ( axi_interconnect_0_S_ARVALID[1] ),
      .M_AXI_LITE_ARREADY ( axi_interconnect_0_S_ARREADY[1] ),
      .M_AXI_LITE_RDATA ( axi_interconnect_0_S_RDATA[63:32] ),
      .M_AXI_LITE_RRESP ( axi_interconnect_0_S_RRESP[3:2] ),
      .M_AXI_LITE_RVALID ( axi_interconnect_0_S_RVALID[1] ),
      .M_AXI_LITE_RREADY ( axi_interconnect_0_S_RREADY[1] ),
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[10] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[351:320] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[10] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[10] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[351:320] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[43:40] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[10] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[10] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[21:20] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[10] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[10] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[351:320] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[10] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[10] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[351:320] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[21:20] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[10] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[10] ),
      .M_AXIS_ACLK ( clk_125_0000MHz ),
      .M_AXIS_TDATA ( dma_0_M_AXIS_TDATA ),
      .M_AXIS_TSTRB ( dma_0_M_AXIS_TSTRB ),
      .M_AXIS_TUSER ( dma_0_M_AXIS_TUSER ),
      .M_AXIS_TVALID ( dma_0_M_AXIS_TVALID ),
      .M_AXIS_TREADY ( dma_0_M_AXIS_TREADY ),
      .M_AXIS_TLAST ( dma_0_M_AXIS_TLAST ),
      .S_AXIS_ACLK ( clk_125_0000MHz ),
      .S_AXIS_TDATA ( nf10_bram_output_queues_0_M_AXIS_4_TDATA ),
      .S_AXIS_TSTRB ( nf10_bram_output_queues_0_M_AXIS_4_TSTRB ),
      .S_AXIS_TUSER ( nf10_bram_output_queues_0_M_AXIS_4_TUSER ),
      .S_AXIS_TVALID ( nf10_bram_output_queues_0_M_AXIS_4_TVALID ),
      .S_AXIS_TREADY ( nf10_bram_output_queues_0_M_AXIS_4_TREADY ),
      .S_AXIS_TLAST ( nf10_bram_output_queues_0_M_AXIS_4_TLAST )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_clock_generator_1_wrapper
    clock_generator_1 (
      .CLKIN ( CLK ),
      .CLKOUT0 ( clock_generator_1_CLKOUT0 ),
      .CLKOUT1 (  ),
      .CLKOUT2 (  ),
      .CLKOUT3 (  ),
      .CLKOUT4 (  ),
      .CLKOUT5 (  ),
      .CLKOUT6 (  ),
      .CLKOUT7 (  ),
      .CLKOUT8 (  ),
      .CLKOUT9 (  ),
      .CLKOUT10 (  ),
      .CLKOUT11 (  ),
      .CLKOUT12 (  ),
      .CLKOUT13 (  ),
      .CLKOUT14 (  ),
      .CLKOUT15 (  ),
      .CLKFBIN ( net_gnd0 ),
      .CLKFBOUT (  ),
      .PSCLK ( net_gnd0 ),
      .PSEN ( net_gnd0 ),
      .PSINCDEC ( net_gnd0 ),
      .PSDONE (  ),
      .RST ( RESET ),
      .LOCKED ( clk_gen_pre_lock )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_mdio_ctrl_0_wrapper
    mdio_ctrl_0 (
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[11] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[383:352] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[11] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[11] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[383:352] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[47:44] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[11] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[11] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[23:22] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[11] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[11] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[383:352] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[11] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[11] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[383:352] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[23:22] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[11] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[11] ),
      .mdc ( mdc ),
      .mdio ( mdio ),
      .phy_rstn ( mdio_ctrl_0_phy_rstn )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_axi_gpio_bpi_if_wrapper
    axi_gpio_bpi_if (
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[12] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[392:384] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[12] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[12] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[415:384] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[51:48] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[12] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[12] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[25:24] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[12] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[12] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[392:384] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[12] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[12] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[415:384] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[25:24] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[12] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[12] ),
      .IP2INTC_Irpt (  ),
      .GPIO_IO_I ( axi_gpio_0_GPIO_IO_I ),
      .GPIO_IO_O ( axi_gpio_0_GPIO_IO_O ),
      .GPIO_IO_T ( axi_gpio_0_GPIO_IO_T ),
      .GPIO2_IO_I ( axi_gpio_0_GPIO2_IO_I ),
      .GPIO2_IO_O ( axi_gpio_0_GPIO2_IO_O ),
      .GPIO2_IO_T ( axi_gpio_0_GPIO2_IO_T )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_axi_hwicap_0_wrapper
    axi_hwicap_0 (
      .ICAP_Clk ( clk_100_0000MHz ),
      .EOS_IN ( net_gnd0 ),
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( axi_interconnect_0_M_ARESETN[13] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[424:416] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[13] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[13] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[447:416] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[55:52] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[13] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[13] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[27:26] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[13] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[13] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[424:416] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[13] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[13] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[447:416] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[27:26] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[13] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[13] ),
      .IP2INTC_Irpt (  )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_nf10_identifier_0_wrapper
    nf10_identifier_0 (
      .S_AXI_ACLK ( clk_100_0000MHz ),
      .S_AXI_ARESETN ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .S_AXI_AWADDR ( axi_interconnect_0_M_AWADDR[479:448] ),
      .S_AXI_AWVALID ( axi_interconnect_0_M_AWVALID[14] ),
      .S_AXI_WDATA ( axi_interconnect_0_M_WDATA[479:448] ),
      .S_AXI_WSTRB ( axi_interconnect_0_M_WSTRB[59:56] ),
      .S_AXI_WVALID ( axi_interconnect_0_M_WVALID[14] ),
      .S_AXI_BREADY ( axi_interconnect_0_M_BREADY[14] ),
      .S_AXI_ARADDR ( axi_interconnect_0_M_ARADDR[479:448] ),
      .S_AXI_ARVALID ( axi_interconnect_0_M_ARVALID[14] ),
      .S_AXI_RREADY ( axi_interconnect_0_M_RREADY[14] ),
      .S_AXI_ARREADY ( axi_interconnect_0_M_ARREADY[14] ),
      .S_AXI_RDATA ( axi_interconnect_0_M_RDATA[479:448] ),
      .S_AXI_RRESP ( axi_interconnect_0_M_RRESP[29:28] ),
      .S_AXI_RVALID ( axi_interconnect_0_M_RVALID[14] ),
      .S_AXI_WREADY ( axi_interconnect_0_M_WREADY[14] ),
      .S_AXI_BRESP ( axi_interconnect_0_M_BRESP[29:28] ),
      .S_AXI_BVALID ( axi_interconnect_0_M_BVALID[14] ),
      .S_AXI_AWREADY ( axi_interconnect_0_M_AWREADY[14] )
    );

  (* BOX_TYPE = "user_black_box" *)
  system_packet_eval_output_0_wrapper
    packet_eval_output_0 (
      .s_axi_aclk ( clk_125_0000MHz ),
      .s_axi_aresetn ( proc_sys_reset_0_Peripheral_aresetn[0] ),
      .s_axi_awaddr ( axi_interconnect_0_M_AWADDR[511:480] ),
      .s_axi_awvalid ( axi_interconnect_0_M_AWVALID[15] ),
      .s_axi_wdata ( axi_interconnect_0_M_WDATA[511:480] ),
      .s_axi_wstrb ( axi_interconnect_0_M_WSTRB[63:60] ),
      .s_axi_wvalid ( axi_interconnect_0_M_WVALID[15] ),
      .s_axi_bready ( axi_interconnect_0_M_BREADY[15] ),
      .s_axi_araddr ( axi_interconnect_0_M_ARADDR[511:480] ),
      .s_axi_arvalid ( axi_interconnect_0_M_ARVALID[15] ),
      .s_axi_rready ( axi_interconnect_0_M_RREADY[15] ),
      .s_axi_arready ( axi_interconnect_0_M_ARREADY[15] ),
      .s_axi_rdata ( axi_interconnect_0_M_RDATA[511:480] ),
      .s_axi_rresp ( axi_interconnect_0_M_RRESP[31:30] ),
      .s_axi_rvalid ( axi_interconnect_0_M_RVALID[15] ),
      .s_axi_wready ( axi_interconnect_0_M_WREADY[15] ),
      .s_axi_bresp ( axi_interconnect_0_M_BRESP[31:30] ),
      .s_axi_bvalid ( axi_interconnect_0_M_BVALID[15] ),
      .s_axi_awready ( axi_interconnect_0_M_AWREADY[15] ),
      .m_axis_tdata ( packet_eval_output_0_M_AXIS_TDATA ),
      .m_axis_tstrb ( packet_eval_output_0_M_AXIS_TSTRB ),
      .m_axis_tuser ( packet_eval_output_0_M_AXIS_TUSER ),
      .m_axis_tvalid ( packet_eval_output_0_M_AXIS_TVALID ),
      .m_axis_tready ( packet_eval_output_0_M_AXIS_TREADY ),
      .m_axis_tlast ( packet_eval_output_0_M_AXIS_TLAST ),
      .s_axis_tdata ( nf10_input_arbiter_0_M_AXIS_TDATA ),
      .s_axis_tstrb ( nf10_input_arbiter_0_M_AXIS_TSTRB ),
      .s_axis_tuser ( nf10_input_arbiter_0_M_AXIS_TUSER ),
      .s_axis_tvalid ( nf10_input_arbiter_0_M_AXIS_TVALID ),
      .s_axis_tready ( nf10_input_arbiter_0_M_AXIS_TREADY ),
      .s_axis_tlast ( nf10_input_arbiter_0_M_AXIS_TLAST )
    );

  IBUFGDS
    ibufgds_0 (
      .I ( clk_in_p ),
      .IB ( clk_in_n ),
      .O ( CLK )
    );

  IOBUF
    iobuf_1 (
      .I ( axi_gpio_0_GPIO_IO_O[29] ),
      .IO ( bpi_addr_cmd[29] ),
      .O ( axi_gpio_0_GPIO_IO_I[29] ),
      .T ( axi_gpio_0_GPIO_IO_T[29] )
    );

  IOBUF
    iobuf_2 (
      .I ( axi_gpio_0_GPIO_IO_O[28] ),
      .IO ( bpi_addr_cmd[28] ),
      .O ( axi_gpio_0_GPIO_IO_I[28] ),
      .T ( axi_gpio_0_GPIO_IO_T[28] )
    );

  IOBUF
    iobuf_3 (
      .I ( axi_gpio_0_GPIO_IO_O[27] ),
      .IO ( bpi_addr_cmd[27] ),
      .O ( axi_gpio_0_GPIO_IO_I[27] ),
      .T ( axi_gpio_0_GPIO_IO_T[27] )
    );

  IOBUF
    iobuf_4 (
      .I ( axi_gpio_0_GPIO_IO_O[26] ),
      .IO ( bpi_addr_cmd[26] ),
      .O ( axi_gpio_0_GPIO_IO_I[26] ),
      .T ( axi_gpio_0_GPIO_IO_T[26] )
    );

  IOBUF
    iobuf_5 (
      .I ( axi_gpio_0_GPIO_IO_O[25] ),
      .IO ( bpi_addr_cmd[25] ),
      .O ( axi_gpio_0_GPIO_IO_I[25] ),
      .T ( axi_gpio_0_GPIO_IO_T[25] )
    );

  IOBUF
    iobuf_6 (
      .I ( axi_gpio_0_GPIO_IO_O[24] ),
      .IO ( bpi_addr_cmd[24] ),
      .O ( axi_gpio_0_GPIO_IO_I[24] ),
      .T ( axi_gpio_0_GPIO_IO_T[24] )
    );

  IOBUF
    iobuf_7 (
      .I ( axi_gpio_0_GPIO_IO_O[23] ),
      .IO ( bpi_addr_cmd[23] ),
      .O ( axi_gpio_0_GPIO_IO_I[23] ),
      .T ( axi_gpio_0_GPIO_IO_T[23] )
    );

  IOBUF
    iobuf_8 (
      .I ( axi_gpio_0_GPIO_IO_O[22] ),
      .IO ( bpi_addr_cmd[22] ),
      .O ( axi_gpio_0_GPIO_IO_I[22] ),
      .T ( axi_gpio_0_GPIO_IO_T[22] )
    );

  IOBUF
    iobuf_9 (
      .I ( axi_gpio_0_GPIO_IO_O[21] ),
      .IO ( bpi_addr_cmd[21] ),
      .O ( axi_gpio_0_GPIO_IO_I[21] ),
      .T ( axi_gpio_0_GPIO_IO_T[21] )
    );

  IOBUF
    iobuf_10 (
      .I ( axi_gpio_0_GPIO_IO_O[20] ),
      .IO ( bpi_addr_cmd[20] ),
      .O ( axi_gpio_0_GPIO_IO_I[20] ),
      .T ( axi_gpio_0_GPIO_IO_T[20] )
    );

  IOBUF
    iobuf_11 (
      .I ( axi_gpio_0_GPIO_IO_O[19] ),
      .IO ( bpi_addr_cmd[19] ),
      .O ( axi_gpio_0_GPIO_IO_I[19] ),
      .T ( axi_gpio_0_GPIO_IO_T[19] )
    );

  IOBUF
    iobuf_12 (
      .I ( axi_gpio_0_GPIO_IO_O[18] ),
      .IO ( bpi_addr_cmd[18] ),
      .O ( axi_gpio_0_GPIO_IO_I[18] ),
      .T ( axi_gpio_0_GPIO_IO_T[18] )
    );

  IOBUF
    iobuf_13 (
      .I ( axi_gpio_0_GPIO_IO_O[17] ),
      .IO ( bpi_addr_cmd[17] ),
      .O ( axi_gpio_0_GPIO_IO_I[17] ),
      .T ( axi_gpio_0_GPIO_IO_T[17] )
    );

  IOBUF
    iobuf_14 (
      .I ( axi_gpio_0_GPIO_IO_O[16] ),
      .IO ( bpi_addr_cmd[16] ),
      .O ( axi_gpio_0_GPIO_IO_I[16] ),
      .T ( axi_gpio_0_GPIO_IO_T[16] )
    );

  IOBUF
    iobuf_15 (
      .I ( axi_gpio_0_GPIO_IO_O[15] ),
      .IO ( bpi_addr_cmd[15] ),
      .O ( axi_gpio_0_GPIO_IO_I[15] ),
      .T ( axi_gpio_0_GPIO_IO_T[15] )
    );

  IOBUF
    iobuf_16 (
      .I ( axi_gpio_0_GPIO_IO_O[14] ),
      .IO ( bpi_addr_cmd[14] ),
      .O ( axi_gpio_0_GPIO_IO_I[14] ),
      .T ( axi_gpio_0_GPIO_IO_T[14] )
    );

  IOBUF
    iobuf_17 (
      .I ( axi_gpio_0_GPIO_IO_O[13] ),
      .IO ( bpi_addr_cmd[13] ),
      .O ( axi_gpio_0_GPIO_IO_I[13] ),
      .T ( axi_gpio_0_GPIO_IO_T[13] )
    );

  IOBUF
    iobuf_18 (
      .I ( axi_gpio_0_GPIO_IO_O[12] ),
      .IO ( bpi_addr_cmd[12] ),
      .O ( axi_gpio_0_GPIO_IO_I[12] ),
      .T ( axi_gpio_0_GPIO_IO_T[12] )
    );

  IOBUF
    iobuf_19 (
      .I ( axi_gpio_0_GPIO_IO_O[11] ),
      .IO ( bpi_addr_cmd[11] ),
      .O ( axi_gpio_0_GPIO_IO_I[11] ),
      .T ( axi_gpio_0_GPIO_IO_T[11] )
    );

  IOBUF
    iobuf_20 (
      .I ( axi_gpio_0_GPIO_IO_O[10] ),
      .IO ( bpi_addr_cmd[10] ),
      .O ( axi_gpio_0_GPIO_IO_I[10] ),
      .T ( axi_gpio_0_GPIO_IO_T[10] )
    );

  IOBUF
    iobuf_21 (
      .I ( axi_gpio_0_GPIO_IO_O[9] ),
      .IO ( bpi_addr_cmd[9] ),
      .O ( axi_gpio_0_GPIO_IO_I[9] ),
      .T ( axi_gpio_0_GPIO_IO_T[9] )
    );

  IOBUF
    iobuf_22 (
      .I ( axi_gpio_0_GPIO_IO_O[8] ),
      .IO ( bpi_addr_cmd[8] ),
      .O ( axi_gpio_0_GPIO_IO_I[8] ),
      .T ( axi_gpio_0_GPIO_IO_T[8] )
    );

  IOBUF
    iobuf_23 (
      .I ( axi_gpio_0_GPIO_IO_O[7] ),
      .IO ( bpi_addr_cmd[7] ),
      .O ( axi_gpio_0_GPIO_IO_I[7] ),
      .T ( axi_gpio_0_GPIO_IO_T[7] )
    );

  IOBUF
    iobuf_24 (
      .I ( axi_gpio_0_GPIO_IO_O[6] ),
      .IO ( bpi_addr_cmd[6] ),
      .O ( axi_gpio_0_GPIO_IO_I[6] ),
      .T ( axi_gpio_0_GPIO_IO_T[6] )
    );

  IOBUF
    iobuf_25 (
      .I ( axi_gpio_0_GPIO_IO_O[5] ),
      .IO ( bpi_addr_cmd[5] ),
      .O ( axi_gpio_0_GPIO_IO_I[5] ),
      .T ( axi_gpio_0_GPIO_IO_T[5] )
    );

  IOBUF
    iobuf_26 (
      .I ( axi_gpio_0_GPIO_IO_O[4] ),
      .IO ( bpi_addr_cmd[4] ),
      .O ( axi_gpio_0_GPIO_IO_I[4] ),
      .T ( axi_gpio_0_GPIO_IO_T[4] )
    );

  IOBUF
    iobuf_27 (
      .I ( axi_gpio_0_GPIO_IO_O[3] ),
      .IO ( bpi_addr_cmd[3] ),
      .O ( axi_gpio_0_GPIO_IO_I[3] ),
      .T ( axi_gpio_0_GPIO_IO_T[3] )
    );

  IOBUF
    iobuf_28 (
      .I ( axi_gpio_0_GPIO_IO_O[2] ),
      .IO ( bpi_addr_cmd[2] ),
      .O ( axi_gpio_0_GPIO_IO_I[2] ),
      .T ( axi_gpio_0_GPIO_IO_T[2] )
    );

  IOBUF
    iobuf_29 (
      .I ( axi_gpio_0_GPIO_IO_O[1] ),
      .IO ( bpi_addr_cmd[1] ),
      .O ( axi_gpio_0_GPIO_IO_I[1] ),
      .T ( axi_gpio_0_GPIO_IO_T[1] )
    );

  IOBUF
    iobuf_30 (
      .I ( axi_gpio_0_GPIO_IO_O[0] ),
      .IO ( bpi_addr_cmd[0] ),
      .O ( axi_gpio_0_GPIO_IO_I[0] ),
      .T ( axi_gpio_0_GPIO_IO_T[0] )
    );

  IOBUF
    iobuf_31 (
      .I ( axi_gpio_0_GPIO2_IO_O[15] ),
      .IO ( bpi_data[15] ),
      .O ( axi_gpio_0_GPIO2_IO_I[15] ),
      .T ( axi_gpio_0_GPIO2_IO_T[15] )
    );

  IOBUF
    iobuf_32 (
      .I ( axi_gpio_0_GPIO2_IO_O[14] ),
      .IO ( bpi_data[14] ),
      .O ( axi_gpio_0_GPIO2_IO_I[14] ),
      .T ( axi_gpio_0_GPIO2_IO_T[14] )
    );

  IOBUF
    iobuf_33 (
      .I ( axi_gpio_0_GPIO2_IO_O[13] ),
      .IO ( bpi_data[13] ),
      .O ( axi_gpio_0_GPIO2_IO_I[13] ),
      .T ( axi_gpio_0_GPIO2_IO_T[13] )
    );

  IOBUF
    iobuf_34 (
      .I ( axi_gpio_0_GPIO2_IO_O[12] ),
      .IO ( bpi_data[12] ),
      .O ( axi_gpio_0_GPIO2_IO_I[12] ),
      .T ( axi_gpio_0_GPIO2_IO_T[12] )
    );

  IOBUF
    iobuf_35 (
      .I ( axi_gpio_0_GPIO2_IO_O[11] ),
      .IO ( bpi_data[11] ),
      .O ( axi_gpio_0_GPIO2_IO_I[11] ),
      .T ( axi_gpio_0_GPIO2_IO_T[11] )
    );

  IOBUF
    iobuf_36 (
      .I ( axi_gpio_0_GPIO2_IO_O[10] ),
      .IO ( bpi_data[10] ),
      .O ( axi_gpio_0_GPIO2_IO_I[10] ),
      .T ( axi_gpio_0_GPIO2_IO_T[10] )
    );

  IOBUF
    iobuf_37 (
      .I ( axi_gpio_0_GPIO2_IO_O[9] ),
      .IO ( bpi_data[9] ),
      .O ( axi_gpio_0_GPIO2_IO_I[9] ),
      .T ( axi_gpio_0_GPIO2_IO_T[9] )
    );

  IOBUF
    iobuf_38 (
      .I ( axi_gpio_0_GPIO2_IO_O[8] ),
      .IO ( bpi_data[8] ),
      .O ( axi_gpio_0_GPIO2_IO_I[8] ),
      .T ( axi_gpio_0_GPIO2_IO_T[8] )
    );

  IOBUF
    iobuf_39 (
      .I ( axi_gpio_0_GPIO2_IO_O[7] ),
      .IO ( bpi_data[7] ),
      .O ( axi_gpio_0_GPIO2_IO_I[7] ),
      .T ( axi_gpio_0_GPIO2_IO_T[7] )
    );

  IOBUF
    iobuf_40 (
      .I ( axi_gpio_0_GPIO2_IO_O[6] ),
      .IO ( bpi_data[6] ),
      .O ( axi_gpio_0_GPIO2_IO_I[6] ),
      .T ( axi_gpio_0_GPIO2_IO_T[6] )
    );

  IOBUF
    iobuf_41 (
      .I ( axi_gpio_0_GPIO2_IO_O[5] ),
      .IO ( bpi_data[5] ),
      .O ( axi_gpio_0_GPIO2_IO_I[5] ),
      .T ( axi_gpio_0_GPIO2_IO_T[5] )
    );

  IOBUF
    iobuf_42 (
      .I ( axi_gpio_0_GPIO2_IO_O[4] ),
      .IO ( bpi_data[4] ),
      .O ( axi_gpio_0_GPIO2_IO_I[4] ),
      .T ( axi_gpio_0_GPIO2_IO_T[4] )
    );

  IOBUF
    iobuf_43 (
      .I ( axi_gpio_0_GPIO2_IO_O[3] ),
      .IO ( bpi_data[3] ),
      .O ( axi_gpio_0_GPIO2_IO_I[3] ),
      .T ( axi_gpio_0_GPIO2_IO_T[3] )
    );

  IOBUF
    iobuf_44 (
      .I ( axi_gpio_0_GPIO2_IO_O[2] ),
      .IO ( bpi_data[2] ),
      .O ( axi_gpio_0_GPIO2_IO_I[2] ),
      .T ( axi_gpio_0_GPIO2_IO_T[2] )
    );

  IOBUF
    iobuf_45 (
      .I ( axi_gpio_0_GPIO2_IO_O[1] ),
      .IO ( bpi_data[1] ),
      .O ( axi_gpio_0_GPIO2_IO_I[1] ),
      .T ( axi_gpio_0_GPIO2_IO_T[1] )
    );

  IOBUF
    iobuf_46 (
      .I ( axi_gpio_0_GPIO2_IO_O[0] ),
      .IO ( bpi_data[0] ),
      .O ( axi_gpio_0_GPIO2_IO_I[0] ),
      .T ( axi_gpio_0_GPIO2_IO_T[0] )
    );

endmodule

module system_proc_sys_reset_0_wrapper
  (
    Slowest_sync_clk,
    Ext_Reset_In,
    Aux_Reset_In,
    MB_Debug_Sys_Rst,
    Core_Reset_Req_0,
    Chip_Reset_Req_0,
    System_Reset_Req_0,
    Core_Reset_Req_1,
    Chip_Reset_Req_1,
    System_Reset_Req_1,
    Dcm_locked,
    RstcPPCresetcore_0,
    RstcPPCresetchip_0,
    RstcPPCresetsys_0,
    RstcPPCresetcore_1,
    RstcPPCresetchip_1,
    RstcPPCresetsys_1,
    MB_Reset,
    Bus_Struct_Reset,
    Peripheral_Reset,
    Interconnect_aresetn,
    Peripheral_aresetn
  );
  input Slowest_sync_clk;
  input Ext_Reset_In;
  input Aux_Reset_In;
  input MB_Debug_Sys_Rst;
  input Core_Reset_Req_0;
  input Chip_Reset_Req_0;
  input System_Reset_Req_0;
  input Core_Reset_Req_1;
  input Chip_Reset_Req_1;
  input System_Reset_Req_1;
  input Dcm_locked;
  output RstcPPCresetcore_0;
  output RstcPPCresetchip_0;
  output RstcPPCresetsys_0;
  output RstcPPCresetcore_1;
  output RstcPPCresetchip_1;
  output RstcPPCresetsys_1;
  output MB_Reset;
  output [0:0] Bus_Struct_Reset;
  output [0:0] Peripheral_Reset;
  output [0:0] Interconnect_aresetn;
  output [0:0] Peripheral_aresetn;
endmodule

module system_microblaze_0_intc_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    Intr,
    Irq,
    Interrupt_address,
    Processor_ack,
    Processor_clk,
    Processor_rst,
    Interrupt_address_in,
    Processor_ack_out
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [8:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [8:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  input [2:0] Intr;
  output Irq;
  output [31:0] Interrupt_address;
  input [1:0] Processor_ack;
  input Processor_clk;
  input Processor_rst;
  input [31:0] Interrupt_address_in;
  output [1:0] Processor_ack_out;
endmodule

module system_microblaze_0_ilmb_wrapper
  (
    LMB_Clk,
    SYS_Rst,
    LMB_Rst,
    M_ABus,
    M_ReadStrobe,
    M_WriteStrobe,
    M_AddrStrobe,
    M_DBus,
    M_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE,
    LMB_ABus,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_AddrStrobe,
    LMB_ReadDBus,
    LMB_WriteDBus,
    LMB_Ready,
    LMB_Wait,
    LMB_UE,
    LMB_CE,
    LMB_BE
  );
  input LMB_Clk;
  input SYS_Rst;
  output LMB_Rst;
  input [0:31] M_ABus;
  input M_ReadStrobe;
  input M_WriteStrobe;
  input M_AddrStrobe;
  input [0:31] M_DBus;
  input [0:3] M_BE;
  input [0:31] Sl_DBus;
  input [0:0] Sl_Ready;
  input [0:0] Sl_Wait;
  input [0:0] Sl_UE;
  input [0:0] Sl_CE;
  output [0:31] LMB_ABus;
  output LMB_ReadStrobe;
  output LMB_WriteStrobe;
  output LMB_AddrStrobe;
  output [0:31] LMB_ReadDBus;
  output [0:31] LMB_WriteDBus;
  output LMB_Ready;
  output LMB_Wait;
  output LMB_UE;
  output LMB_CE;
  output [0:3] LMB_BE;
endmodule

module system_microblaze_0_i_bram_ctrl_wrapper
  (
    LMB_Clk,
    LMB_Rst,
    LMB_ABus,
    LMB_WriteDBus,
    LMB_AddrStrobe,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE,
    LMB1_ABus,
    LMB1_WriteDBus,
    LMB1_AddrStrobe,
    LMB1_ReadStrobe,
    LMB1_WriteStrobe,
    LMB1_BE,
    Sl1_DBus,
    Sl1_Ready,
    Sl1_Wait,
    Sl1_UE,
    Sl1_CE,
    LMB2_ABus,
    LMB2_WriteDBus,
    LMB2_AddrStrobe,
    LMB2_ReadStrobe,
    LMB2_WriteStrobe,
    LMB2_BE,
    Sl2_DBus,
    Sl2_Ready,
    Sl2_Wait,
    Sl2_UE,
    Sl2_CE,
    LMB3_ABus,
    LMB3_WriteDBus,
    LMB3_AddrStrobe,
    LMB3_ReadStrobe,
    LMB3_WriteStrobe,
    LMB3_BE,
    Sl3_DBus,
    Sl3_Ready,
    Sl3_Wait,
    Sl3_UE,
    Sl3_CE,
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    Interrupt,
    UE,
    CE,
    SPLB_CTRL_PLB_ABus,
    SPLB_CTRL_PLB_PAValid,
    SPLB_CTRL_PLB_masterID,
    SPLB_CTRL_PLB_RNW,
    SPLB_CTRL_PLB_BE,
    SPLB_CTRL_PLB_size,
    SPLB_CTRL_PLB_type,
    SPLB_CTRL_PLB_wrDBus,
    SPLB_CTRL_Sl_addrAck,
    SPLB_CTRL_Sl_SSize,
    SPLB_CTRL_Sl_wait,
    SPLB_CTRL_Sl_rearbitrate,
    SPLB_CTRL_Sl_wrDAck,
    SPLB_CTRL_Sl_wrComp,
    SPLB_CTRL_Sl_rdDBus,
    SPLB_CTRL_Sl_rdDAck,
    SPLB_CTRL_Sl_rdComp,
    SPLB_CTRL_Sl_MBusy,
    SPLB_CTRL_Sl_MWrErr,
    SPLB_CTRL_Sl_MRdErr,
    SPLB_CTRL_PLB_UABus,
    SPLB_CTRL_PLB_SAValid,
    SPLB_CTRL_PLB_rdPrim,
    SPLB_CTRL_PLB_wrPrim,
    SPLB_CTRL_PLB_abort,
    SPLB_CTRL_PLB_busLock,
    SPLB_CTRL_PLB_MSize,
    SPLB_CTRL_PLB_lockErr,
    SPLB_CTRL_PLB_wrBurst,
    SPLB_CTRL_PLB_rdBurst,
    SPLB_CTRL_PLB_wrPendReq,
    SPLB_CTRL_PLB_rdPendReq,
    SPLB_CTRL_PLB_wrPendPri,
    SPLB_CTRL_PLB_rdPendPri,
    SPLB_CTRL_PLB_reqPri,
    SPLB_CTRL_PLB_TAttribute,
    SPLB_CTRL_Sl_wrBTerm,
    SPLB_CTRL_Sl_rdWdAddr,
    SPLB_CTRL_Sl_rdBTerm,
    SPLB_CTRL_Sl_MIRQ,
    S_AXI_CTRL_ACLK,
    S_AXI_CTRL_ARESETN,
    S_AXI_CTRL_AWADDR,
    S_AXI_CTRL_AWVALID,
    S_AXI_CTRL_AWREADY,
    S_AXI_CTRL_WDATA,
    S_AXI_CTRL_WSTRB,
    S_AXI_CTRL_WVALID,
    S_AXI_CTRL_WREADY,
    S_AXI_CTRL_BRESP,
    S_AXI_CTRL_BVALID,
    S_AXI_CTRL_BREADY,
    S_AXI_CTRL_ARADDR,
    S_AXI_CTRL_ARVALID,
    S_AXI_CTRL_ARREADY,
    S_AXI_CTRL_RDATA,
    S_AXI_CTRL_RRESP,
    S_AXI_CTRL_RVALID,
    S_AXI_CTRL_RREADY
  );
  input LMB_Clk;
  input LMB_Rst;
  input [0:31] LMB_ABus;
  input [0:31] LMB_WriteDBus;
  input LMB_AddrStrobe;
  input LMB_ReadStrobe;
  input LMB_WriteStrobe;
  input [0:3] LMB_BE;
  output [0:31] Sl_DBus;
  output Sl_Ready;
  output Sl_Wait;
  output Sl_UE;
  output Sl_CE;
  input [0:31] LMB1_ABus;
  input [0:31] LMB1_WriteDBus;
  input LMB1_AddrStrobe;
  input LMB1_ReadStrobe;
  input LMB1_WriteStrobe;
  input [0:3] LMB1_BE;
  output [0:31] Sl1_DBus;
  output Sl1_Ready;
  output Sl1_Wait;
  output Sl1_UE;
  output Sl1_CE;
  input [0:31] LMB2_ABus;
  input [0:31] LMB2_WriteDBus;
  input LMB2_AddrStrobe;
  input LMB2_ReadStrobe;
  input LMB2_WriteStrobe;
  input [0:3] LMB2_BE;
  output [0:31] Sl2_DBus;
  output Sl2_Ready;
  output Sl2_Wait;
  output Sl2_UE;
  output Sl2_CE;
  input [0:31] LMB3_ABus;
  input [0:31] LMB3_WriteDBus;
  input LMB3_AddrStrobe;
  input LMB3_ReadStrobe;
  input LMB3_WriteStrobe;
  input [0:3] LMB3_BE;
  output [0:31] Sl3_DBus;
  output Sl3_Ready;
  output Sl3_Wait;
  output Sl3_UE;
  output Sl3_CE;
  output BRAM_Rst_A;
  output BRAM_Clk_A;
  output BRAM_EN_A;
  output [0:3] BRAM_WEN_A;
  output [0:31] BRAM_Addr_A;
  input [0:31] BRAM_Din_A;
  output [0:31] BRAM_Dout_A;
  output Interrupt;
  output UE;
  output CE;
  input [0:31] SPLB_CTRL_PLB_ABus;
  input SPLB_CTRL_PLB_PAValid;
  input [0:0] SPLB_CTRL_PLB_masterID;
  input SPLB_CTRL_PLB_RNW;
  input [0:3] SPLB_CTRL_PLB_BE;
  input [0:3] SPLB_CTRL_PLB_size;
  input [0:2] SPLB_CTRL_PLB_type;
  input [0:31] SPLB_CTRL_PLB_wrDBus;
  output SPLB_CTRL_Sl_addrAck;
  output [0:1] SPLB_CTRL_Sl_SSize;
  output SPLB_CTRL_Sl_wait;
  output SPLB_CTRL_Sl_rearbitrate;
  output SPLB_CTRL_Sl_wrDAck;
  output SPLB_CTRL_Sl_wrComp;
  output [0:31] SPLB_CTRL_Sl_rdDBus;
  output SPLB_CTRL_Sl_rdDAck;
  output SPLB_CTRL_Sl_rdComp;
  output [0:0] SPLB_CTRL_Sl_MBusy;
  output [0:0] SPLB_CTRL_Sl_MWrErr;
  output [0:0] SPLB_CTRL_Sl_MRdErr;
  input [0:31] SPLB_CTRL_PLB_UABus;
  input SPLB_CTRL_PLB_SAValid;
  input SPLB_CTRL_PLB_rdPrim;
  input SPLB_CTRL_PLB_wrPrim;
  input SPLB_CTRL_PLB_abort;
  input SPLB_CTRL_PLB_busLock;
  input [0:1] SPLB_CTRL_PLB_MSize;
  input SPLB_CTRL_PLB_lockErr;
  input SPLB_CTRL_PLB_wrBurst;
  input SPLB_CTRL_PLB_rdBurst;
  input SPLB_CTRL_PLB_wrPendReq;
  input SPLB_CTRL_PLB_rdPendReq;
  input [0:1] SPLB_CTRL_PLB_wrPendPri;
  input [0:1] SPLB_CTRL_PLB_rdPendPri;
  input [0:1] SPLB_CTRL_PLB_reqPri;
  input [0:15] SPLB_CTRL_PLB_TAttribute;
  output SPLB_CTRL_Sl_wrBTerm;
  output [0:3] SPLB_CTRL_Sl_rdWdAddr;
  output SPLB_CTRL_Sl_rdBTerm;
  output [0:0] SPLB_CTRL_Sl_MIRQ;
  input S_AXI_CTRL_ACLK;
  input S_AXI_CTRL_ARESETN;
  input [31:0] S_AXI_CTRL_AWADDR;
  input S_AXI_CTRL_AWVALID;
  output S_AXI_CTRL_AWREADY;
  input [31:0] S_AXI_CTRL_WDATA;
  input [3:0] S_AXI_CTRL_WSTRB;
  input S_AXI_CTRL_WVALID;
  output S_AXI_CTRL_WREADY;
  output [1:0] S_AXI_CTRL_BRESP;
  output S_AXI_CTRL_BVALID;
  input S_AXI_CTRL_BREADY;
  input [31:0] S_AXI_CTRL_ARADDR;
  input S_AXI_CTRL_ARVALID;
  output S_AXI_CTRL_ARREADY;
  output [31:0] S_AXI_CTRL_RDATA;
  output [1:0] S_AXI_CTRL_RRESP;
  output S_AXI_CTRL_RVALID;
  input S_AXI_CTRL_RREADY;
endmodule

module system_microblaze_0_dlmb_wrapper
  (
    LMB_Clk,
    SYS_Rst,
    LMB_Rst,
    M_ABus,
    M_ReadStrobe,
    M_WriteStrobe,
    M_AddrStrobe,
    M_DBus,
    M_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE,
    LMB_ABus,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_AddrStrobe,
    LMB_ReadDBus,
    LMB_WriteDBus,
    LMB_Ready,
    LMB_Wait,
    LMB_UE,
    LMB_CE,
    LMB_BE
  );
  input LMB_Clk;
  input SYS_Rst;
  output LMB_Rst;
  input [0:31] M_ABus;
  input M_ReadStrobe;
  input M_WriteStrobe;
  input M_AddrStrobe;
  input [0:31] M_DBus;
  input [0:3] M_BE;
  input [0:31] Sl_DBus;
  input [0:0] Sl_Ready;
  input [0:0] Sl_Wait;
  input [0:0] Sl_UE;
  input [0:0] Sl_CE;
  output [0:31] LMB_ABus;
  output LMB_ReadStrobe;
  output LMB_WriteStrobe;
  output LMB_AddrStrobe;
  output [0:31] LMB_ReadDBus;
  output [0:31] LMB_WriteDBus;
  output LMB_Ready;
  output LMB_Wait;
  output LMB_UE;
  output LMB_CE;
  output [0:3] LMB_BE;
endmodule

module system_microblaze_0_d_bram_ctrl_wrapper
  (
    LMB_Clk,
    LMB_Rst,
    LMB_ABus,
    LMB_WriteDBus,
    LMB_AddrStrobe,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE,
    LMB1_ABus,
    LMB1_WriteDBus,
    LMB1_AddrStrobe,
    LMB1_ReadStrobe,
    LMB1_WriteStrobe,
    LMB1_BE,
    Sl1_DBus,
    Sl1_Ready,
    Sl1_Wait,
    Sl1_UE,
    Sl1_CE,
    LMB2_ABus,
    LMB2_WriteDBus,
    LMB2_AddrStrobe,
    LMB2_ReadStrobe,
    LMB2_WriteStrobe,
    LMB2_BE,
    Sl2_DBus,
    Sl2_Ready,
    Sl2_Wait,
    Sl2_UE,
    Sl2_CE,
    LMB3_ABus,
    LMB3_WriteDBus,
    LMB3_AddrStrobe,
    LMB3_ReadStrobe,
    LMB3_WriteStrobe,
    LMB3_BE,
    Sl3_DBus,
    Sl3_Ready,
    Sl3_Wait,
    Sl3_UE,
    Sl3_CE,
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    Interrupt,
    UE,
    CE,
    SPLB_CTRL_PLB_ABus,
    SPLB_CTRL_PLB_PAValid,
    SPLB_CTRL_PLB_masterID,
    SPLB_CTRL_PLB_RNW,
    SPLB_CTRL_PLB_BE,
    SPLB_CTRL_PLB_size,
    SPLB_CTRL_PLB_type,
    SPLB_CTRL_PLB_wrDBus,
    SPLB_CTRL_Sl_addrAck,
    SPLB_CTRL_Sl_SSize,
    SPLB_CTRL_Sl_wait,
    SPLB_CTRL_Sl_rearbitrate,
    SPLB_CTRL_Sl_wrDAck,
    SPLB_CTRL_Sl_wrComp,
    SPLB_CTRL_Sl_rdDBus,
    SPLB_CTRL_Sl_rdDAck,
    SPLB_CTRL_Sl_rdComp,
    SPLB_CTRL_Sl_MBusy,
    SPLB_CTRL_Sl_MWrErr,
    SPLB_CTRL_Sl_MRdErr,
    SPLB_CTRL_PLB_UABus,
    SPLB_CTRL_PLB_SAValid,
    SPLB_CTRL_PLB_rdPrim,
    SPLB_CTRL_PLB_wrPrim,
    SPLB_CTRL_PLB_abort,
    SPLB_CTRL_PLB_busLock,
    SPLB_CTRL_PLB_MSize,
    SPLB_CTRL_PLB_lockErr,
    SPLB_CTRL_PLB_wrBurst,
    SPLB_CTRL_PLB_rdBurst,
    SPLB_CTRL_PLB_wrPendReq,
    SPLB_CTRL_PLB_rdPendReq,
    SPLB_CTRL_PLB_wrPendPri,
    SPLB_CTRL_PLB_rdPendPri,
    SPLB_CTRL_PLB_reqPri,
    SPLB_CTRL_PLB_TAttribute,
    SPLB_CTRL_Sl_wrBTerm,
    SPLB_CTRL_Sl_rdWdAddr,
    SPLB_CTRL_Sl_rdBTerm,
    SPLB_CTRL_Sl_MIRQ,
    S_AXI_CTRL_ACLK,
    S_AXI_CTRL_ARESETN,
    S_AXI_CTRL_AWADDR,
    S_AXI_CTRL_AWVALID,
    S_AXI_CTRL_AWREADY,
    S_AXI_CTRL_WDATA,
    S_AXI_CTRL_WSTRB,
    S_AXI_CTRL_WVALID,
    S_AXI_CTRL_WREADY,
    S_AXI_CTRL_BRESP,
    S_AXI_CTRL_BVALID,
    S_AXI_CTRL_BREADY,
    S_AXI_CTRL_ARADDR,
    S_AXI_CTRL_ARVALID,
    S_AXI_CTRL_ARREADY,
    S_AXI_CTRL_RDATA,
    S_AXI_CTRL_RRESP,
    S_AXI_CTRL_RVALID,
    S_AXI_CTRL_RREADY
  );
  input LMB_Clk;
  input LMB_Rst;
  input [0:31] LMB_ABus;
  input [0:31] LMB_WriteDBus;
  input LMB_AddrStrobe;
  input LMB_ReadStrobe;
  input LMB_WriteStrobe;
  input [0:3] LMB_BE;
  output [0:31] Sl_DBus;
  output Sl_Ready;
  output Sl_Wait;
  output Sl_UE;
  output Sl_CE;
  input [0:31] LMB1_ABus;
  input [0:31] LMB1_WriteDBus;
  input LMB1_AddrStrobe;
  input LMB1_ReadStrobe;
  input LMB1_WriteStrobe;
  input [0:3] LMB1_BE;
  output [0:31] Sl1_DBus;
  output Sl1_Ready;
  output Sl1_Wait;
  output Sl1_UE;
  output Sl1_CE;
  input [0:31] LMB2_ABus;
  input [0:31] LMB2_WriteDBus;
  input LMB2_AddrStrobe;
  input LMB2_ReadStrobe;
  input LMB2_WriteStrobe;
  input [0:3] LMB2_BE;
  output [0:31] Sl2_DBus;
  output Sl2_Ready;
  output Sl2_Wait;
  output Sl2_UE;
  output Sl2_CE;
  input [0:31] LMB3_ABus;
  input [0:31] LMB3_WriteDBus;
  input LMB3_AddrStrobe;
  input LMB3_ReadStrobe;
  input LMB3_WriteStrobe;
  input [0:3] LMB3_BE;
  output [0:31] Sl3_DBus;
  output Sl3_Ready;
  output Sl3_Wait;
  output Sl3_UE;
  output Sl3_CE;
  output BRAM_Rst_A;
  output BRAM_Clk_A;
  output BRAM_EN_A;
  output [0:3] BRAM_WEN_A;
  output [0:31] BRAM_Addr_A;
  input [0:31] BRAM_Din_A;
  output [0:31] BRAM_Dout_A;
  output Interrupt;
  output UE;
  output CE;
  input [0:31] SPLB_CTRL_PLB_ABus;
  input SPLB_CTRL_PLB_PAValid;
  input [0:0] SPLB_CTRL_PLB_masterID;
  input SPLB_CTRL_PLB_RNW;
  input [0:3] SPLB_CTRL_PLB_BE;
  input [0:3] SPLB_CTRL_PLB_size;
  input [0:2] SPLB_CTRL_PLB_type;
  input [0:31] SPLB_CTRL_PLB_wrDBus;
  output SPLB_CTRL_Sl_addrAck;
  output [0:1] SPLB_CTRL_Sl_SSize;
  output SPLB_CTRL_Sl_wait;
  output SPLB_CTRL_Sl_rearbitrate;
  output SPLB_CTRL_Sl_wrDAck;
  output SPLB_CTRL_Sl_wrComp;
  output [0:31] SPLB_CTRL_Sl_rdDBus;
  output SPLB_CTRL_Sl_rdDAck;
  output SPLB_CTRL_Sl_rdComp;
  output [0:0] SPLB_CTRL_Sl_MBusy;
  output [0:0] SPLB_CTRL_Sl_MWrErr;
  output [0:0] SPLB_CTRL_Sl_MRdErr;
  input [0:31] SPLB_CTRL_PLB_UABus;
  input SPLB_CTRL_PLB_SAValid;
  input SPLB_CTRL_PLB_rdPrim;
  input SPLB_CTRL_PLB_wrPrim;
  input SPLB_CTRL_PLB_abort;
  input SPLB_CTRL_PLB_busLock;
  input [0:1] SPLB_CTRL_PLB_MSize;
  input SPLB_CTRL_PLB_lockErr;
  input SPLB_CTRL_PLB_wrBurst;
  input SPLB_CTRL_PLB_rdBurst;
  input SPLB_CTRL_PLB_wrPendReq;
  input SPLB_CTRL_PLB_rdPendReq;
  input [0:1] SPLB_CTRL_PLB_wrPendPri;
  input [0:1] SPLB_CTRL_PLB_rdPendPri;
  input [0:1] SPLB_CTRL_PLB_reqPri;
  input [0:15] SPLB_CTRL_PLB_TAttribute;
  output SPLB_CTRL_Sl_wrBTerm;
  output [0:3] SPLB_CTRL_Sl_rdWdAddr;
  output SPLB_CTRL_Sl_rdBTerm;
  output [0:0] SPLB_CTRL_Sl_MIRQ;
  input S_AXI_CTRL_ACLK;
  input S_AXI_CTRL_ARESETN;
  input [31:0] S_AXI_CTRL_AWADDR;
  input S_AXI_CTRL_AWVALID;
  output S_AXI_CTRL_AWREADY;
  input [31:0] S_AXI_CTRL_WDATA;
  input [3:0] S_AXI_CTRL_WSTRB;
  input S_AXI_CTRL_WVALID;
  output S_AXI_CTRL_WREADY;
  output [1:0] S_AXI_CTRL_BRESP;
  output S_AXI_CTRL_BVALID;
  input S_AXI_CTRL_BREADY;
  input [31:0] S_AXI_CTRL_ARADDR;
  input S_AXI_CTRL_ARVALID;
  output S_AXI_CTRL_ARREADY;
  output [31:0] S_AXI_CTRL_RDATA;
  output [1:0] S_AXI_CTRL_RRESP;
  output S_AXI_CTRL_RVALID;
  input S_AXI_CTRL_RREADY;
endmodule

module system_microblaze_0_bram_block_wrapper
  (
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    BRAM_Rst_B,
    BRAM_Clk_B,
    BRAM_EN_B,
    BRAM_WEN_B,
    BRAM_Addr_B,
    BRAM_Din_B,
    BRAM_Dout_B
  );
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:3] BRAM_WEN_A;
  input [0:31] BRAM_Addr_A;
  output [0:31] BRAM_Din_A;
  input [0:31] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:3] BRAM_WEN_B;
  input [0:31] BRAM_Addr_B;
  output [0:31] BRAM_Din_B;
  input [0:31] BRAM_Dout_B;
endmodule

module system_microblaze_0_wrapper
  (
    CLK,
    RESET,
    MB_RESET,
    INTERRUPT,
    INTERRUPT_ADDRESS,
    INTERRUPT_ACK,
    EXT_BRK,
    EXT_NM_BRK,
    DBG_STOP,
    MB_Halted,
    MB_Error,
    WAKEUP,
    SLEEP,
    DBG_WAKEUP,
    LOCKSTEP_MASTER_OUT,
    LOCKSTEP_SLAVE_IN,
    LOCKSTEP_OUT,
    INSTR,
    IREADY,
    IWAIT,
    ICE,
    IUE,
    INSTR_ADDR,
    IFETCH,
    I_AS,
    IPLB_M_ABort,
    IPLB_M_ABus,
    IPLB_M_UABus,
    IPLB_M_BE,
    IPLB_M_busLock,
    IPLB_M_lockErr,
    IPLB_M_MSize,
    IPLB_M_priority,
    IPLB_M_rdBurst,
    IPLB_M_request,
    IPLB_M_RNW,
    IPLB_M_size,
    IPLB_M_TAttribute,
    IPLB_M_type,
    IPLB_M_wrBurst,
    IPLB_M_wrDBus,
    IPLB_MBusy,
    IPLB_MRdErr,
    IPLB_MWrErr,
    IPLB_MIRQ,
    IPLB_MWrBTerm,
    IPLB_MWrDAck,
    IPLB_MAddrAck,
    IPLB_MRdBTerm,
    IPLB_MRdDAck,
    IPLB_MRdDBus,
    IPLB_MRdWdAddr,
    IPLB_MRearbitrate,
    IPLB_MSSize,
    IPLB_MTimeout,
    DATA_READ,
    DREADY,
    DWAIT,
    DCE,
    DUE,
    DATA_WRITE,
    DATA_ADDR,
    D_AS,
    READ_STROBE,
    WRITE_STROBE,
    BYTE_ENABLE,
    DPLB_M_ABort,
    DPLB_M_ABus,
    DPLB_M_UABus,
    DPLB_M_BE,
    DPLB_M_busLock,
    DPLB_M_lockErr,
    DPLB_M_MSize,
    DPLB_M_priority,
    DPLB_M_rdBurst,
    DPLB_M_request,
    DPLB_M_RNW,
    DPLB_M_size,
    DPLB_M_TAttribute,
    DPLB_M_type,
    DPLB_M_wrBurst,
    DPLB_M_wrDBus,
    DPLB_MBusy,
    DPLB_MRdErr,
    DPLB_MWrErr,
    DPLB_MIRQ,
    DPLB_MWrBTerm,
    DPLB_MWrDAck,
    DPLB_MAddrAck,
    DPLB_MRdBTerm,
    DPLB_MRdDAck,
    DPLB_MRdDBus,
    DPLB_MRdWdAddr,
    DPLB_MRearbitrate,
    DPLB_MSSize,
    DPLB_MTimeout,
    M_AXI_IP_AWID,
    M_AXI_IP_AWADDR,
    M_AXI_IP_AWLEN,
    M_AXI_IP_AWSIZE,
    M_AXI_IP_AWBURST,
    M_AXI_IP_AWLOCK,
    M_AXI_IP_AWCACHE,
    M_AXI_IP_AWPROT,
    M_AXI_IP_AWQOS,
    M_AXI_IP_AWVALID,
    M_AXI_IP_AWREADY,
    M_AXI_IP_WDATA,
    M_AXI_IP_WSTRB,
    M_AXI_IP_WLAST,
    M_AXI_IP_WVALID,
    M_AXI_IP_WREADY,
    M_AXI_IP_BID,
    M_AXI_IP_BRESP,
    M_AXI_IP_BVALID,
    M_AXI_IP_BREADY,
    M_AXI_IP_ARID,
    M_AXI_IP_ARADDR,
    M_AXI_IP_ARLEN,
    M_AXI_IP_ARSIZE,
    M_AXI_IP_ARBURST,
    M_AXI_IP_ARLOCK,
    M_AXI_IP_ARCACHE,
    M_AXI_IP_ARPROT,
    M_AXI_IP_ARQOS,
    M_AXI_IP_ARVALID,
    M_AXI_IP_ARREADY,
    M_AXI_IP_RID,
    M_AXI_IP_RDATA,
    M_AXI_IP_RRESP,
    M_AXI_IP_RLAST,
    M_AXI_IP_RVALID,
    M_AXI_IP_RREADY,
    M_AXI_DP_AWID,
    M_AXI_DP_AWADDR,
    M_AXI_DP_AWLEN,
    M_AXI_DP_AWSIZE,
    M_AXI_DP_AWBURST,
    M_AXI_DP_AWLOCK,
    M_AXI_DP_AWCACHE,
    M_AXI_DP_AWPROT,
    M_AXI_DP_AWQOS,
    M_AXI_DP_AWVALID,
    M_AXI_DP_AWREADY,
    M_AXI_DP_WDATA,
    M_AXI_DP_WSTRB,
    M_AXI_DP_WLAST,
    M_AXI_DP_WVALID,
    M_AXI_DP_WREADY,
    M_AXI_DP_BID,
    M_AXI_DP_BRESP,
    M_AXI_DP_BVALID,
    M_AXI_DP_BREADY,
    M_AXI_DP_ARID,
    M_AXI_DP_ARADDR,
    M_AXI_DP_ARLEN,
    M_AXI_DP_ARSIZE,
    M_AXI_DP_ARBURST,
    M_AXI_DP_ARLOCK,
    M_AXI_DP_ARCACHE,
    M_AXI_DP_ARPROT,
    M_AXI_DP_ARQOS,
    M_AXI_DP_ARVALID,
    M_AXI_DP_ARREADY,
    M_AXI_DP_RID,
    M_AXI_DP_RDATA,
    M_AXI_DP_RRESP,
    M_AXI_DP_RLAST,
    M_AXI_DP_RVALID,
    M_AXI_DP_RREADY,
    M_AXI_IC_AWID,
    M_AXI_IC_AWADDR,
    M_AXI_IC_AWLEN,
    M_AXI_IC_AWSIZE,
    M_AXI_IC_AWBURST,
    M_AXI_IC_AWLOCK,
    M_AXI_IC_AWCACHE,
    M_AXI_IC_AWPROT,
    M_AXI_IC_AWQOS,
    M_AXI_IC_AWVALID,
    M_AXI_IC_AWREADY,
    M_AXI_IC_AWUSER,
    M_AXI_IC_AWDOMAIN,
    M_AXI_IC_AWSNOOP,
    M_AXI_IC_AWBAR,
    M_AXI_IC_WDATA,
    M_AXI_IC_WSTRB,
    M_AXI_IC_WLAST,
    M_AXI_IC_WVALID,
    M_AXI_IC_WREADY,
    M_AXI_IC_WUSER,
    M_AXI_IC_BID,
    M_AXI_IC_BRESP,
    M_AXI_IC_BVALID,
    M_AXI_IC_BREADY,
    M_AXI_IC_BUSER,
    M_AXI_IC_WACK,
    M_AXI_IC_ARID,
    M_AXI_IC_ARADDR,
    M_AXI_IC_ARLEN,
    M_AXI_IC_ARSIZE,
    M_AXI_IC_ARBURST,
    M_AXI_IC_ARLOCK,
    M_AXI_IC_ARCACHE,
    M_AXI_IC_ARPROT,
    M_AXI_IC_ARQOS,
    M_AXI_IC_ARVALID,
    M_AXI_IC_ARREADY,
    M_AXI_IC_ARUSER,
    M_AXI_IC_ARDOMAIN,
    M_AXI_IC_ARSNOOP,
    M_AXI_IC_ARBAR,
    M_AXI_IC_RID,
    M_AXI_IC_RDATA,
    M_AXI_IC_RRESP,
    M_AXI_IC_RLAST,
    M_AXI_IC_RVALID,
    M_AXI_IC_RREADY,
    M_AXI_IC_RUSER,
    M_AXI_IC_RACK,
    M_AXI_IC_ACVALID,
    M_AXI_IC_ACADDR,
    M_AXI_IC_ACSNOOP,
    M_AXI_IC_ACPROT,
    M_AXI_IC_ACREADY,
    M_AXI_IC_CRREADY,
    M_AXI_IC_CRVALID,
    M_AXI_IC_CRRESP,
    M_AXI_IC_CDVALID,
    M_AXI_IC_CDREADY,
    M_AXI_IC_CDDATA,
    M_AXI_IC_CDLAST,
    M_AXI_DC_AWID,
    M_AXI_DC_AWADDR,
    M_AXI_DC_AWLEN,
    M_AXI_DC_AWSIZE,
    M_AXI_DC_AWBURST,
    M_AXI_DC_AWLOCK,
    M_AXI_DC_AWCACHE,
    M_AXI_DC_AWPROT,
    M_AXI_DC_AWQOS,
    M_AXI_DC_AWVALID,
    M_AXI_DC_AWREADY,
    M_AXI_DC_AWUSER,
    M_AXI_DC_AWDOMAIN,
    M_AXI_DC_AWSNOOP,
    M_AXI_DC_AWBAR,
    M_AXI_DC_WDATA,
    M_AXI_DC_WSTRB,
    M_AXI_DC_WLAST,
    M_AXI_DC_WVALID,
    M_AXI_DC_WREADY,
    M_AXI_DC_WUSER,
    M_AXI_DC_BID,
    M_AXI_DC_BRESP,
    M_AXI_DC_BVALID,
    M_AXI_DC_BREADY,
    M_AXI_DC_BUSER,
    M_AXI_DC_WACK,
    M_AXI_DC_ARID,
    M_AXI_DC_ARADDR,
    M_AXI_DC_ARLEN,
    M_AXI_DC_ARSIZE,
    M_AXI_DC_ARBURST,
    M_AXI_DC_ARLOCK,
    M_AXI_DC_ARCACHE,
    M_AXI_DC_ARPROT,
    M_AXI_DC_ARQOS,
    M_AXI_DC_ARVALID,
    M_AXI_DC_ARREADY,
    M_AXI_DC_ARUSER,
    M_AXI_DC_ARDOMAIN,
    M_AXI_DC_ARSNOOP,
    M_AXI_DC_ARBAR,
    M_AXI_DC_RID,
    M_AXI_DC_RDATA,
    M_AXI_DC_RRESP,
    M_AXI_DC_RLAST,
    M_AXI_DC_RVALID,
    M_AXI_DC_RREADY,
    M_AXI_DC_RUSER,
    M_AXI_DC_RACK,
    M_AXI_DC_ACVALID,
    M_AXI_DC_ACADDR,
    M_AXI_DC_ACSNOOP,
    M_AXI_DC_ACPROT,
    M_AXI_DC_ACREADY,
    M_AXI_DC_CRREADY,
    M_AXI_DC_CRVALID,
    M_AXI_DC_CRRESP,
    M_AXI_DC_CDVALID,
    M_AXI_DC_CDREADY,
    M_AXI_DC_CDDATA,
    M_AXI_DC_CDLAST,
    DBG_CLK,
    DBG_TDI,
    DBG_TDO,
    DBG_REG_EN,
    DBG_SHIFT,
    DBG_CAPTURE,
    DBG_UPDATE,
    DEBUG_RST,
    Trace_Instruction,
    Trace_Valid_Instr,
    Trace_PC,
    Trace_Reg_Write,
    Trace_Reg_Addr,
    Trace_MSR_Reg,
    Trace_PID_Reg,
    Trace_New_Reg_Value,
    Trace_Exception_Taken,
    Trace_Exception_Kind,
    Trace_Jump_Taken,
    Trace_Delay_Slot,
    Trace_Data_Address,
    Trace_Data_Access,
    Trace_Data_Read,
    Trace_Data_Write,
    Trace_Data_Write_Value,
    Trace_Data_Byte_Enable,
    Trace_DCache_Req,
    Trace_DCache_Hit,
    Trace_DCache_Rdy,
    Trace_DCache_Read,
    Trace_ICache_Req,
    Trace_ICache_Hit,
    Trace_ICache_Rdy,
    Trace_OF_PipeRun,
    Trace_EX_PipeRun,
    Trace_MEM_PipeRun,
    Trace_MB_Halted,
    Trace_Jump_Hit,
    FSL0_S_CLK,
    FSL0_S_READ,
    FSL0_S_DATA,
    FSL0_S_CONTROL,
    FSL0_S_EXISTS,
    FSL0_M_CLK,
    FSL0_M_WRITE,
    FSL0_M_DATA,
    FSL0_M_CONTROL,
    FSL0_M_FULL,
    FSL1_S_CLK,
    FSL1_S_READ,
    FSL1_S_DATA,
    FSL1_S_CONTROL,
    FSL1_S_EXISTS,
    FSL1_M_CLK,
    FSL1_M_WRITE,
    FSL1_M_DATA,
    FSL1_M_CONTROL,
    FSL1_M_FULL,
    FSL2_S_CLK,
    FSL2_S_READ,
    FSL2_S_DATA,
    FSL2_S_CONTROL,
    FSL2_S_EXISTS,
    FSL2_M_CLK,
    FSL2_M_WRITE,
    FSL2_M_DATA,
    FSL2_M_CONTROL,
    FSL2_M_FULL,
    FSL3_S_CLK,
    FSL3_S_READ,
    FSL3_S_DATA,
    FSL3_S_CONTROL,
    FSL3_S_EXISTS,
    FSL3_M_CLK,
    FSL3_M_WRITE,
    FSL3_M_DATA,
    FSL3_M_CONTROL,
    FSL3_M_FULL,
    FSL4_S_CLK,
    FSL4_S_READ,
    FSL4_S_DATA,
    FSL4_S_CONTROL,
    FSL4_S_EXISTS,
    FSL4_M_CLK,
    FSL4_M_WRITE,
    FSL4_M_DATA,
    FSL4_M_CONTROL,
    FSL4_M_FULL,
    FSL5_S_CLK,
    FSL5_S_READ,
    FSL5_S_DATA,
    FSL5_S_CONTROL,
    FSL5_S_EXISTS,
    FSL5_M_CLK,
    FSL5_M_WRITE,
    FSL5_M_DATA,
    FSL5_M_CONTROL,
    FSL5_M_FULL,
    FSL6_S_CLK,
    FSL6_S_READ,
    FSL6_S_DATA,
    FSL6_S_CONTROL,
    FSL6_S_EXISTS,
    FSL6_M_CLK,
    FSL6_M_WRITE,
    FSL6_M_DATA,
    FSL6_M_CONTROL,
    FSL6_M_FULL,
    FSL7_S_CLK,
    FSL7_S_READ,
    FSL7_S_DATA,
    FSL7_S_CONTROL,
    FSL7_S_EXISTS,
    FSL7_M_CLK,
    FSL7_M_WRITE,
    FSL7_M_DATA,
    FSL7_M_CONTROL,
    FSL7_M_FULL,
    FSL8_S_CLK,
    FSL8_S_READ,
    FSL8_S_DATA,
    FSL8_S_CONTROL,
    FSL8_S_EXISTS,
    FSL8_M_CLK,
    FSL8_M_WRITE,
    FSL8_M_DATA,
    FSL8_M_CONTROL,
    FSL8_M_FULL,
    FSL9_S_CLK,
    FSL9_S_READ,
    FSL9_S_DATA,
    FSL9_S_CONTROL,
    FSL9_S_EXISTS,
    FSL9_M_CLK,
    FSL9_M_WRITE,
    FSL9_M_DATA,
    FSL9_M_CONTROL,
    FSL9_M_FULL,
    FSL10_S_CLK,
    FSL10_S_READ,
    FSL10_S_DATA,
    FSL10_S_CONTROL,
    FSL10_S_EXISTS,
    FSL10_M_CLK,
    FSL10_M_WRITE,
    FSL10_M_DATA,
    FSL10_M_CONTROL,
    FSL10_M_FULL,
    FSL11_S_CLK,
    FSL11_S_READ,
    FSL11_S_DATA,
    FSL11_S_CONTROL,
    FSL11_S_EXISTS,
    FSL11_M_CLK,
    FSL11_M_WRITE,
    FSL11_M_DATA,
    FSL11_M_CONTROL,
    FSL11_M_FULL,
    FSL12_S_CLK,
    FSL12_S_READ,
    FSL12_S_DATA,
    FSL12_S_CONTROL,
    FSL12_S_EXISTS,
    FSL12_M_CLK,
    FSL12_M_WRITE,
    FSL12_M_DATA,
    FSL12_M_CONTROL,
    FSL12_M_FULL,
    FSL13_S_CLK,
    FSL13_S_READ,
    FSL13_S_DATA,
    FSL13_S_CONTROL,
    FSL13_S_EXISTS,
    FSL13_M_CLK,
    FSL13_M_WRITE,
    FSL13_M_DATA,
    FSL13_M_CONTROL,
    FSL13_M_FULL,
    FSL14_S_CLK,
    FSL14_S_READ,
    FSL14_S_DATA,
    FSL14_S_CONTROL,
    FSL14_S_EXISTS,
    FSL14_M_CLK,
    FSL14_M_WRITE,
    FSL14_M_DATA,
    FSL14_M_CONTROL,
    FSL14_M_FULL,
    FSL15_S_CLK,
    FSL15_S_READ,
    FSL15_S_DATA,
    FSL15_S_CONTROL,
    FSL15_S_EXISTS,
    FSL15_M_CLK,
    FSL15_M_WRITE,
    FSL15_M_DATA,
    FSL15_M_CONTROL,
    FSL15_M_FULL,
    M0_AXIS_TLAST,
    M0_AXIS_TDATA,
    M0_AXIS_TVALID,
    M0_AXIS_TREADY,
    S0_AXIS_TLAST,
    S0_AXIS_TDATA,
    S0_AXIS_TVALID,
    S0_AXIS_TREADY,
    M1_AXIS_TLAST,
    M1_AXIS_TDATA,
    M1_AXIS_TVALID,
    M1_AXIS_TREADY,
    S1_AXIS_TLAST,
    S1_AXIS_TDATA,
    S1_AXIS_TVALID,
    S1_AXIS_TREADY,
    M2_AXIS_TLAST,
    M2_AXIS_TDATA,
    M2_AXIS_TVALID,
    M2_AXIS_TREADY,
    S2_AXIS_TLAST,
    S2_AXIS_TDATA,
    S2_AXIS_TVALID,
    S2_AXIS_TREADY,
    M3_AXIS_TLAST,
    M3_AXIS_TDATA,
    M3_AXIS_TVALID,
    M3_AXIS_TREADY,
    S3_AXIS_TLAST,
    S3_AXIS_TDATA,
    S3_AXIS_TVALID,
    S3_AXIS_TREADY,
    M4_AXIS_TLAST,
    M4_AXIS_TDATA,
    M4_AXIS_TVALID,
    M4_AXIS_TREADY,
    S4_AXIS_TLAST,
    S4_AXIS_TDATA,
    S4_AXIS_TVALID,
    S4_AXIS_TREADY,
    M5_AXIS_TLAST,
    M5_AXIS_TDATA,
    M5_AXIS_TVALID,
    M5_AXIS_TREADY,
    S5_AXIS_TLAST,
    S5_AXIS_TDATA,
    S5_AXIS_TVALID,
    S5_AXIS_TREADY,
    M6_AXIS_TLAST,
    M6_AXIS_TDATA,
    M6_AXIS_TVALID,
    M6_AXIS_TREADY,
    S6_AXIS_TLAST,
    S6_AXIS_TDATA,
    S6_AXIS_TVALID,
    S6_AXIS_TREADY,
    M7_AXIS_TLAST,
    M7_AXIS_TDATA,
    M7_AXIS_TVALID,
    M7_AXIS_TREADY,
    S7_AXIS_TLAST,
    S7_AXIS_TDATA,
    S7_AXIS_TVALID,
    S7_AXIS_TREADY,
    M8_AXIS_TLAST,
    M8_AXIS_TDATA,
    M8_AXIS_TVALID,
    M8_AXIS_TREADY,
    S8_AXIS_TLAST,
    S8_AXIS_TDATA,
    S8_AXIS_TVALID,
    S8_AXIS_TREADY,
    M9_AXIS_TLAST,
    M9_AXIS_TDATA,
    M9_AXIS_TVALID,
    M9_AXIS_TREADY,
    S9_AXIS_TLAST,
    S9_AXIS_TDATA,
    S9_AXIS_TVALID,
    S9_AXIS_TREADY,
    M10_AXIS_TLAST,
    M10_AXIS_TDATA,
    M10_AXIS_TVALID,
    M10_AXIS_TREADY,
    S10_AXIS_TLAST,
    S10_AXIS_TDATA,
    S10_AXIS_TVALID,
    S10_AXIS_TREADY,
    M11_AXIS_TLAST,
    M11_AXIS_TDATA,
    M11_AXIS_TVALID,
    M11_AXIS_TREADY,
    S11_AXIS_TLAST,
    S11_AXIS_TDATA,
    S11_AXIS_TVALID,
    S11_AXIS_TREADY,
    M12_AXIS_TLAST,
    M12_AXIS_TDATA,
    M12_AXIS_TVALID,
    M12_AXIS_TREADY,
    S12_AXIS_TLAST,
    S12_AXIS_TDATA,
    S12_AXIS_TVALID,
    S12_AXIS_TREADY,
    M13_AXIS_TLAST,
    M13_AXIS_TDATA,
    M13_AXIS_TVALID,
    M13_AXIS_TREADY,
    S13_AXIS_TLAST,
    S13_AXIS_TDATA,
    S13_AXIS_TVALID,
    S13_AXIS_TREADY,
    M14_AXIS_TLAST,
    M14_AXIS_TDATA,
    M14_AXIS_TVALID,
    M14_AXIS_TREADY,
    S14_AXIS_TLAST,
    S14_AXIS_TDATA,
    S14_AXIS_TVALID,
    S14_AXIS_TREADY,
    M15_AXIS_TLAST,
    M15_AXIS_TDATA,
    M15_AXIS_TVALID,
    M15_AXIS_TREADY,
    S15_AXIS_TLAST,
    S15_AXIS_TDATA,
    S15_AXIS_TVALID,
    S15_AXIS_TREADY,
    ICACHE_FSL_IN_CLK,
    ICACHE_FSL_IN_READ,
    ICACHE_FSL_IN_DATA,
    ICACHE_FSL_IN_CONTROL,
    ICACHE_FSL_IN_EXISTS,
    ICACHE_FSL_OUT_CLK,
    ICACHE_FSL_OUT_WRITE,
    ICACHE_FSL_OUT_DATA,
    ICACHE_FSL_OUT_CONTROL,
    ICACHE_FSL_OUT_FULL,
    DCACHE_FSL_IN_CLK,
    DCACHE_FSL_IN_READ,
    DCACHE_FSL_IN_DATA,
    DCACHE_FSL_IN_CONTROL,
    DCACHE_FSL_IN_EXISTS,
    DCACHE_FSL_OUT_CLK,
    DCACHE_FSL_OUT_WRITE,
    DCACHE_FSL_OUT_DATA,
    DCACHE_FSL_OUT_CONTROL,
    DCACHE_FSL_OUT_FULL
  );
  input CLK;
  input RESET;
  input MB_RESET;
  input INTERRUPT;
  input [0:31] INTERRUPT_ADDRESS;
  output [0:1] INTERRUPT_ACK;
  input EXT_BRK;
  input EXT_NM_BRK;
  input DBG_STOP;
  output MB_Halted;
  output MB_Error;
  input [0:1] WAKEUP;
  output SLEEP;
  output DBG_WAKEUP;
  output [0:4095] LOCKSTEP_MASTER_OUT;
  input [0:4095] LOCKSTEP_SLAVE_IN;
  output [0:4095] LOCKSTEP_OUT;
  input [0:31] INSTR;
  input IREADY;
  input IWAIT;
  input ICE;
  input IUE;
  output [0:31] INSTR_ADDR;
  output IFETCH;
  output I_AS;
  output IPLB_M_ABort;
  output [0:31] IPLB_M_ABus;
  output [0:31] IPLB_M_UABus;
  output [0:3] IPLB_M_BE;
  output IPLB_M_busLock;
  output IPLB_M_lockErr;
  output [0:1] IPLB_M_MSize;
  output [0:1] IPLB_M_priority;
  output IPLB_M_rdBurst;
  output IPLB_M_request;
  output IPLB_M_RNW;
  output [0:3] IPLB_M_size;
  output [0:15] IPLB_M_TAttribute;
  output [0:2] IPLB_M_type;
  output IPLB_M_wrBurst;
  output [0:31] IPLB_M_wrDBus;
  input IPLB_MBusy;
  input IPLB_MRdErr;
  input IPLB_MWrErr;
  input IPLB_MIRQ;
  input IPLB_MWrBTerm;
  input IPLB_MWrDAck;
  input IPLB_MAddrAck;
  input IPLB_MRdBTerm;
  input IPLB_MRdDAck;
  input [0:31] IPLB_MRdDBus;
  input [0:3] IPLB_MRdWdAddr;
  input IPLB_MRearbitrate;
  input [0:1] IPLB_MSSize;
  input IPLB_MTimeout;
  input [0:31] DATA_READ;
  input DREADY;
  input DWAIT;
  input DCE;
  input DUE;
  output [0:31] DATA_WRITE;
  output [0:31] DATA_ADDR;
  output D_AS;
  output READ_STROBE;
  output WRITE_STROBE;
  output [0:3] BYTE_ENABLE;
  output DPLB_M_ABort;
  output [0:31] DPLB_M_ABus;
  output [0:31] DPLB_M_UABus;
  output [0:3] DPLB_M_BE;
  output DPLB_M_busLock;
  output DPLB_M_lockErr;
  output [0:1] DPLB_M_MSize;
  output [0:1] DPLB_M_priority;
  output DPLB_M_rdBurst;
  output DPLB_M_request;
  output DPLB_M_RNW;
  output [0:3] DPLB_M_size;
  output [0:15] DPLB_M_TAttribute;
  output [0:2] DPLB_M_type;
  output DPLB_M_wrBurst;
  output [0:31] DPLB_M_wrDBus;
  input DPLB_MBusy;
  input DPLB_MRdErr;
  input DPLB_MWrErr;
  input DPLB_MIRQ;
  input DPLB_MWrBTerm;
  input DPLB_MWrDAck;
  input DPLB_MAddrAck;
  input DPLB_MRdBTerm;
  input DPLB_MRdDAck;
  input [0:31] DPLB_MRdDBus;
  input [0:3] DPLB_MRdWdAddr;
  input DPLB_MRearbitrate;
  input [0:1] DPLB_MSSize;
  input DPLB_MTimeout;
  output [0:0] M_AXI_IP_AWID;
  output [31:0] M_AXI_IP_AWADDR;
  output [7:0] M_AXI_IP_AWLEN;
  output [2:0] M_AXI_IP_AWSIZE;
  output [1:0] M_AXI_IP_AWBURST;
  output M_AXI_IP_AWLOCK;
  output [3:0] M_AXI_IP_AWCACHE;
  output [2:0] M_AXI_IP_AWPROT;
  output [3:0] M_AXI_IP_AWQOS;
  output M_AXI_IP_AWVALID;
  input M_AXI_IP_AWREADY;
  output [31:0] M_AXI_IP_WDATA;
  output [3:0] M_AXI_IP_WSTRB;
  output M_AXI_IP_WLAST;
  output M_AXI_IP_WVALID;
  input M_AXI_IP_WREADY;
  input [0:0] M_AXI_IP_BID;
  input [1:0] M_AXI_IP_BRESP;
  input M_AXI_IP_BVALID;
  output M_AXI_IP_BREADY;
  output [0:0] M_AXI_IP_ARID;
  output [31:0] M_AXI_IP_ARADDR;
  output [7:0] M_AXI_IP_ARLEN;
  output [2:0] M_AXI_IP_ARSIZE;
  output [1:0] M_AXI_IP_ARBURST;
  output M_AXI_IP_ARLOCK;
  output [3:0] M_AXI_IP_ARCACHE;
  output [2:0] M_AXI_IP_ARPROT;
  output [3:0] M_AXI_IP_ARQOS;
  output M_AXI_IP_ARVALID;
  input M_AXI_IP_ARREADY;
  input [0:0] M_AXI_IP_RID;
  input [31:0] M_AXI_IP_RDATA;
  input [1:0] M_AXI_IP_RRESP;
  input M_AXI_IP_RLAST;
  input M_AXI_IP_RVALID;
  output M_AXI_IP_RREADY;
  output [0:0] M_AXI_DP_AWID;
  output [31:0] M_AXI_DP_AWADDR;
  output [7:0] M_AXI_DP_AWLEN;
  output [2:0] M_AXI_DP_AWSIZE;
  output [1:0] M_AXI_DP_AWBURST;
  output M_AXI_DP_AWLOCK;
  output [3:0] M_AXI_DP_AWCACHE;
  output [2:0] M_AXI_DP_AWPROT;
  output [3:0] M_AXI_DP_AWQOS;
  output M_AXI_DP_AWVALID;
  input M_AXI_DP_AWREADY;
  output [31:0] M_AXI_DP_WDATA;
  output [3:0] M_AXI_DP_WSTRB;
  output M_AXI_DP_WLAST;
  output M_AXI_DP_WVALID;
  input M_AXI_DP_WREADY;
  input [0:0] M_AXI_DP_BID;
  input [1:0] M_AXI_DP_BRESP;
  input M_AXI_DP_BVALID;
  output M_AXI_DP_BREADY;
  output [0:0] M_AXI_DP_ARID;
  output [31:0] M_AXI_DP_ARADDR;
  output [7:0] M_AXI_DP_ARLEN;
  output [2:0] M_AXI_DP_ARSIZE;
  output [1:0] M_AXI_DP_ARBURST;
  output M_AXI_DP_ARLOCK;
  output [3:0] M_AXI_DP_ARCACHE;
  output [2:0] M_AXI_DP_ARPROT;
  output [3:0] M_AXI_DP_ARQOS;
  output M_AXI_DP_ARVALID;
  input M_AXI_DP_ARREADY;
  input [0:0] M_AXI_DP_RID;
  input [31:0] M_AXI_DP_RDATA;
  input [1:0] M_AXI_DP_RRESP;
  input M_AXI_DP_RLAST;
  input M_AXI_DP_RVALID;
  output M_AXI_DP_RREADY;
  output [0:0] M_AXI_IC_AWID;
  output [31:0] M_AXI_IC_AWADDR;
  output [7:0] M_AXI_IC_AWLEN;
  output [2:0] M_AXI_IC_AWSIZE;
  output [1:0] M_AXI_IC_AWBURST;
  output M_AXI_IC_AWLOCK;
  output [3:0] M_AXI_IC_AWCACHE;
  output [2:0] M_AXI_IC_AWPROT;
  output [3:0] M_AXI_IC_AWQOS;
  output M_AXI_IC_AWVALID;
  input M_AXI_IC_AWREADY;
  output [4:0] M_AXI_IC_AWUSER;
  output [1:0] M_AXI_IC_AWDOMAIN;
  output [2:0] M_AXI_IC_AWSNOOP;
  output [1:0] M_AXI_IC_AWBAR;
  output [31:0] M_AXI_IC_WDATA;
  output [3:0] M_AXI_IC_WSTRB;
  output M_AXI_IC_WLAST;
  output M_AXI_IC_WVALID;
  input M_AXI_IC_WREADY;
  output [0:0] M_AXI_IC_WUSER;
  input [0:0] M_AXI_IC_BID;
  input [1:0] M_AXI_IC_BRESP;
  input M_AXI_IC_BVALID;
  output M_AXI_IC_BREADY;
  input [0:0] M_AXI_IC_BUSER;
  output M_AXI_IC_WACK;
  output [0:0] M_AXI_IC_ARID;
  output [31:0] M_AXI_IC_ARADDR;
  output [7:0] M_AXI_IC_ARLEN;
  output [2:0] M_AXI_IC_ARSIZE;
  output [1:0] M_AXI_IC_ARBURST;
  output M_AXI_IC_ARLOCK;
  output [3:0] M_AXI_IC_ARCACHE;
  output [2:0] M_AXI_IC_ARPROT;
  output [3:0] M_AXI_IC_ARQOS;
  output M_AXI_IC_ARVALID;
  input M_AXI_IC_ARREADY;
  output [4:0] M_AXI_IC_ARUSER;
  output [1:0] M_AXI_IC_ARDOMAIN;
  output [3:0] M_AXI_IC_ARSNOOP;
  output [1:0] M_AXI_IC_ARBAR;
  input [0:0] M_AXI_IC_RID;
  input [31:0] M_AXI_IC_RDATA;
  input [1:0] M_AXI_IC_RRESP;
  input M_AXI_IC_RLAST;
  input M_AXI_IC_RVALID;
  output M_AXI_IC_RREADY;
  input [0:0] M_AXI_IC_RUSER;
  output M_AXI_IC_RACK;
  input M_AXI_IC_ACVALID;
  input [31:0] M_AXI_IC_ACADDR;
  input [3:0] M_AXI_IC_ACSNOOP;
  input [2:0] M_AXI_IC_ACPROT;
  output M_AXI_IC_ACREADY;
  input M_AXI_IC_CRREADY;
  output M_AXI_IC_CRVALID;
  output [4:0] M_AXI_IC_CRRESP;
  output M_AXI_IC_CDVALID;
  input M_AXI_IC_CDREADY;
  output [31:0] M_AXI_IC_CDDATA;
  output M_AXI_IC_CDLAST;
  output [0:0] M_AXI_DC_AWID;
  output [31:0] M_AXI_DC_AWADDR;
  output [7:0] M_AXI_DC_AWLEN;
  output [2:0] M_AXI_DC_AWSIZE;
  output [1:0] M_AXI_DC_AWBURST;
  output M_AXI_DC_AWLOCK;
  output [3:0] M_AXI_DC_AWCACHE;
  output [2:0] M_AXI_DC_AWPROT;
  output [3:0] M_AXI_DC_AWQOS;
  output M_AXI_DC_AWVALID;
  input M_AXI_DC_AWREADY;
  output [4:0] M_AXI_DC_AWUSER;
  output [1:0] M_AXI_DC_AWDOMAIN;
  output [2:0] M_AXI_DC_AWSNOOP;
  output [1:0] M_AXI_DC_AWBAR;
  output [31:0] M_AXI_DC_WDATA;
  output [3:0] M_AXI_DC_WSTRB;
  output M_AXI_DC_WLAST;
  output M_AXI_DC_WVALID;
  input M_AXI_DC_WREADY;
  output [0:0] M_AXI_DC_WUSER;
  input [0:0] M_AXI_DC_BID;
  input [1:0] M_AXI_DC_BRESP;
  input M_AXI_DC_BVALID;
  output M_AXI_DC_BREADY;
  input [0:0] M_AXI_DC_BUSER;
  output M_AXI_DC_WACK;
  output [0:0] M_AXI_DC_ARID;
  output [31:0] M_AXI_DC_ARADDR;
  output [7:0] M_AXI_DC_ARLEN;
  output [2:0] M_AXI_DC_ARSIZE;
  output [1:0] M_AXI_DC_ARBURST;
  output M_AXI_DC_ARLOCK;
  output [3:0] M_AXI_DC_ARCACHE;
  output [2:0] M_AXI_DC_ARPROT;
  output [3:0] M_AXI_DC_ARQOS;
  output M_AXI_DC_ARVALID;
  input M_AXI_DC_ARREADY;
  output [4:0] M_AXI_DC_ARUSER;
  output [1:0] M_AXI_DC_ARDOMAIN;
  output [3:0] M_AXI_DC_ARSNOOP;
  output [1:0] M_AXI_DC_ARBAR;
  input [0:0] M_AXI_DC_RID;
  input [31:0] M_AXI_DC_RDATA;
  input [1:0] M_AXI_DC_RRESP;
  input M_AXI_DC_RLAST;
  input M_AXI_DC_RVALID;
  output M_AXI_DC_RREADY;
  input [0:0] M_AXI_DC_RUSER;
  output M_AXI_DC_RACK;
  input M_AXI_DC_ACVALID;
  input [31:0] M_AXI_DC_ACADDR;
  input [3:0] M_AXI_DC_ACSNOOP;
  input [2:0] M_AXI_DC_ACPROT;
  output M_AXI_DC_ACREADY;
  input M_AXI_DC_CRREADY;
  output M_AXI_DC_CRVALID;
  output [4:0] M_AXI_DC_CRRESP;
  output M_AXI_DC_CDVALID;
  input M_AXI_DC_CDREADY;
  output [31:0] M_AXI_DC_CDDATA;
  output M_AXI_DC_CDLAST;
  input DBG_CLK;
  input DBG_TDI;
  output DBG_TDO;
  input [0:7] DBG_REG_EN;
  input DBG_SHIFT;
  input DBG_CAPTURE;
  input DBG_UPDATE;
  input DEBUG_RST;
  output [0:31] Trace_Instruction;
  output Trace_Valid_Instr;
  output [0:31] Trace_PC;
  output Trace_Reg_Write;
  output [0:4] Trace_Reg_Addr;
  output [0:14] Trace_MSR_Reg;
  output [0:7] Trace_PID_Reg;
  output [0:31] Trace_New_Reg_Value;
  output Trace_Exception_Taken;
  output [0:4] Trace_Exception_Kind;
  output Trace_Jump_Taken;
  output Trace_Delay_Slot;
  output [0:31] Trace_Data_Address;
  output Trace_Data_Access;
  output Trace_Data_Read;
  output Trace_Data_Write;
  output [0:31] Trace_Data_Write_Value;
  output [0:3] Trace_Data_Byte_Enable;
  output Trace_DCache_Req;
  output Trace_DCache_Hit;
  output Trace_DCache_Rdy;
  output Trace_DCache_Read;
  output Trace_ICache_Req;
  output Trace_ICache_Hit;
  output Trace_ICache_Rdy;
  output Trace_OF_PipeRun;
  output Trace_EX_PipeRun;
  output Trace_MEM_PipeRun;
  output Trace_MB_Halted;
  output Trace_Jump_Hit;
  output FSL0_S_CLK;
  output FSL0_S_READ;
  input [0:31] FSL0_S_DATA;
  input FSL0_S_CONTROL;
  input FSL0_S_EXISTS;
  output FSL0_M_CLK;
  output FSL0_M_WRITE;
  output [0:31] FSL0_M_DATA;
  output FSL0_M_CONTROL;
  input FSL0_M_FULL;
  output FSL1_S_CLK;
  output FSL1_S_READ;
  input [0:31] FSL1_S_DATA;
  input FSL1_S_CONTROL;
  input FSL1_S_EXISTS;
  output FSL1_M_CLK;
  output FSL1_M_WRITE;
  output [0:31] FSL1_M_DATA;
  output FSL1_M_CONTROL;
  input FSL1_M_FULL;
  output FSL2_S_CLK;
  output FSL2_S_READ;
  input [0:31] FSL2_S_DATA;
  input FSL2_S_CONTROL;
  input FSL2_S_EXISTS;
  output FSL2_M_CLK;
  output FSL2_M_WRITE;
  output [0:31] FSL2_M_DATA;
  output FSL2_M_CONTROL;
  input FSL2_M_FULL;
  output FSL3_S_CLK;
  output FSL3_S_READ;
  input [0:31] FSL3_S_DATA;
  input FSL3_S_CONTROL;
  input FSL3_S_EXISTS;
  output FSL3_M_CLK;
  output FSL3_M_WRITE;
  output [0:31] FSL3_M_DATA;
  output FSL3_M_CONTROL;
  input FSL3_M_FULL;
  output FSL4_S_CLK;
  output FSL4_S_READ;
  input [0:31] FSL4_S_DATA;
  input FSL4_S_CONTROL;
  input FSL4_S_EXISTS;
  output FSL4_M_CLK;
  output FSL4_M_WRITE;
  output [0:31] FSL4_M_DATA;
  output FSL4_M_CONTROL;
  input FSL4_M_FULL;
  output FSL5_S_CLK;
  output FSL5_S_READ;
  input [0:31] FSL5_S_DATA;
  input FSL5_S_CONTROL;
  input FSL5_S_EXISTS;
  output FSL5_M_CLK;
  output FSL5_M_WRITE;
  output [0:31] FSL5_M_DATA;
  output FSL5_M_CONTROL;
  input FSL5_M_FULL;
  output FSL6_S_CLK;
  output FSL6_S_READ;
  input [0:31] FSL6_S_DATA;
  input FSL6_S_CONTROL;
  input FSL6_S_EXISTS;
  output FSL6_M_CLK;
  output FSL6_M_WRITE;
  output [0:31] FSL6_M_DATA;
  output FSL6_M_CONTROL;
  input FSL6_M_FULL;
  output FSL7_S_CLK;
  output FSL7_S_READ;
  input [0:31] FSL7_S_DATA;
  input FSL7_S_CONTROL;
  input FSL7_S_EXISTS;
  output FSL7_M_CLK;
  output FSL7_M_WRITE;
  output [0:31] FSL7_M_DATA;
  output FSL7_M_CONTROL;
  input FSL7_M_FULL;
  output FSL8_S_CLK;
  output FSL8_S_READ;
  input [0:31] FSL8_S_DATA;
  input FSL8_S_CONTROL;
  input FSL8_S_EXISTS;
  output FSL8_M_CLK;
  output FSL8_M_WRITE;
  output [0:31] FSL8_M_DATA;
  output FSL8_M_CONTROL;
  input FSL8_M_FULL;
  output FSL9_S_CLK;
  output FSL9_S_READ;
  input [0:31] FSL9_S_DATA;
  input FSL9_S_CONTROL;
  input FSL9_S_EXISTS;
  output FSL9_M_CLK;
  output FSL9_M_WRITE;
  output [0:31] FSL9_M_DATA;
  output FSL9_M_CONTROL;
  input FSL9_M_FULL;
  output FSL10_S_CLK;
  output FSL10_S_READ;
  input [0:31] FSL10_S_DATA;
  input FSL10_S_CONTROL;
  input FSL10_S_EXISTS;
  output FSL10_M_CLK;
  output FSL10_M_WRITE;
  output [0:31] FSL10_M_DATA;
  output FSL10_M_CONTROL;
  input FSL10_M_FULL;
  output FSL11_S_CLK;
  output FSL11_S_READ;
  input [0:31] FSL11_S_DATA;
  input FSL11_S_CONTROL;
  input FSL11_S_EXISTS;
  output FSL11_M_CLK;
  output FSL11_M_WRITE;
  output [0:31] FSL11_M_DATA;
  output FSL11_M_CONTROL;
  input FSL11_M_FULL;
  output FSL12_S_CLK;
  output FSL12_S_READ;
  input [0:31] FSL12_S_DATA;
  input FSL12_S_CONTROL;
  input FSL12_S_EXISTS;
  output FSL12_M_CLK;
  output FSL12_M_WRITE;
  output [0:31] FSL12_M_DATA;
  output FSL12_M_CONTROL;
  input FSL12_M_FULL;
  output FSL13_S_CLK;
  output FSL13_S_READ;
  input [0:31] FSL13_S_DATA;
  input FSL13_S_CONTROL;
  input FSL13_S_EXISTS;
  output FSL13_M_CLK;
  output FSL13_M_WRITE;
  output [0:31] FSL13_M_DATA;
  output FSL13_M_CONTROL;
  input FSL13_M_FULL;
  output FSL14_S_CLK;
  output FSL14_S_READ;
  input [0:31] FSL14_S_DATA;
  input FSL14_S_CONTROL;
  input FSL14_S_EXISTS;
  output FSL14_M_CLK;
  output FSL14_M_WRITE;
  output [0:31] FSL14_M_DATA;
  output FSL14_M_CONTROL;
  input FSL14_M_FULL;
  output FSL15_S_CLK;
  output FSL15_S_READ;
  input [0:31] FSL15_S_DATA;
  input FSL15_S_CONTROL;
  input FSL15_S_EXISTS;
  output FSL15_M_CLK;
  output FSL15_M_WRITE;
  output [0:31] FSL15_M_DATA;
  output FSL15_M_CONTROL;
  input FSL15_M_FULL;
  output M0_AXIS_TLAST;
  output [31:0] M0_AXIS_TDATA;
  output M0_AXIS_TVALID;
  input M0_AXIS_TREADY;
  input S0_AXIS_TLAST;
  input [31:0] S0_AXIS_TDATA;
  input S0_AXIS_TVALID;
  output S0_AXIS_TREADY;
  output M1_AXIS_TLAST;
  output [31:0] M1_AXIS_TDATA;
  output M1_AXIS_TVALID;
  input M1_AXIS_TREADY;
  input S1_AXIS_TLAST;
  input [31:0] S1_AXIS_TDATA;
  input S1_AXIS_TVALID;
  output S1_AXIS_TREADY;
  output M2_AXIS_TLAST;
  output [31:0] M2_AXIS_TDATA;
  output M2_AXIS_TVALID;
  input M2_AXIS_TREADY;
  input S2_AXIS_TLAST;
  input [31:0] S2_AXIS_TDATA;
  input S2_AXIS_TVALID;
  output S2_AXIS_TREADY;
  output M3_AXIS_TLAST;
  output [31:0] M3_AXIS_TDATA;
  output M3_AXIS_TVALID;
  input M3_AXIS_TREADY;
  input S3_AXIS_TLAST;
  input [31:0] S3_AXIS_TDATA;
  input S3_AXIS_TVALID;
  output S3_AXIS_TREADY;
  output M4_AXIS_TLAST;
  output [31:0] M4_AXIS_TDATA;
  output M4_AXIS_TVALID;
  input M4_AXIS_TREADY;
  input S4_AXIS_TLAST;
  input [31:0] S4_AXIS_TDATA;
  input S4_AXIS_TVALID;
  output S4_AXIS_TREADY;
  output M5_AXIS_TLAST;
  output [31:0] M5_AXIS_TDATA;
  output M5_AXIS_TVALID;
  input M5_AXIS_TREADY;
  input S5_AXIS_TLAST;
  input [31:0] S5_AXIS_TDATA;
  input S5_AXIS_TVALID;
  output S5_AXIS_TREADY;
  output M6_AXIS_TLAST;
  output [31:0] M6_AXIS_TDATA;
  output M6_AXIS_TVALID;
  input M6_AXIS_TREADY;
  input S6_AXIS_TLAST;
  input [31:0] S6_AXIS_TDATA;
  input S6_AXIS_TVALID;
  output S6_AXIS_TREADY;
  output M7_AXIS_TLAST;
  output [31:0] M7_AXIS_TDATA;
  output M7_AXIS_TVALID;
  input M7_AXIS_TREADY;
  input S7_AXIS_TLAST;
  input [31:0] S7_AXIS_TDATA;
  input S7_AXIS_TVALID;
  output S7_AXIS_TREADY;
  output M8_AXIS_TLAST;
  output [31:0] M8_AXIS_TDATA;
  output M8_AXIS_TVALID;
  input M8_AXIS_TREADY;
  input S8_AXIS_TLAST;
  input [31:0] S8_AXIS_TDATA;
  input S8_AXIS_TVALID;
  output S8_AXIS_TREADY;
  output M9_AXIS_TLAST;
  output [31:0] M9_AXIS_TDATA;
  output M9_AXIS_TVALID;
  input M9_AXIS_TREADY;
  input S9_AXIS_TLAST;
  input [31:0] S9_AXIS_TDATA;
  input S9_AXIS_TVALID;
  output S9_AXIS_TREADY;
  output M10_AXIS_TLAST;
  output [31:0] M10_AXIS_TDATA;
  output M10_AXIS_TVALID;
  input M10_AXIS_TREADY;
  input S10_AXIS_TLAST;
  input [31:0] S10_AXIS_TDATA;
  input S10_AXIS_TVALID;
  output S10_AXIS_TREADY;
  output M11_AXIS_TLAST;
  output [31:0] M11_AXIS_TDATA;
  output M11_AXIS_TVALID;
  input M11_AXIS_TREADY;
  input S11_AXIS_TLAST;
  input [31:0] S11_AXIS_TDATA;
  input S11_AXIS_TVALID;
  output S11_AXIS_TREADY;
  output M12_AXIS_TLAST;
  output [31:0] M12_AXIS_TDATA;
  output M12_AXIS_TVALID;
  input M12_AXIS_TREADY;
  input S12_AXIS_TLAST;
  input [31:0] S12_AXIS_TDATA;
  input S12_AXIS_TVALID;
  output S12_AXIS_TREADY;
  output M13_AXIS_TLAST;
  output [31:0] M13_AXIS_TDATA;
  output M13_AXIS_TVALID;
  input M13_AXIS_TREADY;
  input S13_AXIS_TLAST;
  input [31:0] S13_AXIS_TDATA;
  input S13_AXIS_TVALID;
  output S13_AXIS_TREADY;
  output M14_AXIS_TLAST;
  output [31:0] M14_AXIS_TDATA;
  output M14_AXIS_TVALID;
  input M14_AXIS_TREADY;
  input S14_AXIS_TLAST;
  input [31:0] S14_AXIS_TDATA;
  input S14_AXIS_TVALID;
  output S14_AXIS_TREADY;
  output M15_AXIS_TLAST;
  output [31:0] M15_AXIS_TDATA;
  output M15_AXIS_TVALID;
  input M15_AXIS_TREADY;
  input S15_AXIS_TLAST;
  input [31:0] S15_AXIS_TDATA;
  input S15_AXIS_TVALID;
  output S15_AXIS_TREADY;
  output ICACHE_FSL_IN_CLK;
  output ICACHE_FSL_IN_READ;
  input [0:31] ICACHE_FSL_IN_DATA;
  input ICACHE_FSL_IN_CONTROL;
  input ICACHE_FSL_IN_EXISTS;
  output ICACHE_FSL_OUT_CLK;
  output ICACHE_FSL_OUT_WRITE;
  output [0:31] ICACHE_FSL_OUT_DATA;
  output ICACHE_FSL_OUT_CONTROL;
  input ICACHE_FSL_OUT_FULL;
  output DCACHE_FSL_IN_CLK;
  output DCACHE_FSL_IN_READ;
  input [0:31] DCACHE_FSL_IN_DATA;
  input DCACHE_FSL_IN_CONTROL;
  input DCACHE_FSL_IN_EXISTS;
  output DCACHE_FSL_OUT_CLK;
  output DCACHE_FSL_OUT_WRITE;
  output [0:31] DCACHE_FSL_OUT_DATA;
  output DCACHE_FSL_OUT_CONTROL;
  input DCACHE_FSL_OUT_FULL;
endmodule

module system_debug_module_wrapper
  (
    Interrupt,
    Debug_SYS_Rst,
    Ext_BRK,
    Ext_NM_BRK,
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    SPLB_Clk,
    SPLB_Rst,
    PLB_ABus,
    PLB_UABus,
    PLB_PAValid,
    PLB_SAValid,
    PLB_rdPrim,
    PLB_wrPrim,
    PLB_masterID,
    PLB_abort,
    PLB_busLock,
    PLB_RNW,
    PLB_BE,
    PLB_MSize,
    PLB_size,
    PLB_type,
    PLB_lockErr,
    PLB_wrDBus,
    PLB_wrBurst,
    PLB_rdBurst,
    PLB_wrPendReq,
    PLB_rdPendReq,
    PLB_wrPendPri,
    PLB_rdPendPri,
    PLB_reqPri,
    PLB_TAttribute,
    Sl_addrAck,
    Sl_SSize,
    Sl_wait,
    Sl_rearbitrate,
    Sl_wrDAck,
    Sl_wrComp,
    Sl_wrBTerm,
    Sl_rdDBus,
    Sl_rdWdAddr,
    Sl_rdDAck,
    Sl_rdComp,
    Sl_rdBTerm,
    Sl_MBusy,
    Sl_MWrErr,
    Sl_MRdErr,
    Sl_MIRQ,
    Dbg_Clk_0,
    Dbg_TDI_0,
    Dbg_TDO_0,
    Dbg_Reg_En_0,
    Dbg_Capture_0,
    Dbg_Shift_0,
    Dbg_Update_0,
    Dbg_Rst_0,
    Dbg_Clk_1,
    Dbg_TDI_1,
    Dbg_TDO_1,
    Dbg_Reg_En_1,
    Dbg_Capture_1,
    Dbg_Shift_1,
    Dbg_Update_1,
    Dbg_Rst_1,
    Dbg_Clk_2,
    Dbg_TDI_2,
    Dbg_TDO_2,
    Dbg_Reg_En_2,
    Dbg_Capture_2,
    Dbg_Shift_2,
    Dbg_Update_2,
    Dbg_Rst_2,
    Dbg_Clk_3,
    Dbg_TDI_3,
    Dbg_TDO_3,
    Dbg_Reg_En_3,
    Dbg_Capture_3,
    Dbg_Shift_3,
    Dbg_Update_3,
    Dbg_Rst_3,
    Dbg_Clk_4,
    Dbg_TDI_4,
    Dbg_TDO_4,
    Dbg_Reg_En_4,
    Dbg_Capture_4,
    Dbg_Shift_4,
    Dbg_Update_4,
    Dbg_Rst_4,
    Dbg_Clk_5,
    Dbg_TDI_5,
    Dbg_TDO_5,
    Dbg_Reg_En_5,
    Dbg_Capture_5,
    Dbg_Shift_5,
    Dbg_Update_5,
    Dbg_Rst_5,
    Dbg_Clk_6,
    Dbg_TDI_6,
    Dbg_TDO_6,
    Dbg_Reg_En_6,
    Dbg_Capture_6,
    Dbg_Shift_6,
    Dbg_Update_6,
    Dbg_Rst_6,
    Dbg_Clk_7,
    Dbg_TDI_7,
    Dbg_TDO_7,
    Dbg_Reg_En_7,
    Dbg_Capture_7,
    Dbg_Shift_7,
    Dbg_Update_7,
    Dbg_Rst_7,
    Dbg_Clk_8,
    Dbg_TDI_8,
    Dbg_TDO_8,
    Dbg_Reg_En_8,
    Dbg_Capture_8,
    Dbg_Shift_8,
    Dbg_Update_8,
    Dbg_Rst_8,
    Dbg_Clk_9,
    Dbg_TDI_9,
    Dbg_TDO_9,
    Dbg_Reg_En_9,
    Dbg_Capture_9,
    Dbg_Shift_9,
    Dbg_Update_9,
    Dbg_Rst_9,
    Dbg_Clk_10,
    Dbg_TDI_10,
    Dbg_TDO_10,
    Dbg_Reg_En_10,
    Dbg_Capture_10,
    Dbg_Shift_10,
    Dbg_Update_10,
    Dbg_Rst_10,
    Dbg_Clk_11,
    Dbg_TDI_11,
    Dbg_TDO_11,
    Dbg_Reg_En_11,
    Dbg_Capture_11,
    Dbg_Shift_11,
    Dbg_Update_11,
    Dbg_Rst_11,
    Dbg_Clk_12,
    Dbg_TDI_12,
    Dbg_TDO_12,
    Dbg_Reg_En_12,
    Dbg_Capture_12,
    Dbg_Shift_12,
    Dbg_Update_12,
    Dbg_Rst_12,
    Dbg_Clk_13,
    Dbg_TDI_13,
    Dbg_TDO_13,
    Dbg_Reg_En_13,
    Dbg_Capture_13,
    Dbg_Shift_13,
    Dbg_Update_13,
    Dbg_Rst_13,
    Dbg_Clk_14,
    Dbg_TDI_14,
    Dbg_TDO_14,
    Dbg_Reg_En_14,
    Dbg_Capture_14,
    Dbg_Shift_14,
    Dbg_Update_14,
    Dbg_Rst_14,
    Dbg_Clk_15,
    Dbg_TDI_15,
    Dbg_TDO_15,
    Dbg_Reg_En_15,
    Dbg_Capture_15,
    Dbg_Shift_15,
    Dbg_Update_15,
    Dbg_Rst_15,
    Dbg_Clk_16,
    Dbg_TDI_16,
    Dbg_TDO_16,
    Dbg_Reg_En_16,
    Dbg_Capture_16,
    Dbg_Shift_16,
    Dbg_Update_16,
    Dbg_Rst_16,
    Dbg_Clk_17,
    Dbg_TDI_17,
    Dbg_TDO_17,
    Dbg_Reg_En_17,
    Dbg_Capture_17,
    Dbg_Shift_17,
    Dbg_Update_17,
    Dbg_Rst_17,
    Dbg_Clk_18,
    Dbg_TDI_18,
    Dbg_TDO_18,
    Dbg_Reg_En_18,
    Dbg_Capture_18,
    Dbg_Shift_18,
    Dbg_Update_18,
    Dbg_Rst_18,
    Dbg_Clk_19,
    Dbg_TDI_19,
    Dbg_TDO_19,
    Dbg_Reg_En_19,
    Dbg_Capture_19,
    Dbg_Shift_19,
    Dbg_Update_19,
    Dbg_Rst_19,
    Dbg_Clk_20,
    Dbg_TDI_20,
    Dbg_TDO_20,
    Dbg_Reg_En_20,
    Dbg_Capture_20,
    Dbg_Shift_20,
    Dbg_Update_20,
    Dbg_Rst_20,
    Dbg_Clk_21,
    Dbg_TDI_21,
    Dbg_TDO_21,
    Dbg_Reg_En_21,
    Dbg_Capture_21,
    Dbg_Shift_21,
    Dbg_Update_21,
    Dbg_Rst_21,
    Dbg_Clk_22,
    Dbg_TDI_22,
    Dbg_TDO_22,
    Dbg_Reg_En_22,
    Dbg_Capture_22,
    Dbg_Shift_22,
    Dbg_Update_22,
    Dbg_Rst_22,
    Dbg_Clk_23,
    Dbg_TDI_23,
    Dbg_TDO_23,
    Dbg_Reg_En_23,
    Dbg_Capture_23,
    Dbg_Shift_23,
    Dbg_Update_23,
    Dbg_Rst_23,
    Dbg_Clk_24,
    Dbg_TDI_24,
    Dbg_TDO_24,
    Dbg_Reg_En_24,
    Dbg_Capture_24,
    Dbg_Shift_24,
    Dbg_Update_24,
    Dbg_Rst_24,
    Dbg_Clk_25,
    Dbg_TDI_25,
    Dbg_TDO_25,
    Dbg_Reg_En_25,
    Dbg_Capture_25,
    Dbg_Shift_25,
    Dbg_Update_25,
    Dbg_Rst_25,
    Dbg_Clk_26,
    Dbg_TDI_26,
    Dbg_TDO_26,
    Dbg_Reg_En_26,
    Dbg_Capture_26,
    Dbg_Shift_26,
    Dbg_Update_26,
    Dbg_Rst_26,
    Dbg_Clk_27,
    Dbg_TDI_27,
    Dbg_TDO_27,
    Dbg_Reg_En_27,
    Dbg_Capture_27,
    Dbg_Shift_27,
    Dbg_Update_27,
    Dbg_Rst_27,
    Dbg_Clk_28,
    Dbg_TDI_28,
    Dbg_TDO_28,
    Dbg_Reg_En_28,
    Dbg_Capture_28,
    Dbg_Shift_28,
    Dbg_Update_28,
    Dbg_Rst_28,
    Dbg_Clk_29,
    Dbg_TDI_29,
    Dbg_TDO_29,
    Dbg_Reg_En_29,
    Dbg_Capture_29,
    Dbg_Shift_29,
    Dbg_Update_29,
    Dbg_Rst_29,
    Dbg_Clk_30,
    Dbg_TDI_30,
    Dbg_TDO_30,
    Dbg_Reg_En_30,
    Dbg_Capture_30,
    Dbg_Shift_30,
    Dbg_Update_30,
    Dbg_Rst_30,
    Dbg_Clk_31,
    Dbg_TDI_31,
    Dbg_TDO_31,
    Dbg_Reg_En_31,
    Dbg_Capture_31,
    Dbg_Shift_31,
    Dbg_Update_31,
    Dbg_Rst_31,
    bscan_tdi,
    bscan_reset,
    bscan_shift,
    bscan_update,
    bscan_capture,
    bscan_sel1,
    bscan_drck1,
    bscan_tdo1,
    bscan_ext_tdi,
    bscan_ext_reset,
    bscan_ext_shift,
    bscan_ext_update,
    bscan_ext_capture,
    bscan_ext_sel,
    bscan_ext_drck,
    bscan_ext_tdo,
    Ext_JTAG_DRCK,
    Ext_JTAG_RESET,
    Ext_JTAG_SEL,
    Ext_JTAG_CAPTURE,
    Ext_JTAG_SHIFT,
    Ext_JTAG_UPDATE,
    Ext_JTAG_TDI,
    Ext_JTAG_TDO
  );
  output Interrupt;
  output Debug_SYS_Rst;
  output Ext_BRK;
  output Ext_NM_BRK;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  input SPLB_Clk;
  input SPLB_Rst;
  input [0:31] PLB_ABus;
  input [0:31] PLB_UABus;
  input PLB_PAValid;
  input PLB_SAValid;
  input PLB_rdPrim;
  input PLB_wrPrim;
  input [0:2] PLB_masterID;
  input PLB_abort;
  input PLB_busLock;
  input PLB_RNW;
  input [0:3] PLB_BE;
  input [0:1] PLB_MSize;
  input [0:3] PLB_size;
  input [0:2] PLB_type;
  input PLB_lockErr;
  input [0:31] PLB_wrDBus;
  input PLB_wrBurst;
  input PLB_rdBurst;
  input PLB_wrPendReq;
  input PLB_rdPendReq;
  input [0:1] PLB_wrPendPri;
  input [0:1] PLB_rdPendPri;
  input [0:1] PLB_reqPri;
  input [0:15] PLB_TAttribute;
  output Sl_addrAck;
  output [0:1] Sl_SSize;
  output Sl_wait;
  output Sl_rearbitrate;
  output Sl_wrDAck;
  output Sl_wrComp;
  output Sl_wrBTerm;
  output [0:31] Sl_rdDBus;
  output [0:3] Sl_rdWdAddr;
  output Sl_rdDAck;
  output Sl_rdComp;
  output Sl_rdBTerm;
  output [0:7] Sl_MBusy;
  output [0:7] Sl_MWrErr;
  output [0:7] Sl_MRdErr;
  output [0:7] Sl_MIRQ;
  output Dbg_Clk_0;
  output Dbg_TDI_0;
  input Dbg_TDO_0;
  output [0:7] Dbg_Reg_En_0;
  output Dbg_Capture_0;
  output Dbg_Shift_0;
  output Dbg_Update_0;
  output Dbg_Rst_0;
  output Dbg_Clk_1;
  output Dbg_TDI_1;
  input Dbg_TDO_1;
  output [0:7] Dbg_Reg_En_1;
  output Dbg_Capture_1;
  output Dbg_Shift_1;
  output Dbg_Update_1;
  output Dbg_Rst_1;
  output Dbg_Clk_2;
  output Dbg_TDI_2;
  input Dbg_TDO_2;
  output [0:7] Dbg_Reg_En_2;
  output Dbg_Capture_2;
  output Dbg_Shift_2;
  output Dbg_Update_2;
  output Dbg_Rst_2;
  output Dbg_Clk_3;
  output Dbg_TDI_3;
  input Dbg_TDO_3;
  output [0:7] Dbg_Reg_En_3;
  output Dbg_Capture_3;
  output Dbg_Shift_3;
  output Dbg_Update_3;
  output Dbg_Rst_3;
  output Dbg_Clk_4;
  output Dbg_TDI_4;
  input Dbg_TDO_4;
  output [0:7] Dbg_Reg_En_4;
  output Dbg_Capture_4;
  output Dbg_Shift_4;
  output Dbg_Update_4;
  output Dbg_Rst_4;
  output Dbg_Clk_5;
  output Dbg_TDI_5;
  input Dbg_TDO_5;
  output [0:7] Dbg_Reg_En_5;
  output Dbg_Capture_5;
  output Dbg_Shift_5;
  output Dbg_Update_5;
  output Dbg_Rst_5;
  output Dbg_Clk_6;
  output Dbg_TDI_6;
  input Dbg_TDO_6;
  output [0:7] Dbg_Reg_En_6;
  output Dbg_Capture_6;
  output Dbg_Shift_6;
  output Dbg_Update_6;
  output Dbg_Rst_6;
  output Dbg_Clk_7;
  output Dbg_TDI_7;
  input Dbg_TDO_7;
  output [0:7] Dbg_Reg_En_7;
  output Dbg_Capture_7;
  output Dbg_Shift_7;
  output Dbg_Update_7;
  output Dbg_Rst_7;
  output Dbg_Clk_8;
  output Dbg_TDI_8;
  input Dbg_TDO_8;
  output [0:7] Dbg_Reg_En_8;
  output Dbg_Capture_8;
  output Dbg_Shift_8;
  output Dbg_Update_8;
  output Dbg_Rst_8;
  output Dbg_Clk_9;
  output Dbg_TDI_9;
  input Dbg_TDO_9;
  output [0:7] Dbg_Reg_En_9;
  output Dbg_Capture_9;
  output Dbg_Shift_9;
  output Dbg_Update_9;
  output Dbg_Rst_9;
  output Dbg_Clk_10;
  output Dbg_TDI_10;
  input Dbg_TDO_10;
  output [0:7] Dbg_Reg_En_10;
  output Dbg_Capture_10;
  output Dbg_Shift_10;
  output Dbg_Update_10;
  output Dbg_Rst_10;
  output Dbg_Clk_11;
  output Dbg_TDI_11;
  input Dbg_TDO_11;
  output [0:7] Dbg_Reg_En_11;
  output Dbg_Capture_11;
  output Dbg_Shift_11;
  output Dbg_Update_11;
  output Dbg_Rst_11;
  output Dbg_Clk_12;
  output Dbg_TDI_12;
  input Dbg_TDO_12;
  output [0:7] Dbg_Reg_En_12;
  output Dbg_Capture_12;
  output Dbg_Shift_12;
  output Dbg_Update_12;
  output Dbg_Rst_12;
  output Dbg_Clk_13;
  output Dbg_TDI_13;
  input Dbg_TDO_13;
  output [0:7] Dbg_Reg_En_13;
  output Dbg_Capture_13;
  output Dbg_Shift_13;
  output Dbg_Update_13;
  output Dbg_Rst_13;
  output Dbg_Clk_14;
  output Dbg_TDI_14;
  input Dbg_TDO_14;
  output [0:7] Dbg_Reg_En_14;
  output Dbg_Capture_14;
  output Dbg_Shift_14;
  output Dbg_Update_14;
  output Dbg_Rst_14;
  output Dbg_Clk_15;
  output Dbg_TDI_15;
  input Dbg_TDO_15;
  output [0:7] Dbg_Reg_En_15;
  output Dbg_Capture_15;
  output Dbg_Shift_15;
  output Dbg_Update_15;
  output Dbg_Rst_15;
  output Dbg_Clk_16;
  output Dbg_TDI_16;
  input Dbg_TDO_16;
  output [0:7] Dbg_Reg_En_16;
  output Dbg_Capture_16;
  output Dbg_Shift_16;
  output Dbg_Update_16;
  output Dbg_Rst_16;
  output Dbg_Clk_17;
  output Dbg_TDI_17;
  input Dbg_TDO_17;
  output [0:7] Dbg_Reg_En_17;
  output Dbg_Capture_17;
  output Dbg_Shift_17;
  output Dbg_Update_17;
  output Dbg_Rst_17;
  output Dbg_Clk_18;
  output Dbg_TDI_18;
  input Dbg_TDO_18;
  output [0:7] Dbg_Reg_En_18;
  output Dbg_Capture_18;
  output Dbg_Shift_18;
  output Dbg_Update_18;
  output Dbg_Rst_18;
  output Dbg_Clk_19;
  output Dbg_TDI_19;
  input Dbg_TDO_19;
  output [0:7] Dbg_Reg_En_19;
  output Dbg_Capture_19;
  output Dbg_Shift_19;
  output Dbg_Update_19;
  output Dbg_Rst_19;
  output Dbg_Clk_20;
  output Dbg_TDI_20;
  input Dbg_TDO_20;
  output [0:7] Dbg_Reg_En_20;
  output Dbg_Capture_20;
  output Dbg_Shift_20;
  output Dbg_Update_20;
  output Dbg_Rst_20;
  output Dbg_Clk_21;
  output Dbg_TDI_21;
  input Dbg_TDO_21;
  output [0:7] Dbg_Reg_En_21;
  output Dbg_Capture_21;
  output Dbg_Shift_21;
  output Dbg_Update_21;
  output Dbg_Rst_21;
  output Dbg_Clk_22;
  output Dbg_TDI_22;
  input Dbg_TDO_22;
  output [0:7] Dbg_Reg_En_22;
  output Dbg_Capture_22;
  output Dbg_Shift_22;
  output Dbg_Update_22;
  output Dbg_Rst_22;
  output Dbg_Clk_23;
  output Dbg_TDI_23;
  input Dbg_TDO_23;
  output [0:7] Dbg_Reg_En_23;
  output Dbg_Capture_23;
  output Dbg_Shift_23;
  output Dbg_Update_23;
  output Dbg_Rst_23;
  output Dbg_Clk_24;
  output Dbg_TDI_24;
  input Dbg_TDO_24;
  output [0:7] Dbg_Reg_En_24;
  output Dbg_Capture_24;
  output Dbg_Shift_24;
  output Dbg_Update_24;
  output Dbg_Rst_24;
  output Dbg_Clk_25;
  output Dbg_TDI_25;
  input Dbg_TDO_25;
  output [0:7] Dbg_Reg_En_25;
  output Dbg_Capture_25;
  output Dbg_Shift_25;
  output Dbg_Update_25;
  output Dbg_Rst_25;
  output Dbg_Clk_26;
  output Dbg_TDI_26;
  input Dbg_TDO_26;
  output [0:7] Dbg_Reg_En_26;
  output Dbg_Capture_26;
  output Dbg_Shift_26;
  output Dbg_Update_26;
  output Dbg_Rst_26;
  output Dbg_Clk_27;
  output Dbg_TDI_27;
  input Dbg_TDO_27;
  output [0:7] Dbg_Reg_En_27;
  output Dbg_Capture_27;
  output Dbg_Shift_27;
  output Dbg_Update_27;
  output Dbg_Rst_27;
  output Dbg_Clk_28;
  output Dbg_TDI_28;
  input Dbg_TDO_28;
  output [0:7] Dbg_Reg_En_28;
  output Dbg_Capture_28;
  output Dbg_Shift_28;
  output Dbg_Update_28;
  output Dbg_Rst_28;
  output Dbg_Clk_29;
  output Dbg_TDI_29;
  input Dbg_TDO_29;
  output [0:7] Dbg_Reg_En_29;
  output Dbg_Capture_29;
  output Dbg_Shift_29;
  output Dbg_Update_29;
  output Dbg_Rst_29;
  output Dbg_Clk_30;
  output Dbg_TDI_30;
  input Dbg_TDO_30;
  output [0:7] Dbg_Reg_En_30;
  output Dbg_Capture_30;
  output Dbg_Shift_30;
  output Dbg_Update_30;
  output Dbg_Rst_30;
  output Dbg_Clk_31;
  output Dbg_TDI_31;
  input Dbg_TDO_31;
  output [0:7] Dbg_Reg_En_31;
  output Dbg_Capture_31;
  output Dbg_Shift_31;
  output Dbg_Update_31;
  output Dbg_Rst_31;
  output bscan_tdi;
  output bscan_reset;
  output bscan_shift;
  output bscan_update;
  output bscan_capture;
  output bscan_sel1;
  output bscan_drck1;
  input bscan_tdo1;
  input bscan_ext_tdi;
  input bscan_ext_reset;
  input bscan_ext_shift;
  input bscan_ext_update;
  input bscan_ext_capture;
  input bscan_ext_sel;
  input bscan_ext_drck;
  output bscan_ext_tdo;
  output Ext_JTAG_DRCK;
  output Ext_JTAG_RESET;
  output Ext_JTAG_SEL;
  output Ext_JTAG_CAPTURE;
  output Ext_JTAG_SHIFT;
  output Ext_JTAG_UPDATE;
  output Ext_JTAG_TDI;
  input Ext_JTAG_TDO;
endmodule

module system_clock_generator_0_wrapper
  (
    CLKIN,
    CLKOUT0,
    CLKOUT1,
    CLKOUT2,
    CLKOUT3,
    CLKOUT4,
    CLKOUT5,
    CLKOUT6,
    CLKOUT7,
    CLKOUT8,
    CLKOUT9,
    CLKOUT10,
    CLKOUT11,
    CLKOUT12,
    CLKOUT13,
    CLKOUT14,
    CLKOUT15,
    CLKFBIN,
    CLKFBOUT,
    PSCLK,
    PSEN,
    PSINCDEC,
    PSDONE,
    RST,
    LOCKED
  );
  input CLKIN;
  output CLKOUT0;
  output CLKOUT1;
  output CLKOUT2;
  output CLKOUT3;
  output CLKOUT4;
  output CLKOUT5;
  output CLKOUT6;
  output CLKOUT7;
  output CLKOUT8;
  output CLKOUT9;
  output CLKOUT10;
  output CLKOUT11;
  output CLKOUT12;
  output CLKOUT13;
  output CLKOUT14;
  output CLKOUT15;
  input CLKFBIN;
  output CLKFBOUT;
  input PSCLK;
  input PSEN;
  input PSINCDEC;
  output PSDONE;
  input RST;
  output LOCKED;
endmodule

module system_axi_timebase_wdt_0_wrapper
  (
    WDT_Reset,
    Timebase_Interrupt,
    WDT_Interrupt,
    Freeze,
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY
  );
  output WDT_Reset;
  output Timebase_Interrupt;
  output WDT_Interrupt;
  input Freeze;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [3:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [3:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
endmodule

module system_axi_interconnect_0_wrapper
  (
    INTERCONNECT_ACLK,
    INTERCONNECT_ARESETN,
    S_AXI_ARESET_OUT_N,
    M_AXI_ARESET_OUT_N,
    IRQ,
    S_AXI_ACLK,
    S_AXI_AWID,
    S_AXI_AWADDR,
    S_AXI_AWLEN,
    S_AXI_AWSIZE,
    S_AXI_AWBURST,
    S_AXI_AWLOCK,
    S_AXI_AWCACHE,
    S_AXI_AWPROT,
    S_AXI_AWQOS,
    S_AXI_AWUSER,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WID,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WLAST,
    S_AXI_WUSER,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BID,
    S_AXI_BRESP,
    S_AXI_BUSER,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARID,
    S_AXI_ARADDR,
    S_AXI_ARLEN,
    S_AXI_ARSIZE,
    S_AXI_ARBURST,
    S_AXI_ARLOCK,
    S_AXI_ARCACHE,
    S_AXI_ARPROT,
    S_AXI_ARQOS,
    S_AXI_ARUSER,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RID,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RLAST,
    S_AXI_RUSER,
    S_AXI_RVALID,
    S_AXI_RREADY,
    M_AXI_ACLK,
    M_AXI_AWID,
    M_AXI_AWADDR,
    M_AXI_AWLEN,
    M_AXI_AWSIZE,
    M_AXI_AWBURST,
    M_AXI_AWLOCK,
    M_AXI_AWCACHE,
    M_AXI_AWPROT,
    M_AXI_AWREGION,
    M_AXI_AWQOS,
    M_AXI_AWUSER,
    M_AXI_AWVALID,
    M_AXI_AWREADY,
    M_AXI_WID,
    M_AXI_WDATA,
    M_AXI_WSTRB,
    M_AXI_WLAST,
    M_AXI_WUSER,
    M_AXI_WVALID,
    M_AXI_WREADY,
    M_AXI_BID,
    M_AXI_BRESP,
    M_AXI_BUSER,
    M_AXI_BVALID,
    M_AXI_BREADY,
    M_AXI_ARID,
    M_AXI_ARADDR,
    M_AXI_ARLEN,
    M_AXI_ARSIZE,
    M_AXI_ARBURST,
    M_AXI_ARLOCK,
    M_AXI_ARCACHE,
    M_AXI_ARPROT,
    M_AXI_ARREGION,
    M_AXI_ARQOS,
    M_AXI_ARUSER,
    M_AXI_ARVALID,
    M_AXI_ARREADY,
    M_AXI_RID,
    M_AXI_RDATA,
    M_AXI_RRESP,
    M_AXI_RLAST,
    M_AXI_RUSER,
    M_AXI_RVALID,
    M_AXI_RREADY,
    S_AXI_CTRL_AWADDR,
    S_AXI_CTRL_AWVALID,
    S_AXI_CTRL_AWREADY,
    S_AXI_CTRL_WDATA,
    S_AXI_CTRL_WVALID,
    S_AXI_CTRL_WREADY,
    S_AXI_CTRL_BRESP,
    S_AXI_CTRL_BVALID,
    S_AXI_CTRL_BREADY,
    S_AXI_CTRL_ARADDR,
    S_AXI_CTRL_ARVALID,
    S_AXI_CTRL_ARREADY,
    S_AXI_CTRL_RDATA,
    S_AXI_CTRL_RRESP,
    S_AXI_CTRL_RVALID,
    S_AXI_CTRL_RREADY,
    INTERCONNECT_ARESET_OUT_N,
    DEBUG_AW_TRANS_SEQ,
    DEBUG_AW_ARB_GRANT,
    DEBUG_AR_TRANS_SEQ,
    DEBUG_AR_ARB_GRANT,
    DEBUG_AW_TRANS_QUAL,
    DEBUG_AW_ACCEPT_CNT,
    DEBUG_AW_ACTIVE_THREAD,
    DEBUG_AW_ACTIVE_TARGET,
    DEBUG_AW_ACTIVE_REGION,
    DEBUG_AW_ERROR,
    DEBUG_AW_TARGET,
    DEBUG_AR_TRANS_QUAL,
    DEBUG_AR_ACCEPT_CNT,
    DEBUG_AR_ACTIVE_THREAD,
    DEBUG_AR_ACTIVE_TARGET,
    DEBUG_AR_ACTIVE_REGION,
    DEBUG_AR_ERROR,
    DEBUG_AR_TARGET,
    DEBUG_B_TRANS_SEQ,
    DEBUG_R_BEAT_CNT,
    DEBUG_R_TRANS_SEQ,
    DEBUG_AW_ISSUING_CNT,
    DEBUG_AR_ISSUING_CNT,
    DEBUG_W_BEAT_CNT,
    DEBUG_W_TRANS_SEQ,
    DEBUG_BID_TARGET,
    DEBUG_BID_ERROR,
    DEBUG_RID_TARGET,
    DEBUG_RID_ERROR,
    DEBUG_SR_SC_ARADDR,
    DEBUG_SR_SC_ARADDRCONTROL,
    DEBUG_SR_SC_AWADDR,
    DEBUG_SR_SC_AWADDRCONTROL,
    DEBUG_SR_SC_BRESP,
    DEBUG_SR_SC_RDATA,
    DEBUG_SR_SC_RDATACONTROL,
    DEBUG_SR_SC_WDATA,
    DEBUG_SR_SC_WDATACONTROL,
    DEBUG_SC_SF_ARADDR,
    DEBUG_SC_SF_ARADDRCONTROL,
    DEBUG_SC_SF_AWADDR,
    DEBUG_SC_SF_AWADDRCONTROL,
    DEBUG_SC_SF_BRESP,
    DEBUG_SC_SF_RDATA,
    DEBUG_SC_SF_RDATACONTROL,
    DEBUG_SC_SF_WDATA,
    DEBUG_SC_SF_WDATACONTROL,
    DEBUG_SF_CB_ARADDR,
    DEBUG_SF_CB_ARADDRCONTROL,
    DEBUG_SF_CB_AWADDR,
    DEBUG_SF_CB_AWADDRCONTROL,
    DEBUG_SF_CB_BRESP,
    DEBUG_SF_CB_RDATA,
    DEBUG_SF_CB_RDATACONTROL,
    DEBUG_SF_CB_WDATA,
    DEBUG_SF_CB_WDATACONTROL,
    DEBUG_CB_MF_ARADDR,
    DEBUG_CB_MF_ARADDRCONTROL,
    DEBUG_CB_MF_AWADDR,
    DEBUG_CB_MF_AWADDRCONTROL,
    DEBUG_CB_MF_BRESP,
    DEBUG_CB_MF_RDATA,
    DEBUG_CB_MF_RDATACONTROL,
    DEBUG_CB_MF_WDATA,
    DEBUG_CB_MF_WDATACONTROL,
    DEBUG_MF_MC_ARADDR,
    DEBUG_MF_MC_ARADDRCONTROL,
    DEBUG_MF_MC_AWADDR,
    DEBUG_MF_MC_AWADDRCONTROL,
    DEBUG_MF_MC_BRESP,
    DEBUG_MF_MC_RDATA,
    DEBUG_MF_MC_RDATACONTROL,
    DEBUG_MF_MC_WDATA,
    DEBUG_MF_MC_WDATACONTROL,
    DEBUG_MC_MP_ARADDR,
    DEBUG_MC_MP_ARADDRCONTROL,
    DEBUG_MC_MP_AWADDR,
    DEBUG_MC_MP_AWADDRCONTROL,
    DEBUG_MC_MP_BRESP,
    DEBUG_MC_MP_RDATA,
    DEBUG_MC_MP_RDATACONTROL,
    DEBUG_MC_MP_WDATA,
    DEBUG_MC_MP_WDATACONTROL,
    DEBUG_MP_MR_ARADDR,
    DEBUG_MP_MR_ARADDRCONTROL,
    DEBUG_MP_MR_AWADDR,
    DEBUG_MP_MR_AWADDRCONTROL,
    DEBUG_MP_MR_BRESP,
    DEBUG_MP_MR_RDATA,
    DEBUG_MP_MR_RDATACONTROL,
    DEBUG_MP_MR_WDATA,
    DEBUG_MP_MR_WDATACONTROL
  );
  input INTERCONNECT_ACLK;
  input INTERCONNECT_ARESETN;
  output [1:0] S_AXI_ARESET_OUT_N;
  output [15:0] M_AXI_ARESET_OUT_N;
  output IRQ;
  input [1:0] S_AXI_ACLK;
  input [1:0] S_AXI_AWID;
  input [63:0] S_AXI_AWADDR;
  input [15:0] S_AXI_AWLEN;
  input [5:0] S_AXI_AWSIZE;
  input [3:0] S_AXI_AWBURST;
  input [3:0] S_AXI_AWLOCK;
  input [7:0] S_AXI_AWCACHE;
  input [5:0] S_AXI_AWPROT;
  input [7:0] S_AXI_AWQOS;
  input [1:0] S_AXI_AWUSER;
  input [1:0] S_AXI_AWVALID;
  output [1:0] S_AXI_AWREADY;
  input [1:0] S_AXI_WID;
  input [63:0] S_AXI_WDATA;
  input [7:0] S_AXI_WSTRB;
  input [1:0] S_AXI_WLAST;
  input [1:0] S_AXI_WUSER;
  input [1:0] S_AXI_WVALID;
  output [1:0] S_AXI_WREADY;
  output [1:0] S_AXI_BID;
  output [3:0] S_AXI_BRESP;
  output [1:0] S_AXI_BUSER;
  output [1:0] S_AXI_BVALID;
  input [1:0] S_AXI_BREADY;
  input [1:0] S_AXI_ARID;
  input [63:0] S_AXI_ARADDR;
  input [15:0] S_AXI_ARLEN;
  input [5:0] S_AXI_ARSIZE;
  input [3:0] S_AXI_ARBURST;
  input [3:0] S_AXI_ARLOCK;
  input [7:0] S_AXI_ARCACHE;
  input [5:0] S_AXI_ARPROT;
  input [7:0] S_AXI_ARQOS;
  input [1:0] S_AXI_ARUSER;
  input [1:0] S_AXI_ARVALID;
  output [1:0] S_AXI_ARREADY;
  output [1:0] S_AXI_RID;
  output [63:0] S_AXI_RDATA;
  output [3:0] S_AXI_RRESP;
  output [1:0] S_AXI_RLAST;
  output [1:0] S_AXI_RUSER;
  output [1:0] S_AXI_RVALID;
  input [1:0] S_AXI_RREADY;
  input [15:0] M_AXI_ACLK;
  output [15:0] M_AXI_AWID;
  output [511:0] M_AXI_AWADDR;
  output [127:0] M_AXI_AWLEN;
  output [47:0] M_AXI_AWSIZE;
  output [31:0] M_AXI_AWBURST;
  output [31:0] M_AXI_AWLOCK;
  output [63:0] M_AXI_AWCACHE;
  output [47:0] M_AXI_AWPROT;
  output [63:0] M_AXI_AWREGION;
  output [63:0] M_AXI_AWQOS;
  output [15:0] M_AXI_AWUSER;
  output [15:0] M_AXI_AWVALID;
  input [15:0] M_AXI_AWREADY;
  output [15:0] M_AXI_WID;
  output [511:0] M_AXI_WDATA;
  output [63:0] M_AXI_WSTRB;
  output [15:0] M_AXI_WLAST;
  output [15:0] M_AXI_WUSER;
  output [15:0] M_AXI_WVALID;
  input [15:0] M_AXI_WREADY;
  input [15:0] M_AXI_BID;
  input [31:0] M_AXI_BRESP;
  input [15:0] M_AXI_BUSER;
  input [15:0] M_AXI_BVALID;
  output [15:0] M_AXI_BREADY;
  output [15:0] M_AXI_ARID;
  output [511:0] M_AXI_ARADDR;
  output [127:0] M_AXI_ARLEN;
  output [47:0] M_AXI_ARSIZE;
  output [31:0] M_AXI_ARBURST;
  output [31:0] M_AXI_ARLOCK;
  output [63:0] M_AXI_ARCACHE;
  output [47:0] M_AXI_ARPROT;
  output [63:0] M_AXI_ARREGION;
  output [63:0] M_AXI_ARQOS;
  output [15:0] M_AXI_ARUSER;
  output [15:0] M_AXI_ARVALID;
  input [15:0] M_AXI_ARREADY;
  input [15:0] M_AXI_RID;
  input [511:0] M_AXI_RDATA;
  input [31:0] M_AXI_RRESP;
  input [15:0] M_AXI_RLAST;
  input [15:0] M_AXI_RUSER;
  input [15:0] M_AXI_RVALID;
  output [15:0] M_AXI_RREADY;
  input [31:0] S_AXI_CTRL_AWADDR;
  input S_AXI_CTRL_AWVALID;
  output S_AXI_CTRL_AWREADY;
  input [31:0] S_AXI_CTRL_WDATA;
  input S_AXI_CTRL_WVALID;
  output S_AXI_CTRL_WREADY;
  output [1:0] S_AXI_CTRL_BRESP;
  output S_AXI_CTRL_BVALID;
  input S_AXI_CTRL_BREADY;
  input [31:0] S_AXI_CTRL_ARADDR;
  input S_AXI_CTRL_ARVALID;
  output S_AXI_CTRL_ARREADY;
  output [31:0] S_AXI_CTRL_RDATA;
  output [1:0] S_AXI_CTRL_RRESP;
  output S_AXI_CTRL_RVALID;
  input S_AXI_CTRL_RREADY;
  output INTERCONNECT_ARESET_OUT_N;
  output [7:0] DEBUG_AW_TRANS_SEQ;
  output [7:0] DEBUG_AW_ARB_GRANT;
  output [7:0] DEBUG_AR_TRANS_SEQ;
  output [7:0] DEBUG_AR_ARB_GRANT;
  output [0:0] DEBUG_AW_TRANS_QUAL;
  output [7:0] DEBUG_AW_ACCEPT_CNT;
  output [15:0] DEBUG_AW_ACTIVE_THREAD;
  output [7:0] DEBUG_AW_ACTIVE_TARGET;
  output [7:0] DEBUG_AW_ACTIVE_REGION;
  output [7:0] DEBUG_AW_ERROR;
  output [7:0] DEBUG_AW_TARGET;
  output [0:0] DEBUG_AR_TRANS_QUAL;
  output [7:0] DEBUG_AR_ACCEPT_CNT;
  output [15:0] DEBUG_AR_ACTIVE_THREAD;
  output [7:0] DEBUG_AR_ACTIVE_TARGET;
  output [7:0] DEBUG_AR_ACTIVE_REGION;
  output [7:0] DEBUG_AR_ERROR;
  output [7:0] DEBUG_AR_TARGET;
  output [7:0] DEBUG_B_TRANS_SEQ;
  output [7:0] DEBUG_R_BEAT_CNT;
  output [7:0] DEBUG_R_TRANS_SEQ;
  output [7:0] DEBUG_AW_ISSUING_CNT;
  output [7:0] DEBUG_AR_ISSUING_CNT;
  output [7:0] DEBUG_W_BEAT_CNT;
  output [7:0] DEBUG_W_TRANS_SEQ;
  output [7:0] DEBUG_BID_TARGET;
  output DEBUG_BID_ERROR;
  output [7:0] DEBUG_RID_TARGET;
  output DEBUG_RID_ERROR;
  output [31:0] DEBUG_SR_SC_ARADDR;
  output [23:0] DEBUG_SR_SC_ARADDRCONTROL;
  output [31:0] DEBUG_SR_SC_AWADDR;
  output [23:0] DEBUG_SR_SC_AWADDRCONTROL;
  output [4:0] DEBUG_SR_SC_BRESP;
  output [31:0] DEBUG_SR_SC_RDATA;
  output [5:0] DEBUG_SR_SC_RDATACONTROL;
  output [31:0] DEBUG_SR_SC_WDATA;
  output [6:0] DEBUG_SR_SC_WDATACONTROL;
  output [31:0] DEBUG_SC_SF_ARADDR;
  output [23:0] DEBUG_SC_SF_ARADDRCONTROL;
  output [31:0] DEBUG_SC_SF_AWADDR;
  output [23:0] DEBUG_SC_SF_AWADDRCONTROL;
  output [4:0] DEBUG_SC_SF_BRESP;
  output [31:0] DEBUG_SC_SF_RDATA;
  output [5:0] DEBUG_SC_SF_RDATACONTROL;
  output [31:0] DEBUG_SC_SF_WDATA;
  output [6:0] DEBUG_SC_SF_WDATACONTROL;
  output [31:0] DEBUG_SF_CB_ARADDR;
  output [23:0] DEBUG_SF_CB_ARADDRCONTROL;
  output [31:0] DEBUG_SF_CB_AWADDR;
  output [23:0] DEBUG_SF_CB_AWADDRCONTROL;
  output [4:0] DEBUG_SF_CB_BRESP;
  output [31:0] DEBUG_SF_CB_RDATA;
  output [5:0] DEBUG_SF_CB_RDATACONTROL;
  output [31:0] DEBUG_SF_CB_WDATA;
  output [6:0] DEBUG_SF_CB_WDATACONTROL;
  output [31:0] DEBUG_CB_MF_ARADDR;
  output [23:0] DEBUG_CB_MF_ARADDRCONTROL;
  output [31:0] DEBUG_CB_MF_AWADDR;
  output [23:0] DEBUG_CB_MF_AWADDRCONTROL;
  output [4:0] DEBUG_CB_MF_BRESP;
  output [31:0] DEBUG_CB_MF_RDATA;
  output [5:0] DEBUG_CB_MF_RDATACONTROL;
  output [31:0] DEBUG_CB_MF_WDATA;
  output [6:0] DEBUG_CB_MF_WDATACONTROL;
  output [31:0] DEBUG_MF_MC_ARADDR;
  output [23:0] DEBUG_MF_MC_ARADDRCONTROL;
  output [31:0] DEBUG_MF_MC_AWADDR;
  output [23:0] DEBUG_MF_MC_AWADDRCONTROL;
  output [4:0] DEBUG_MF_MC_BRESP;
  output [31:0] DEBUG_MF_MC_RDATA;
  output [5:0] DEBUG_MF_MC_RDATACONTROL;
  output [31:0] DEBUG_MF_MC_WDATA;
  output [6:0] DEBUG_MF_MC_WDATACONTROL;
  output [31:0] DEBUG_MC_MP_ARADDR;
  output [23:0] DEBUG_MC_MP_ARADDRCONTROL;
  output [31:0] DEBUG_MC_MP_AWADDR;
  output [23:0] DEBUG_MC_MP_AWADDRCONTROL;
  output [4:0] DEBUG_MC_MP_BRESP;
  output [31:0] DEBUG_MC_MP_RDATA;
  output [5:0] DEBUG_MC_MP_RDATACONTROL;
  output [31:0] DEBUG_MC_MP_WDATA;
  output [6:0] DEBUG_MC_MP_WDATACONTROL;
  output [31:0] DEBUG_MP_MR_ARADDR;
  output [23:0] DEBUG_MP_MR_ARADDRCONTROL;
  output [31:0] DEBUG_MP_MR_AWADDR;
  output [23:0] DEBUG_MP_MR_AWADDRCONTROL;
  output [4:0] DEBUG_MP_MR_BRESP;
  output [31:0] DEBUG_MP_MR_RDATA;
  output [5:0] DEBUG_MP_MR_RDATACONTROL;
  output [31:0] DEBUG_MP_MR_WDATA;
  output [6:0] DEBUG_MP_MR_WDATACONTROL;
endmodule

module system_rs232_uart_1_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    Interrupt,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    RX,
    TX
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  output Interrupt;
  input [3:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [3:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  input RX;
  output TX;
endmodule

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
endmodule

module system_nf1_cml_interface_1_wrapper
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
endmodule

module system_nf1_cml_interface_2_wrapper
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
endmodule

module system_nf1_cml_interface_3_wrapper
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
endmodule

module system_nf10_bram_output_queues_0_wrapper
  (
    axi_aclk,
    axi_resetn,
    s_axis_tdata,
    s_axis_tstrb,
    s_axis_tuser,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata_0,
    m_axis_tstrb_0,
    m_axis_tuser_0,
    m_axis_tvalid_0,
    m_axis_tready_0,
    m_axis_tlast_0,
    m_axis_tdata_1,
    m_axis_tstrb_1,
    m_axis_tuser_1,
    m_axis_tvalid_1,
    m_axis_tready_1,
    m_axis_tlast_1,
    m_axis_tdata_2,
    m_axis_tstrb_2,
    m_axis_tuser_2,
    m_axis_tvalid_2,
    m_axis_tready_2,
    m_axis_tlast_2,
    m_axis_tdata_3,
    m_axis_tstrb_3,
    m_axis_tuser_3,
    m_axis_tvalid_3,
    m_axis_tready_3,
    m_axis_tlast_3,
    m_axis_tdata_4,
    m_axis_tstrb_4,
    m_axis_tuser_4,
    m_axis_tvalid_4,
    m_axis_tready_4,
    m_axis_tlast_4,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_RREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_AWREADY
  );
  input axi_aclk;
  input axi_resetn;
  input [255:0] s_axis_tdata;
  input [31:0] s_axis_tstrb;
  input [127:0] s_axis_tuser;
  input s_axis_tvalid;
  output s_axis_tready;
  input s_axis_tlast;
  output [255:0] m_axis_tdata_0;
  output [31:0] m_axis_tstrb_0;
  output [127:0] m_axis_tuser_0;
  output m_axis_tvalid_0;
  input m_axis_tready_0;
  output m_axis_tlast_0;
  output [255:0] m_axis_tdata_1;
  output [31:0] m_axis_tstrb_1;
  output [127:0] m_axis_tuser_1;
  output m_axis_tvalid_1;
  input m_axis_tready_1;
  output m_axis_tlast_1;
  output [255:0] m_axis_tdata_2;
  output [31:0] m_axis_tstrb_2;
  output [127:0] m_axis_tuser_2;
  output m_axis_tvalid_2;
  input m_axis_tready_2;
  output m_axis_tlast_2;
  output [255:0] m_axis_tdata_3;
  output [31:0] m_axis_tstrb_3;
  output [127:0] m_axis_tuser_3;
  output m_axis_tvalid_3;
  input m_axis_tready_3;
  output m_axis_tlast_3;
  output [255:0] m_axis_tdata_4;
  output [31:0] m_axis_tstrb_4;
  output [127:0] m_axis_tuser_4;
  output m_axis_tvalid_4;
  input m_axis_tready_4;
  output m_axis_tlast_4;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  output S_AXI_AWREADY;
endmodule

module system_nf10_input_arbiter_0_wrapper
  (
    axi_aclk,
    axi_resetn,
    m_axis_tdata,
    m_axis_tstrb,
    m_axis_tuser,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    s_axis_tdata_0,
    s_axis_tstrb_0,
    s_axis_tuser_0,
    s_axis_tvalid_0,
    s_axis_tready_0,
    s_axis_tlast_0,
    s_axis_tdata_1,
    s_axis_tstrb_1,
    s_axis_tuser_1,
    s_axis_tvalid_1,
    s_axis_tready_1,
    s_axis_tlast_1,
    s_axis_tdata_2,
    s_axis_tstrb_2,
    s_axis_tuser_2,
    s_axis_tvalid_2,
    s_axis_tready_2,
    s_axis_tlast_2,
    s_axis_tdata_3,
    s_axis_tstrb_3,
    s_axis_tuser_3,
    s_axis_tvalid_3,
    s_axis_tready_3,
    s_axis_tlast_3,
    s_axis_tdata_4,
    s_axis_tstrb_4,
    s_axis_tuser_4,
    s_axis_tvalid_4,
    s_axis_tready_4,
    s_axis_tlast_4,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_RREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_AWREADY
  );
  input axi_aclk;
  input axi_resetn;
  output [255:0] m_axis_tdata;
  output [31:0] m_axis_tstrb;
  output [127:0] m_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output m_axis_tlast;
  input [255:0] s_axis_tdata_0;
  input [31:0] s_axis_tstrb_0;
  input [127:0] s_axis_tuser_0;
  input s_axis_tvalid_0;
  output s_axis_tready_0;
  input s_axis_tlast_0;
  input [255:0] s_axis_tdata_1;
  input [31:0] s_axis_tstrb_1;
  input [127:0] s_axis_tuser_1;
  input s_axis_tvalid_1;
  output s_axis_tready_1;
  input s_axis_tlast_1;
  input [255:0] s_axis_tdata_2;
  input [31:0] s_axis_tstrb_2;
  input [127:0] s_axis_tuser_2;
  input s_axis_tvalid_2;
  output s_axis_tready_2;
  input s_axis_tlast_2;
  input [255:0] s_axis_tdata_3;
  input [31:0] s_axis_tstrb_3;
  input [127:0] s_axis_tuser_3;
  input s_axis_tvalid_3;
  output s_axis_tready_3;
  input s_axis_tlast_3;
  input [255:0] s_axis_tdata_4;
  input [31:0] s_axis_tstrb_4;
  input [127:0] s_axis_tuser_4;
  input s_axis_tvalid_4;
  output s_axis_tready_4;
  input s_axis_tlast_4;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  output S_AXI_AWREADY;
endmodule

module system_dma_0_wrapper
  (
    reset_n,
    pcie_clk_p,
    pcie_clk_n,
    pci_exp_0_txp,
    pci_exp_0_txn,
    pci_exp_0_rxp,
    pci_exp_0_rxn,
    pci_exp_1_txp,
    pci_exp_1_txn,
    pci_exp_1_rxp,
    pci_exp_1_rxn,
    pci_exp_2_txp,
    pci_exp_2_txn,
    pci_exp_2_rxp,
    pci_exp_2_rxn,
    pci_exp_3_txp,
    pci_exp_3_txn,
    pci_exp_3_rxp,
    pci_exp_3_rxn,
    M_AXI_LITE_ACLK,
    M_AXI_LITE_ARESETN,
    M_AXI_LITE_AWADDR,
    M_AXI_LITE_AWVALID,
    M_AXI_LITE_AWREADY,
    M_AXI_LITE_WDATA,
    M_AXI_LITE_WSTRB,
    M_AXI_LITE_WVALID,
    M_AXI_LITE_WREADY,
    M_AXI_LITE_BRESP,
    M_AXI_LITE_BVALID,
    M_AXI_LITE_BREADY,
    M_AXI_LITE_ARADDR,
    M_AXI_LITE_ARVALID,
    M_AXI_LITE_ARREADY,
    M_AXI_LITE_RDATA,
    M_AXI_LITE_RRESP,
    M_AXI_LITE_RVALID,
    M_AXI_LITE_RREADY,
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    M_AXIS_ACLK,
    M_AXIS_TDATA,
    M_AXIS_TSTRB,
    M_AXIS_TUSER,
    M_AXIS_TVALID,
    M_AXIS_TREADY,
    M_AXIS_TLAST,
    S_AXIS_ACLK,
    S_AXIS_TDATA,
    S_AXIS_TSTRB,
    S_AXIS_TUSER,
    S_AXIS_TVALID,
    S_AXIS_TREADY,
    S_AXIS_TLAST
  );
  input reset_n;
  input pcie_clk_p;
  input pcie_clk_n;
  output pci_exp_0_txp;
  output pci_exp_0_txn;
  input pci_exp_0_rxp;
  input pci_exp_0_rxn;
  output pci_exp_1_txp;
  output pci_exp_1_txn;
  input pci_exp_1_rxp;
  input pci_exp_1_rxn;
  output pci_exp_2_txp;
  output pci_exp_2_txn;
  input pci_exp_2_rxp;
  input pci_exp_2_rxn;
  output pci_exp_3_txp;
  output pci_exp_3_txn;
  input pci_exp_3_rxp;
  input pci_exp_3_rxn;
  input M_AXI_LITE_ACLK;
  input M_AXI_LITE_ARESETN;
  output [31:0] M_AXI_LITE_AWADDR;
  output M_AXI_LITE_AWVALID;
  input M_AXI_LITE_AWREADY;
  output [31:0] M_AXI_LITE_WDATA;
  output [3:0] M_AXI_LITE_WSTRB;
  output M_AXI_LITE_WVALID;
  input M_AXI_LITE_WREADY;
  input [1:0] M_AXI_LITE_BRESP;
  input M_AXI_LITE_BVALID;
  output M_AXI_LITE_BREADY;
  output [31:0] M_AXI_LITE_ARADDR;
  output M_AXI_LITE_ARVALID;
  input M_AXI_LITE_ARREADY;
  input [31:0] M_AXI_LITE_RDATA;
  input [1:0] M_AXI_LITE_RRESP;
  input M_AXI_LITE_RVALID;
  output M_AXI_LITE_RREADY;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  input M_AXIS_ACLK;
  output [255:0] M_AXIS_TDATA;
  output [31:0] M_AXIS_TSTRB;
  output [127:0] M_AXIS_TUSER;
  output M_AXIS_TVALID;
  input M_AXIS_TREADY;
  output M_AXIS_TLAST;
  input S_AXIS_ACLK;
  input [255:0] S_AXIS_TDATA;
  input [31:0] S_AXIS_TSTRB;
  input [127:0] S_AXIS_TUSER;
  input S_AXIS_TVALID;
  output S_AXIS_TREADY;
  input S_AXIS_TLAST;
endmodule

module system_clock_generator_1_wrapper
  (
    CLKIN,
    CLKOUT0,
    CLKOUT1,
    CLKOUT2,
    CLKOUT3,
    CLKOUT4,
    CLKOUT5,
    CLKOUT6,
    CLKOUT7,
    CLKOUT8,
    CLKOUT9,
    CLKOUT10,
    CLKOUT11,
    CLKOUT12,
    CLKOUT13,
    CLKOUT14,
    CLKOUT15,
    CLKFBIN,
    CLKFBOUT,
    PSCLK,
    PSEN,
    PSINCDEC,
    PSDONE,
    RST,
    LOCKED
  );
  input CLKIN;
  output CLKOUT0;
  output CLKOUT1;
  output CLKOUT2;
  output CLKOUT3;
  output CLKOUT4;
  output CLKOUT5;
  output CLKOUT6;
  output CLKOUT7;
  output CLKOUT8;
  output CLKOUT9;
  output CLKOUT10;
  output CLKOUT11;
  output CLKOUT12;
  output CLKOUT13;
  output CLKOUT14;
  output CLKOUT15;
  input CLKFBIN;
  output CLKFBOUT;
  input PSCLK;
  input PSEN;
  input PSINCDEC;
  output PSDONE;
  input RST;
  output LOCKED;
endmodule

module system_mdio_ctrl_0_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    mdc,
    mdio,
    phy_rstn
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  output mdc;
  inout mdio;
  output [3:0] phy_rstn;
endmodule

module system_axi_gpio_bpi_if_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    IP2INTC_Irpt,
    GPIO_IO_I,
    GPIO_IO_O,
    GPIO_IO_T,
    GPIO2_IO_I,
    GPIO2_IO_O,
    GPIO2_IO_T
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [8:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [8:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  output IP2INTC_Irpt;
  input [29:0] GPIO_IO_I;
  output [29:0] GPIO_IO_O;
  output [29:0] GPIO_IO_T;
  input [15:0] GPIO2_IO_I;
  output [15:0] GPIO2_IO_O;
  output [15:0] GPIO2_IO_T;
endmodule

module system_axi_hwicap_0_wrapper
  (
    ICAP_Clk,
    EOS_IN,
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    IP2INTC_Irpt
  );
  input ICAP_Clk;
  input EOS_IN;
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [8:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  output S_AXI_AWREADY;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  input S_AXI_BREADY;
  input [8:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  input S_AXI_RREADY;
  output IP2INTC_Irpt;
endmodule

module system_nf10_identifier_0_wrapper
  (
    S_AXI_ACLK,
    S_AXI_ARESETN,
    S_AXI_AWADDR,
    S_AXI_AWVALID,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARVALID,
    S_AXI_RREADY,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_AWREADY
  );
  input S_AXI_ACLK;
  input S_AXI_ARESETN;
  input [31:0] S_AXI_AWADDR;
  input S_AXI_AWVALID;
  input [31:0] S_AXI_WDATA;
  input [3:0] S_AXI_WSTRB;
  input S_AXI_WVALID;
  input S_AXI_BREADY;
  input [31:0] S_AXI_ARADDR;
  input S_AXI_ARVALID;
  input S_AXI_RREADY;
  output S_AXI_ARREADY;
  output [31:0] S_AXI_RDATA;
  output [1:0] S_AXI_RRESP;
  output S_AXI_RVALID;
  output S_AXI_WREADY;
  output [1:0] S_AXI_BRESP;
  output S_AXI_BVALID;
  output S_AXI_AWREADY;
endmodule

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
endmodule

