
// Description: define módulo para filtragem de pacotes pela porta de
// destino do pacote TCP/IP. As portas a ser filtradas são lidas por programas
// em espaço de usuário e gravadas na SRAM por este módulo. A SRAM
// é consultada a cada novo pacote. Pacotes que não sejam TCP/IP são
// encaminhados sem serem filtrados.
`timescale 1ns/1ps
`define IO_QUEUE_STAGE_NUM                  8'hff

module firewall
   #(
      parameter DATA_WIDTH = 64,
      parameter CTRL_WIDTH = DATA_WIDTH/8,
      parameter SRAM_ADDR_WIDTH = 19,
      parameter SRAM_DATA_WIDTH = DATA_WIDTH+CTRL_WIDTH,
      parameter UDP_REG_SRC_WIDTH = 2
   )
   (

      input  [127:0]   tuser,


      input  [255:0]             	  in_data,
      input  [CTRL_WIDTH-1:0]             in_ctrl,
      input                               in_wr,
      output                              in_rdy,

      output reg [DATA_WIDTH-1:0]         out_data,
      output reg [CTRL_WIDTH-1:0]         out_ctrl,
      output reg                          out_wr,
      input                               out_rdy,

      input				  firewall_din,

      // misc
      input                                reset,
      input                                clk
   );

   //------------------------- Signals-------------------------------
   
   localparam WAIT_PACKET =1;
   localparam WORD2_CHECK_IPV4 =2;
   localparam WORD3_CHECK_TCP_TTL =3;
   localparam WORD4_ADDR_CHKSUM =4;
   localparam WORD5_TCP_PORT =5;
   localparam CHECK_RULES = 6;
   localparam CHECK_PORTS = 7;
   localparam EMPTY_OUT_FIFO = 8;
   localparam PAYLOAD =9;
   localparam SRAM_PORTS_ADDR = 'h0;
   localparam NUM_WORDS_SALVAS = 4;

   localparam ICMP = 'h01;
   localparam TCP = 'h06;
   localparam UDP = 'h11;
   localparam SCTP = 'h84;

   wire [255:0]                  in_fifo_data;
   wire [CTRL_WIDTH-1:0]         in_fifo_ctrl;

   wire                          in_fifo_nearly_full;
   wire                          in_fifo_empty;
   reg                           in_fifo_rd_en;

   reg [3:0]                     state, state_next;
      
   reg                           sram_wr_req_next, sram_rd_req_next;
   reg [DATA_WIDTH-1:0]          sram_wr_data_next;
 
   reg [SRAM_ADDR_WIDTH-1:0]     sram_wr_addr_next, sram_rd_addr_next;

   reg [31:0]                    num_TCP, num_TCP_next;

   reg [15:0]                    dst_port, dst_port_next;
   reg                           drop, drop_next;

   wire [31:0]                   dport1, dport2, dport3, dport4;

