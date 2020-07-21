-------------------------------------------------------------------------------
-- system_axi_hwicap_0_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library axi_hwicap_v2_03_a;
use axi_hwicap_v2_03_a.all;

entity system_axi_hwicap_0_wrapper is
  port (
    ICAP_Clk : in std_logic;
    EOS_IN : in std_logic;
    S_AXI_ACLK : in std_logic;
    S_AXI_ARESETN : in std_logic;
    S_AXI_AWADDR : in std_logic_vector(8 downto 0);
    S_AXI_AWVALID : in std_logic;
    S_AXI_AWREADY : out std_logic;
    S_AXI_WDATA : in std_logic_vector(31 downto 0);
    S_AXI_WSTRB : in std_logic_vector(3 downto 0);
    S_AXI_WVALID : in std_logic;
    S_AXI_WREADY : out std_logic;
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    S_AXI_BVALID : out std_logic;
    S_AXI_BREADY : in std_logic;
    S_AXI_ARADDR : in std_logic_vector(8 downto 0);
    S_AXI_ARVALID : in std_logic;
    S_AXI_ARREADY : out std_logic;
    S_AXI_RDATA : out std_logic_vector(31 downto 0);
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    S_AXI_RVALID : out std_logic;
    S_AXI_RREADY : in std_logic;
    IP2INTC_Irpt : out std_logic
  );

  attribute x_core_info : STRING;
  attribute x_core_info of system_axi_hwicap_0_wrapper : entity is "axi_hwicap_v2_03_a";

end system_axi_hwicap_0_wrapper;

architecture STRUCTURE of system_axi_hwicap_0_wrapper is

  component axi_hwicap is
    generic (
      C_S_AXI_DATA_WIDTH : INTEGER;
      C_S_AXI_ADDR_WIDTH : INTEGER;
      C_MODE : INTEGER;
      C_NOREAD : INTEGER;
      C_WRITE_FIFO_DEPTH : INTEGER;
      C_READ_FIFO_DEPTH : INTEGER;
      C_ICAP_WIDTH_S : STRING;
      C_SIMULATION : INTEGER;
      C_ENABLE_ASYNC : INTEGER;
      C_BRAM_SRL_FIFO_TYPE : INTEGER;
      C_DEVICE_ID : std_logic_vector;
      C_INCLUDE_STARTUP : INTEGER;
      C_FAMILY : STRING;
      C_INSTANCE : STRING
    );
    port (
      ICAP_Clk : in std_logic;
      EOS_IN : in std_logic;
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_WDATA : in std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_WSTRB : in std_logic_vector(((C_S_AXI_DATA_WIDTH/8)-1) downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector((C_S_AXI_ADDR_WIDTH-1) downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector((C_S_AXI_DATA_WIDTH-1) downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in std_logic;
      IP2INTC_Irpt : out std_logic
    );
  end component;

begin

  axi_hwicap_0 : axi_hwicap
    generic map (
      C_S_AXI_DATA_WIDTH => 32,
      C_S_AXI_ADDR_WIDTH => 9,
      C_MODE => 0,
      C_NOREAD => 0,
      C_WRITE_FIFO_DEPTH => 64,
      C_READ_FIFO_DEPTH => 128,
      C_ICAP_WIDTH_S => "X32",
      C_SIMULATION => 2,
      C_ENABLE_ASYNC => 0,
      C_BRAM_SRL_FIFO_TYPE => 1,
      C_DEVICE_ID => X"04222093",
      C_INCLUDE_STARTUP => 1,
      C_FAMILY => "kintex7",
      C_INSTANCE => "axi_hwicap_0"
    )
    port map (
      ICAP_Clk => ICAP_Clk,
      EOS_IN => EOS_IN,
      S_AXI_ACLK => S_AXI_ACLK,
      S_AXI_ARESETN => S_AXI_ARESETN,
      S_AXI_AWADDR => S_AXI_AWADDR,
      S_AXI_AWVALID => S_AXI_AWVALID,
      S_AXI_AWREADY => S_AXI_AWREADY,
      S_AXI_WDATA => S_AXI_WDATA,
      S_AXI_WSTRB => S_AXI_WSTRB,
      S_AXI_WVALID => S_AXI_WVALID,
      S_AXI_WREADY => S_AXI_WREADY,
      S_AXI_BRESP => S_AXI_BRESP,
      S_AXI_BVALID => S_AXI_BVALID,
      S_AXI_BREADY => S_AXI_BREADY,
      S_AXI_ARADDR => S_AXI_ARADDR,
      S_AXI_ARVALID => S_AXI_ARVALID,
      S_AXI_ARREADY => S_AXI_ARREADY,
      S_AXI_RDATA => S_AXI_RDATA,
      S_AXI_RRESP => S_AXI_RRESP,
      S_AXI_RVALID => S_AXI_RVALID,
      S_AXI_RREADY => S_AXI_RREADY,
      IP2INTC_Irpt => IP2INTC_Irpt
    );

end architecture STRUCTURE;

