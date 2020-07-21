//-----------------------------------------------------------------------------
// system_stub.v
//-----------------------------------------------------------------------------

module system_stub
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

  (* BOX_TYPE = "user_black_box" *)
  system
    system_i (
      .uart_tx ( uart_tx ),
      .uart_rx ( uart_rx ),
      .reset_n ( reset_n ),
      .clk_in_p ( clk_in_p ),
      .clk_in_n ( clk_in_n ),
      .rgmii_tx_ctl_1 ( rgmii_tx_ctl_1 ),
      .rgmii_txd_1 ( rgmii_txd_1 ),
      .rgmii_rxd_1 ( rgmii_rxd_1 ),
      .rgmii_rxc_1 ( rgmii_rxc_1 ),
      .rgmii_rx_ctl_1 ( rgmii_rx_ctl_1 ),
      .rgmii_txc_1 ( rgmii_txc_1 ),
      .rgmii_tx_ctl_2 ( rgmii_tx_ctl_2 ),
      .rgmii_txd_2 ( rgmii_txd_2 ),
      .rgmii_rxd_2 ( rgmii_rxd_2 ),
      .rgmii_rxc_2 ( rgmii_rxc_2 ),
      .rgmii_rx_ctl_2 ( rgmii_rx_ctl_2 ),
      .rgmii_txc_2 ( rgmii_txc_2 ),
      .rgmii_tx_ctl_3 ( rgmii_tx_ctl_3 ),
      .rgmii_txd_3 ( rgmii_txd_3 ),
      .rgmii_rxd_3 ( rgmii_rxd_3 ),
      .rgmii_rxc_3 ( rgmii_rxc_3 ),
      .rgmii_rx_ctl_3 ( rgmii_rx_ctl_3 ),
      .rgmii_txc_3 ( rgmii_txc_3 ),
      .rgmii_txc_4 ( rgmii_txc_4 ),
      .rgmii_txd_4 ( rgmii_txd_4 ),
      .rgmii_rxd_4 ( rgmii_rxd_4 ),
      .rgmii_rxc_4 ( rgmii_rxc_4 ),
      .rgmii_rx_ctl_4 ( rgmii_rx_ctl_4 ),
      .rgmii_tx_ctl_4 ( rgmii_tx_ctl_4 ),
      .dma_0_pci_exp_1_txn_pin ( dma_0_pci_exp_1_txn_pin ),
      .dma_0_pci_exp_1_rxp_pin ( dma_0_pci_exp_1_rxp_pin ),
      .dma_0_pci_exp_0_txp_pin ( dma_0_pci_exp_0_txp_pin ),
      .dma_0_pci_exp_0_txn_pin ( dma_0_pci_exp_0_txn_pin ),
      .dma_0_pci_exp_0_rxn_pin ( dma_0_pci_exp_0_rxn_pin ),
      .dma_0_pci_exp_1_txp_pin ( dma_0_pci_exp_1_txp_pin ),
      .dma_0_pci_exp_1_rxn_pin ( dma_0_pci_exp_1_rxn_pin ),
      .dma_0_pci_exp_2_txp_pin ( dma_0_pci_exp_2_txp_pin ),
      .dma_0_pci_exp_2_txn_pin ( dma_0_pci_exp_2_txn_pin ),
      .dma_0_pci_exp_2_rxp_pin ( dma_0_pci_exp_2_rxp_pin ),
      .dma_0_pci_exp_2_rxn_pin ( dma_0_pci_exp_2_rxn_pin ),
      .dma_0_pci_exp_3_txp_pin ( dma_0_pci_exp_3_txp_pin ),
      .dma_0_pci_exp_3_txn_pin ( dma_0_pci_exp_3_txn_pin ),
      .dma_0_pci_exp_3_rxp_pin ( dma_0_pci_exp_3_rxp_pin ),
      .dma_0_pci_exp_3_rxn_pin ( dma_0_pci_exp_3_rxn_pin ),
      .dma_0_pci_exp_0_rxp_pin ( dma_0_pci_exp_0_rxp_pin ),
      .dma_0_pcie_clk_n_pin ( dma_0_pcie_clk_n_pin ),
      .dma_0_pcie_clk_p_pin ( dma_0_pcie_clk_p_pin ),
      .util_ds_buf_0_IBUF_DS_P_pin ( util_ds_buf_0_IBUF_DS_P_pin ),
      .mdc ( mdc ),
      .mdio ( mdio ),
      .phy_rstn ( phy_rstn ),
      .bpi_addr_cmd ( bpi_addr_cmd ),
      .bpi_data ( bpi_data )
    );

endmodule

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
endmodule