// --- (B)SRAM arbiter interface
      reg                                sram_rd_req;
      reg [SRAM_ADDR_WIDTH-1:0]          sram_rd_addr;
      wire [DATA_WIDTH-1:0]              sram_rd_data;
      wire                               sram_rd_vld;

      reg                         	sram_wr_req;
      reg [SRAM_ADDR_WIDTH-1:0]    	sram_wr_addr;
      reg [DATA_WIDTH-1:0]         	sram_wr_data;


   //Controle da fila de headers para modulo oq
   wire                             out_fifo_nearly_full, out_fifo_empty;
   reg                              out_fifo_rd_en, out_fifo_wr;
   wire [DATA_WIDTH+CTRL_WIDTH-1:0] out_fifo_dout;
   reg [DATA_WIDTH+CTRL_WIDTH-1:0]  in_out_fifo_dout;

   wire [15:0]                   chksum_cout;
   wire [16:0]                   chksum;
   //------------------------- Local assignments -------------------------------

   assign in_rdy     = !in_fifo_nearly_full;

   //------------------------- Modules-------------------------------

   fallthrough_small_fifo #(
      .WIDTH(CTRL_WIDTH+DATA_WIDTH),
      .MAX_DEPTH_BITS(3)
   ) input_fifo (
      .din           ({in_ctrl, in_data}),   // Data in
      .wr_en         (in_wr),                // Write enable
      .rd_en         (in_fifo_rd_en),        // Read the next word
      .dout          ({in_fifo_ctrl, in_fifo_data}),
      .full          (),
      .nearly_full   (in_fifo_nearly_full),
      .empty         (in_fifo_empty),
      .reset         (reset),
      .clk           (clk)
   );

   fallthrough_small_fifo_old #(
      .WIDTH(CTRL_WIDTH+DATA_WIDTH),
      .MAX_DEPTH_BITS(3)
   ) output_fifo (
      .din           (in_out_fifo_dout),   // Data in
      .wr_en         (out_fifo_wr),                // Write enable
      .rd_en         (out_fifo_rd_en),        // Read the next word
      .dout          (out_fifo_dout),
      .full          (),
      .nearly_full   (out_fifo_nearly_full),
      .empty         (out_fifo_empty),
      .reset         (reset),
      .clk           (clk)
   );

   BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd19),
	  .DATA_WIDTH(32'd64),
	  .MEMSIZE(12'd2048)) 
  bram(
	.CLKA	(clk),
	.CLKB	(clk),
	.ADDRA	(sram_rd_addr),
	.ADDRB	(sram_wr_addr),
	.DIA	(),
	.DIB	(sram_wr_data),
	.WEA	(sram_wr_req),
	.WEB	(),
	.ENA	(1'b0),
	.ENB	(1'b0),
	.DOA	(sram_rd_data),
	.DOB	()
	);




   //------------------------- Logic-------------------------------
   //

   assign chksum = {1'b0,in_fifo_data[63:48]}+17'h100;
   assign chksum_cout = chksum[15:0]+{15'h0,chksum[16]};

   always @(*) begin
      sram_wr_data_next <= firewall_din;
      sram_wr_addr_next <= 'h0;
      if(sram_wr_data_next != sram_wr_data) begin
         sram_wr_req_next <= 1;
      end
      else
         sram_wr_req_next <= 0;
   end

   always @(*) begin
      // Default values
      in_out_fifo_dout = {in_fifo_ctrl,in_fifo_data};
      {out_ctrl,out_data} = out_fifo_dout;
      in_fifo_rd_en = 0;
      out_wr = 0;
      
      out_fifo_wr = 0;
      out_fifo_rd_en = 0;

      sram_rd_req_next = 0;

      state_next = state;
      
      num_TCP = num_TCP_next;

      sram_rd_req_next = 0;
      sram_rd_addr_next = sram_rd_addr;

      dst_port_next = dst_port;
      drop_next = drop;

      case(state)
      WAIT_PACKET: begin
         if (!in_fifo_empty) begin
            in_fifo_rd_en = 1;
            out_fifo_wr = 1;
            //synthesis translate_off
            if(out_fifo_nearly_full) begin //se FIFO cheia
               $stop;
            end
            //synthesis translate_on
            if(in_fifo_ctrl == 'h0) begin
               state_next = WORD2_CHECK_IPV4;
            end else begin
               state_next = WAIT_PACKET;
            end
         end
         else
            state_next = WAIT_PACKET;
      end
      WORD2_CHECK_IPV4: begin
         if (!in_fifo_empty) begin
            if(in_fifo_data[159:144] != 16'h0800) begin
               state_next = EMPTY_OUT_FIFO;
            end
            else begin
               in_fifo_rd_en = 1;
               out_fifo_wr = 1;
               state_next = WORD3_CHECK_TCP_TTL;
            end
         end
         else
            state_next = WORD2_CHECK_IPV4;
      end
      EMPTY_OUT_FIFO: begin
         if(!out_rdy) 
            state_next = EMPTY_OUT_FIFO;
         else if(!out_fifo_empty) begin
            state_next = EMPTY_OUT_FIFO;
            out_wr = ~drop;
            out_fifo_rd_en = 1;
         end
         else
            state_next = PAYLOAD;
      end
      WORD3_CHECK_TCP_TTL: begin
         if (!in_fifo_empty) begin
            if(in_fifo_data[183:175] == TCP) begin
               in_fifo_rd_en = 1;
               out_fifo_wr = 1;
               in_out_fifo_dout = {in_fifo_ctrl,in_fifo_data[63:16],
                  in_fifo_data[15:8]-8'h1,in_fifo_data[7:0]};
               num_TCP_next = num_TCP + 'h1;
               state_next = WORD4_ADDR_CHKSUM;
            end
            else begin
               state_next = EMPTY_OUT_FIFO;
            end
         end
         else
            state_next = WORD3_CHECK_TCP_TTL;
      end
      WORD4_ADDR_CHKSUM: begin
         if (!in_fifo_empty) begin
            in_fifo_rd_en = 1;
            out_fifo_wr = 1;
            in_out_fifo_dout = {in_fifo_ctrl,chksum_cout,in_fifo_data[47:0]};
            state_next = WORD5_TCP_PORT;
         end
         else
            state_next = WORD4_ADDR_CHKSUM;
      end
      WORD5_TCP_PORT: begin
         if (!in_fifo_empty) begin
            dst_port_next = tuser[24:16];
            state_next = CHECK_RULES;
         end
         else
            state_next = WORD5_TCP_PORT;
      end
      CHECK_RULES: begin
         sram_rd_req_next = 1;
         sram_rd_addr_next = SRAM_PORTS_ADDR;
         state_next = CHECK_PORTS;
      end
      CHECK_PORTS: begin
         if (sram_rd_vld) begin
            if(sram_rd_data[15:0] == dst_port ||
                   sram_rd_data[31:16] == dst_port ||
                   sram_rd_data[47:32] == dst_port ||
                   sram_rd_data[63:48] == dst_port) begin
               drop_next = 1;
            end
            else
               drop_next = 0;
            state_next = EMPTY_OUT_FIFO;
         end
         else
            state_next = CHECK_PORTS;
      end
      PAYLOAD: begin
         //synthesis translate_off
         if(!out_fifo_empty) begin
            $stop;
         end
         //synthesis translate_on
         if (!in_fifo_empty) begin
            {out_ctrl,out_data} = {in_fifo_ctrl,in_fifo_data};
            in_fifo_rd_en = 1;
            out_wr = ~drop;
            if(in_fifo_ctrl != `IO_QUEUE_STAGE_NUM) begin
               state_next = PAYLOAD;
            end
            else if(out_rdy) begin
               out_wr = 0;
               in_fifo_rd_en = 0;
               drop_next = 0;
               state_next = WAIT_PACKET;
            end
         end
         else
            state_next = PAYLOAD;
      end
      endcase
   end

   always @(posedge clk) begin
      if(reset) begin
         sram_rd_req <= 0;
         state <= WAIT_PACKET;
         num_TCP <= 0;
         drop <= 0;
         dst_port <= 0;
      end
      else begin
         state <= state_next;
         sram_rd_req <= sram_rd_req_next;
         sram_rd_addr <= sram_rd_addr_next;
         sram_wr_data <= sram_wr_data_next;
         sram_wr_addr <= sram_wr_addr_next;
         sram_wr_req <= sram_wr_req_next;
         dst_port <= dst_port_next;
         drop <= drop_next;
      end
   end
endmodule
