//-----------------------------------------------------------------------------
// microblaze_0_bram_block_elaborate.v
//-----------------------------------------------------------------------------

(* keep_hierarchy = "yes" *)
module microblaze_0_bram_block_elaborate
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
  parameter
    C_MEMSIZE = 'h4000,
    C_PORT_DWIDTH = 32,
    C_PORT_AWIDTH = 32,
    C_NUM_WE = 4,
    C_FAMILY = "kintex7";
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:C_NUM_WE-1] BRAM_WEN_A;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_A;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_A;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:C_NUM_WE-1] BRAM_WEN_B;
  input [0:C_PORT_AWIDTH-1] BRAM_Addr_B;
  output [0:C_PORT_DWIDTH-1] BRAM_Din_B;
  input [0:C_PORT_DWIDTH-1] BRAM_Dout_B;

  // Internal signals

  wire net_gnd0;
  wire [3:0] net_gnd4;
  wire [0:0] pgassign1;
  wire [0:2] pgassign2;
  wire [0:23] pgassign3;
  wire [0:3] pgassign4;
  wire [15:0] pgassign5;
  wire [31:0] pgassign6;
  wire [31:0] pgassign7;
  wire [3:0] pgassign8;
  wire [15:0] pgassign9;
  wire [31:0] pgassign10;
  wire [31:0] pgassign11;
  wire [7:0] pgassign12;
  wire [15:0] pgassign13;
  wire [31:0] pgassign14;
  wire [31:0] pgassign15;
  wire [3:0] pgassign16;
  wire [15:0] pgassign17;
  wire [31:0] pgassign18;
  wire [31:0] pgassign19;
  wire [7:0] pgassign20;
  wire [15:0] pgassign21;
  wire [31:0] pgassign22;
  wire [31:0] pgassign23;
  wire [3:0] pgassign24;
  wire [15:0] pgassign25;
  wire [31:0] pgassign26;
  wire [31:0] pgassign27;
  wire [7:0] pgassign28;
  wire [15:0] pgassign29;
  wire [31:0] pgassign30;
  wire [31:0] pgassign31;
  wire [3:0] pgassign32;
  wire [15:0] pgassign33;
  wire [31:0] pgassign34;
  wire [31:0] pgassign35;
  wire [7:0] pgassign36;

  // Internal assignments

  assign pgassign1[0:0] = 1'b1;
  assign pgassign2[0:2] = 3'b000;
  assign pgassign3[0:23] = 24'b000000000000000000000000;
  assign pgassign4[0:3] = 4'b0000;
  assign pgassign5[15:15] = 1'b1;
  assign pgassign5[14:3] = BRAM_Addr_A[18:29];
  assign pgassign5[2:0] = 3'b000;
  assign pgassign6[31:8] = 24'b000000000000000000000000;
  assign pgassign6[7:0] = BRAM_Dout_A[0:7];
  assign BRAM_Din_A[0:7] = pgassign7[7:0];
  assign pgassign8[3:3] = BRAM_WEN_A[0:0];
  assign pgassign8[2:2] = BRAM_WEN_A[0:0];
  assign pgassign8[1:1] = BRAM_WEN_A[0:0];
  assign pgassign8[0:0] = BRAM_WEN_A[0:0];
  assign pgassign9[15:15] = 1'b1;
  assign pgassign9[14:3] = BRAM_Addr_B[18:29];
  assign pgassign9[2:0] = 3'b000;
  assign pgassign10[31:8] = 24'b000000000000000000000000;
  assign pgassign10[7:0] = BRAM_Dout_B[0:7];
  assign BRAM_Din_B[0:7] = pgassign11[7:0];
  assign pgassign12[7:4] = 4'b0000;
  assign pgassign12[3:3] = BRAM_WEN_B[0:0];
  assign pgassign12[2:2] = BRAM_WEN_B[0:0];
  assign pgassign12[1:1] = BRAM_WEN_B[0:0];
  assign pgassign12[0:0] = BRAM_WEN_B[0:0];
  assign pgassign13[15:15] = 1'b1;
  assign pgassign13[14:3] = BRAM_Addr_A[18:29];
  assign pgassign13[2:0] = 3'b000;
  assign pgassign14[31:8] = 24'b000000000000000000000000;
  assign pgassign14[7:0] = BRAM_Dout_A[8:15];
  assign BRAM_Din_A[8:15] = pgassign15[7:0];
  assign pgassign16[3:3] = BRAM_WEN_A[1:1];
  assign pgassign16[2:2] = BRAM_WEN_A[1:1];
  assign pgassign16[1:1] = BRAM_WEN_A[1:1];
  assign pgassign16[0:0] = BRAM_WEN_A[1:1];
  assign pgassign17[15:15] = 1'b1;
  assign pgassign17[14:3] = BRAM_Addr_B[18:29];
  assign pgassign17[2:0] = 3'b000;
  assign pgassign18[31:8] = 24'b000000000000000000000000;
  assign pgassign18[7:0] = BRAM_Dout_B[8:15];
  assign BRAM_Din_B[8:15] = pgassign19[7:0];
  assign pgassign20[7:4] = 4'b0000;
  assign pgassign20[3:3] = BRAM_WEN_B[1:1];
  assign pgassign20[2:2] = BRAM_WEN_B[1:1];
  assign pgassign20[1:1] = BRAM_WEN_B[1:1];
  assign pgassign20[0:0] = BRAM_WEN_B[1:1];
  assign pgassign21[15:15] = 1'b1;
  assign pgassign21[14:3] = BRAM_Addr_A[18:29];
  assign pgassign21[2:0] = 3'b000;
  assign pgassign22[31:8] = 24'b000000000000000000000000;
  assign pgassign22[7:0] = BRAM_Dout_A[16:23];
  assign BRAM_Din_A[16:23] = pgassign23[7:0];
  assign pgassign24[3:3] = BRAM_WEN_A[2:2];
  assign pgassign24[2:2] = BRAM_WEN_A[2:2];
  assign pgassign24[1:1] = BRAM_WEN_A[2:2];
  assign pgassign24[0:0] = BRAM_WEN_A[2:2];
  assign pgassign25[15:15] = 1'b1;
  assign pgassign25[14:3] = BRAM_Addr_B[18:29];
  assign pgassign25[2:0] = 3'b000;
  assign pgassign26[31:8] = 24'b000000000000000000000000;
  assign pgassign26[7:0] = BRAM_Dout_B[16:23];
  assign BRAM_Din_B[16:23] = pgassign27[7:0];
  assign pgassign28[7:4] = 4'b0000;
  assign pgassign28[3:3] = BRAM_WEN_B[2:2];
  assign pgassign28[2:2] = BRAM_WEN_B[2:2];
  assign pgassign28[1:1] = BRAM_WEN_B[2:2];
  assign pgassign28[0:0] = BRAM_WEN_B[2:2];
  assign pgassign29[15:15] = 1'b1;
  assign pgassign29[14:3] = BRAM_Addr_A[18:29];
  assign pgassign29[2:0] = 3'b000;
  assign pgassign30[31:8] = 24'b000000000000000000000000;
  assign pgassign30[7:0] = BRAM_Dout_A[24:31];
  assign BRAM_Din_A[24:31] = pgassign31[7:0];
  assign pgassign32[3:3] = BRAM_WEN_A[3:3];
  assign pgassign32[2:2] = BRAM_WEN_A[3:3];
  assign pgassign32[1:1] = BRAM_WEN_A[3:3];
  assign pgassign32[0:0] = BRAM_WEN_A[3:3];
  assign pgassign33[15:15] = 1'b1;
  assign pgassign33[14:3] = BRAM_Addr_B[18:29];
  assign pgassign33[2:0] = 3'b000;
  assign pgassign34[31:8] = 24'b000000000000000000000000;
  assign pgassign34[7:0] = BRAM_Dout_B[24:31];
  assign BRAM_Din_B[24:31] = pgassign35[7:0];
  assign pgassign36[7:4] = 4'b0000;
  assign pgassign36[3:3] = BRAM_WEN_B[3:3];
  assign pgassign36[2:2] = BRAM_WEN_B[3:3];
  assign pgassign36[1:1] = BRAM_WEN_B[3:3];
  assign pgassign36[0:0] = BRAM_WEN_B[3:3];
  assign net_gnd0 = 1'b0;
  assign net_gnd4[3:0] = 4'b0000;

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_0.mem" ),
      .READ_WIDTH_A ( 9 ),
      .READ_WIDTH_B ( 9 ),
      .WRITE_WIDTH_A ( 9 ),
      .WRITE_WIDTH_B ( 9 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_0 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign5 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign6 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign7 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign8 ),
      .ADDRBWRADDR ( pgassign9 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign10 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign11 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign12 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_1.mem" ),
      .READ_WIDTH_A ( 9 ),
      .READ_WIDTH_B ( 9 ),
      .WRITE_WIDTH_A ( 9 ),
      .WRITE_WIDTH_B ( 9 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_1 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign13 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign14 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign15 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign16 ),
      .ADDRBWRADDR ( pgassign17 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign18 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign19 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign20 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_2.mem" ),
      .READ_WIDTH_A ( 9 ),
      .READ_WIDTH_B ( 9 ),
      .WRITE_WIDTH_A ( 9 ),
      .WRITE_WIDTH_B ( 9 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_2 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign21 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign22 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign23 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign24 ),
      .ADDRBWRADDR ( pgassign25 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign26 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign27 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign28 )
    );

  (* BMM_INFO = " " *)

  RAMB36E1
    #(
      .WRITE_MODE_A ( "WRITE_FIRST" ),
      .WRITE_MODE_B ( "WRITE_FIRST" ),
      .INIT_FILE ( "microblaze_0_bram_block_combined_3.mem" ),
      .READ_WIDTH_A ( 9 ),
      .READ_WIDTH_B ( 9 ),
      .WRITE_WIDTH_A ( 9 ),
      .WRITE_WIDTH_B ( 9 ),
      .RAM_EXTENSION_A ( "NONE" ),
      .RAM_EXTENSION_B ( "NONE" )
    )
    ramb36e1_3 (
      .DBITERR (  ),
      .ECCPARITY (  ),
      .INJECTDBITERR ( net_gnd0 ),
      .INJECTSBITERR ( net_gnd0 ),
      .RDADDRECC (  ),
      .SBITERR (  ),
      .ADDRARDADDR ( pgassign29 ),
      .CASCADEINA ( net_gnd0 ),
      .CASCADEOUTA (  ),
      .CLKARDCLK ( BRAM_Clk_A ),
      .DIADI ( pgassign30 ),
      .DIPADIP ( net_gnd4 ),
      .DOADO ( pgassign31 ),
      .DOPADOP (  ),
      .ENARDEN ( BRAM_EN_A ),
      .REGCEAREGCE ( net_gnd0 ),
      .RSTRAMARSTRAM ( BRAM_Rst_A ),
      .RSTREGARSTREG ( net_gnd0 ),
      .WEA ( pgassign32 ),
      .ADDRBWRADDR ( pgassign33 ),
      .CASCADEINB ( net_gnd0 ),
      .CASCADEOUTB (  ),
      .CLKBWRCLK ( BRAM_Clk_B ),
      .DIBDI ( pgassign34 ),
      .DIPBDIP ( net_gnd4 ),
      .DOBDO ( pgassign35 ),
      .DOPBDOP (  ),
      .ENBWREN ( BRAM_EN_B ),
      .REGCEB ( net_gnd0 ),
      .RSTRAMB ( BRAM_Rst_B ),
      .RSTREGB ( net_gnd0 ),
      .WEBWE ( pgassign36 )
    );

endmodule

