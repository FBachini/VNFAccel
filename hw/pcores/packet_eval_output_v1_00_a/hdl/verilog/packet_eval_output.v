/*
################################################################################
#
#  NetFPGA-10G http://www.netfpga.org
#
#  File:
#        packet_eval_output.v 
#
#  Author:
#        fbachini
#
#  Description:
#        packet_eval_output's Verilog Top Module File
#
#  Copyright notice:
#        Copyright (C) 2010, 2011 The Board of Trustees of The Leland Stanford
#                                 Junior University
#
#  Licence:
#        This file is part of the NetFPGA 10G development base package.
#
#        This file is free code: you can redistribute it and/or modify it under
#        the terms of the GNU Lesser General Public License version 2.1 as
#        published by the Free Software Foundation.
#
#        This package is distributed in the hope that it will be useful, but
#        WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#        Lesser General Public License for more details.
#
#        You should have received a copy of the GNU Lesser General Public
#        License along with the NetFPGA source package.  If not, see
#        http://www.gnu.org/licenses/.
#
#
*/
module packet_eval_output
#(
    // Master AXI Stream Data Width
    parameter C_M_AXIS_DATA_WIDTH=256,
    parameter C_S_AXIS_DATA_WIDTH=256,
    parameter C_M_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXIS_TUSER_WIDTH=128,
    parameter C_S_AXI_DATA_WIDTH=32,
    parameter C_S_AXI_ADDR_WIDTH=32,
    parameter C_USE_WSTRB=0,
    parameter C_DPHASE_TIMEOUT=0,
    parameter C_BASEADDR=32'hFFFFFFFF,
    parameter C_HIGHADDR=32'h00000000,
    parameter C_S_AXI_ACLK_FREQ_HZ=100
)
(
    // Master Stream Ports (interface to data path downstream)
    output [C_M_AXIS_DATA_WIDTH - 1:0]         m_axis_tdata,
    output [((C_M_AXIS_DATA_WIDTH / 8)) - 1:0] m_axis_tstrb,
    output [C_M_AXIS_TUSER_WIDTH-1:0]          m_axis_tuser,
    output                                     m_axis_tvalid,
    input                                      m_axis_tready,
    output                                     m_axis_tlast,

    // Slave Stream Ports (interface to data path upstream)
    input [C_S_AXIS_DATA_WIDTH - 1:0]          s_axis_tdata,
    input [((C_S_AXIS_DATA_WIDTH / 8)) - 1:0]  s_axis_tstrb,
    input [C_S_AXIS_TUSER_WIDTH-1:0]           s_axis_tuser,
    input                                      s_axis_tvalid,
    output                                     s_axis_tready,
    input                                      s_axis_tlast,

    // AXI Lite control/status interface
    input                                      s_axi_aclk,
    input                                      s_axi_aresetn,
    input  [C_S_AXI_ADDR_WIDTH-1:0]            s_axi_awaddr,
    input                                      s_axi_awvalid,
    output                                     s_axi_awready,
    input  [C_S_AXI_DATA_WIDTH-1:0]            s_axi_wdata,
    input  [((C_S_AXI_DATA_WIDTH / 8)) - 1:0]  s_axi_wstrb,
    input                                      s_axi_wvalid,
    output                                     s_axi_wready,
    output [1:0]                               s_axi_bresp,
    output                                     s_axi_bvalid,
    input                                      s_axi_bready,
    input  [C_S_AXI_ADDR_WIDTH-1:0]            s_axi_araddr,
    input                                      s_axi_arvalid,
    output                                     s_axi_arready,
    output [C_S_AXI_DATA_WIDTH-1:0]            s_axi_rdata,
    output [1:0]                               s_axi_rresp,
    output                                     s_axi_rvalid,
    input                                      s_axi_rready
);

   function integer log2;
      input integer number;
      begin
         log2=0;
         while(2**log2<number) begin
            log2=log2+1;
         end
      end
   endfunction // log2

   // --------- Internal Parameters ------
   localparam NUM_RW_REGS = 6;
   localparam NUM_WO_REGS = 1;
   localparam NUM_RO_REGS = 1;

   // ------------- Regs/ wires -----------

   wire [NUM_WO_REGS*C_S_AXI_DATA_WIDTH-1:0] wo_regs;
   wire [NUM_RW_REGS*C_S_AXI_DATA_WIDTH-1:0] rw_regs;
   wire [NUM_RO_REGS*C_S_AXI_DATA_WIDTH-1:0] ro_regs;

   wire                                            Bus2IP_Clk;
   wire                                            Bus2IP_Resetn;
   wire     [C_S_AXI_ADDR_WIDTH-1 : 0]             Bus2IP_Addr;
   wire                                            Bus2IP_CS;
   wire                                            Bus2IP_RNW;
   wire     [C_S_AXI_DATA_WIDTH-1 : 0]             Bus2IP_Data;
   wire     [C_S_AXI_DATA_WIDTH/8-1 : 0]           Bus2IP_BE;
   wire     [C_S_AXI_DATA_WIDTH-1 : 0]             IP2Bus_Data;
   wire                                            IP2Bus_RdAck;
   wire                                            IP2Bus_WrAck;
   wire                                            IP2Bus_Error;

  wire [14:0]					 regex_din;
  wire [13:0]					 regex_in_addr;

  wire [31:0]					 output_selector;

  wire [63:0]					 firewall_din;
  wire [18:0]					 firewall_in_addr;

   // ------------ Modules -------------

 // -- AXILITE IPIF
  axi_lite_ipif_1bar #
  (
   .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
   .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),
    .C_USE_WSTRB        (C_USE_WSTRB),
    .C_DPHASE_TIMEOUT   (C_DPHASE_TIMEOUT),
   .C_BAR0_BASEADDR    (C_BASEADDR),
   .C_BAR0_HIGHADDR    (C_HIGHADDR)
  ) axi_lite_ipif
  (
    .S_AXI_ACLK          ( s_axi_aclk     ),
    .S_AXI_ARESETN       ( s_axi_aresetn  ),
    .S_AXI_AWADDR        ( s_axi_awaddr   ),
    .S_AXI_AWVALID       ( s_axi_awvalid  ),
    .S_AXI_WDATA         ( s_axi_wdata    ),
    .S_AXI_WSTRB         ( s_axi_wstrb    ),
    .S_AXI_WVALID        ( s_axi_wvalid   ),
    .S_AXI_BREADY        ( s_axi_bready   ),
    .S_AXI_ARADDR        ( s_axi_araddr   ),
    .S_AXI_ARVALID       ( s_axi_arvalid  ),
    .S_AXI_RREADY        ( s_axi_rready   ),
    .S_AXI_ARREADY       ( s_axi_arready  ),
    .S_AXI_RDATA         ( s_axi_rdata    ),
    .S_AXI_RRESP         ( s_axi_rresp    ),
    .S_AXI_RVALID        ( s_axi_rvalid   ),
    .S_AXI_WREADY        ( s_axi_wready   ),
    .S_AXI_BRESP         ( s_axi_bresp    ),
    .S_AXI_BVALID        ( s_axi_bvalid   ),
    .S_AXI_AWREADY       ( s_axi_awready  ),

    // Controls to the IP/IPIF modules
    .Bus2IP_Clk          ( Bus2IP_Clk     ),
    .Bus2IP_Resetn       ( Bus2IP_Resetn  ),
    .Bus2IP_Addr         ( Bus2IP_Addr    ),
    .Bus2IP_RNW          ( Bus2IP_RNW     ),
    .Bus2IP_BE           ( Bus2IP_BE      ),
    .Bus2IP_CS           ( Bus2IP_CS      ),
    .Bus2IP_Data         ( Bus2IP_Data    ),
    .IP2Bus_Data         ( IP2Bus_Data    ),
    .IP2Bus_WrAck        ( IP2Bus_WrAck   ),
    .IP2Bus_RdAck        ( IP2Bus_RdAck   ),
    .IP2Bus_Error        ( IP2Bus_Error   )
  );

  // -- IPIF REGS
  ipif_regs #
  (
    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH),
    .NUM_WO_REGS        (NUM_WO_REGS),
    .NUM_RW_REGS        (NUM_RW_REGS),
    .NUM_RO_REGS        (NUM_RO_REGS)
  ) ipif_regs
  (
    .Bus2IP_Clk     ( Bus2IP_Clk     ),
    .Bus2IP_Resetn  ( Bus2IP_Resetn  ),
    .Bus2IP_Addr    ( Bus2IP_Addr    ),
    .Bus2IP_CS      ( Bus2IP_CS      ),
    .Bus2IP_RNW     ( Bus2IP_RNW     ),
    .Bus2IP_Data    ( Bus2IP_Data    ),
    .Bus2IP_BE      ( Bus2IP_BE      ),
    .IP2Bus_Data    ( IP2Bus_Data    ),
    .IP2Bus_RdAck   ( IP2Bus_RdAck   ),
    .IP2Bus_WrAck   ( IP2Bus_WrAck   ),
    .IP2Bus_Error   ( IP2Bus_Error   ),
    
    .wo_regs        ( wo_regs ),
    .rw_regs        ( rw_regs ),
    .ro_regs        ( ro_regs )
  );

  assign regex_din = rw_regs[14:0];			// REGISTRADORES AQUI
 
  assign regex_in_addr = rw_regs[13+C_S_AXI_DATA_WIDTH:C_S_AXI_DATA_WIDTH];

  assign output_selector = rw_regs[31+C_S_AXI_DATA_WIDTH*2:C_S_AXI_DATA_WIDTH*2];

  assign firewall_din = rw_regs[63+C_S_AXI_DATA_WIDTH*3:C_S_AXI_DATA_WIDTH*3];		
  assign firewall_in_addr = rw_regs[20+C_S_AXI_DATA_WIDTH*5:C_S_AXI_DATA_WIDTH*5];

   // user_logic (user_logic)
   user_logic #
   (
     .C_M_AXIS_DATA_WIDTH  (C_M_AXIS_DATA_WIDTH),
     .C_S_AXIS_DATA_WIDTH  (C_S_AXIS_DATA_WIDTH),
     .C_M_AXIS_TUSER_WIDTH (C_M_AXIS_TUSER_WIDTH),
     .C_S_AXIS_TUSER_WIDTH (C_S_AXIS_TUSER_WIDTH),

     .NUM_WO_REGS          (NUM_WO_REGS),
     .NUM_RW_REGS          (NUM_RW_REGS),
     .NUM_RO_REGS          (NUM_RO_REGS)
   )
     user_logic
       (
         // Global Ports
         .axi_aclk      (s_axi_aclk),
         .axi_aresetn   (s_axi_aresetn),

         // Master Stream Ports (interface to data path)
         .m_axis_tdata  (m_axis_tdata),
         .m_axis_tstrb  (m_axis_tstrb),
         .m_axis_tuser  (m_axis_tuser),
         .m_axis_tvalid (m_axis_tvalid),
         .m_axis_tready (m_axis_tready),
         .m_axis_tlast  (m_axis_tlast),

         // Slave Stream Ports (interface to RX queues)
         .s_axis_tdata  (s_axis_tdata),
         .s_axis_tstrb  (s_axis_tstrb),
         .s_axis_tuser  (s_axis_tuser),
         .s_axis_tvalid (s_axis_tvalid),
         .s_axis_tready (s_axis_tready),
         .s_axis_tlast  (s_axis_tlast),

   	// --- interface to regex_match

    	.regex_din		  (regex_din),
    	.regex_in_addr		  (regex_in_addr),

   	// --- interface to firewall
  
    	.firewall_din		  	  (firewall_din),
    	.firewall_in_addr		  (firewall_in_addr),

   	// -- Firewall/Regex Selector

    	.output_selector		  (output_selector),

         // Registers
         .wo_regs       (wo_regs),
         .rw_regs       (rw_regs),
         .ro_regs       (ro_regs)
       );

endmodule
