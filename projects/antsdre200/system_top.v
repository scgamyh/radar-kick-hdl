// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_top (
  output          MDIO_PHY_mdc,
  inout           MDIO_PHY_mdio_io,
  input [3:0]     RGMII_rd,
  input           RGMII_rx_ctl,
  input           RGMII_rxc,
  output [3:0]    RGMII_td,
  output          RGMII_tx_ctl,
  output          RGMII_txc,
  output          eth_rst_n ,

  inout   [14:0]  ddr_addr,
  inout   [ 2:0]  ddr_ba,
  inout           ddr_cas_n,
  inout           ddr_ck_n,
  inout           ddr_ck_p,
  inout           ddr_cke,
  inout           ddr_cs_n,
  inout   [ 1:0]  ddr_dm,
  inout   [31:0]  ddr_dq,
  inout   [ 1:0]  ddr_dqs_n,
  inout   [ 1:0]  ddr_dqs_p,
  inout           ddr_odt,
  inout           ddr_ras_n,
  inout           ddr_reset_n,
  inout           ddr_we_n,

  inout           fixed_io_ddr_vrn,
  inout           fixed_io_ddr_vrp,
  inout   [31:0]  fixed_io_mio,
  inout           fixed_io_ps_clk,
  inout           fixed_io_ps_porb,
  inout           fixed_io_ps_srstb,

  inout           iic_scl,
  inout           iic_sda,

  input           rx_clk_in,
  input           rx_frame_in,
  input   [11:0]  rx_data_in,
  output          tx_clk_out,
  output          tx_frame_out,
  output  [11:0]  tx_data_out,

  output          enable,
  output          txnrx,

  inout           gpio_resetb,
  inout           gpio_en_agc,
  inout   [ 3:0]  gpio_ctl,
  inout   [ 7:0]  gpio_status,

  output          spi_csn,
  output          spi_clk,
  output          spi_mosi,
  input           spi_miso,


  // clock form vctcxo
  input  wire	 			      CLK_40MHz_FPGA  ,
  // PPS or 10 MHz (need to choose from SW)
  input  wire             PPS_IN          ,
  input  wire             CLKIN_10MHz     ,
  output wire             CLKIN_10MHz_REQ ,

  // Clock disciplining / AD5662 controls
  output wire             CLK_40M_DAC_nSYNC,
  output wire             CLK_40M_DAC_SCLK ,
  output wire             CLK_40M_DAC_DIN ,

  output                  tx_amp_en,

  inout   [7:0]           GPIOB
  );

  // internal signals

  wire    [63:0]  gpio_i;
  wire    [63:0]  gpio_o;
  wire    [63:0]  gpio_t;
  wire            int_40mhz   ;
  wire            ref_pll_clk ;
  wire            locked      ;
  wire            ref_sel;
  wire            ext_ref;
  wire            ext_ref_is_pps;
  wire            ext_ref_locked;

  // instantiations

  ad_iobuf #(.DATA_WIDTH(14)) i_iobuf (
    .dio_t (gpio_t[13:0]),
    .dio_i (gpio_o[13:0]),
    .dio_o (gpio_i[13:0]),
    .dio_p ({ gpio_resetb,        // 13:13
              gpio_en_agc,        // 12:12
              gpio_ctl,           // 11: 8
              gpio_status}));     //  7: 0

  ad_iobuf #(.DATA_WIDTH(8)) gpio_io_buf (
    .dio_t (gpio_t[42:35]),
    .dio_i (gpio_o[42:35]),
    .dio_o (gpio_i[42:35]),
    .dio_p (GPIOB       )
    );

  assign gpio_i[31:17] = gpio_o[31:17];

  assign gpio_i[32] = ext_ref_locked;
  assign ext_ref_is_pps = gpio_o[33];
  assign ref_sel = gpio_o[34];


  assign tx_amp_en = 1'b1;
  assign eth_rst_n = 1'b1;

  gen_clks gen_clks(
      .clk_out1(int_40mhz),       // output clk_out1
      .clk_out2(),                // output clk_out2
      .clk_out3(ref_pll_clk),     // output clk_out3
      .locked(locked),            // output locked

      .clk_in1(CLK_40MHz_FPGA)
  );


  // vio_0 u_vio (
  //   .clk(ref_pll_clk),                // input wire clk
  //   .probe_in0(ext_ref_locked),    // input wire [0 : 0] probe_in0
  //   .probe_out0(ext_ref_is_pps),  // output wire [0 : 0] probe_out0
  //   .probe_out1(ref_sel)  // output wire [0 : 0] probe_out1
  // );

  assign ext_ref = ext_ref_is_pps ? PPS_IN : ref_sel ? CLKIN_10MHz : 1'b0;
  b205_ref_pll ref_pll(
      .reset(~locked),
      .clk(ref_pll_clk),
      .refclk(int_40mhz),
      .ref_x(ext_ref),
      .locked(ext_ref_locked),
      .sclk(CLK_40M_DAC_SCLK),
      .mosi(CLK_40M_DAC_DIN),
      .sync_n(CLK_40M_DAC_nSYNC)
  );
  assign CLKIN_10MHz_REQ = ref_sel;


  system_wrapper i_system_wrapper (
    .MDIO_PHY_mdc(MDIO_PHY_mdc),
    .MDIO_PHY_mdio_io(MDIO_PHY_mdio_io),
    .RGMII_rd(RGMII_rd),
    .RGMII_rx_ctl(RGMII_rx_ctl),
    .RGMII_rxc(RGMII_rxc),
    .RGMII_td(RGMII_td),
    .RGMII_tx_ctl(RGMII_tx_ctl),
    .RGMII_txc(RGMII_txc),
    .eth_rst_n(),
    .ddr_addr (ddr_addr),
    .ddr_ba (ddr_ba),
    .ddr_cas_n (ddr_cas_n),
    .ddr_ck_n (ddr_ck_n),
    .ddr_ck_p (ddr_ck_p),
    .ddr_cke (ddr_cke),
    .ddr_cs_n (ddr_cs_n),
    .ddr_dm (ddr_dm),
    .ddr_dq (ddr_dq),
    .ddr_dqs_n (ddr_dqs_n),
    .ddr_dqs_p (ddr_dqs_p),
    .ddr_odt (ddr_odt),
    .ddr_ras_n (ddr_ras_n),
    .ddr_reset_n (ddr_reset_n),
    .ddr_we_n (ddr_we_n),
    .enable (enable),
    .fixed_io_ddr_vrn (fixed_io_ddr_vrn),
    .fixed_io_ddr_vrp (fixed_io_ddr_vrp),
    .fixed_io_mio (fixed_io_mio),
    .fixed_io_ps_clk (fixed_io_ps_clk),
    .fixed_io_ps_porb (fixed_io_ps_porb),
    .fixed_io_ps_srstb (fixed_io_ps_srstb),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .rx_clk_in (rx_clk_in),
    .rx_data_in (rx_data_in),
    .rx_frame_in (rx_frame_in),

    .spi0_clk_i (1'b0),
    .spi0_clk_o (spi_clk),
    .spi0_csn_0_o (spi_csn),
    .spi0_csn_1_o (),
    .spi0_csn_2_o (),
    .spi0_csn_i (1'b1),
    .spi0_sdi_i (spi_miso),
    .spi0_sdo_i (1'b0),
    .spi0_sdo_o (spi_mosi),


    .tx_clk_out (tx_clk_out),
    .tx_data_out (tx_data_out),
    .tx_frame_out (tx_frame_out),
    .txnrx (txnrx),
    .up_enable (gpio_o[15]),
    .up_txnrx (gpio_o[16]));

endmodule

// ***************************************************************************
// ***************************************************************************

