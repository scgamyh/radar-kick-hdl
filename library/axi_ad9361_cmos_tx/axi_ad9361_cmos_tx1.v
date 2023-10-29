// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2019 (c) Analog Devices, Inc. All rights reserved.
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
`timescale 1ns / 1ps

module axi_ad9361_cmos_tx (

  input   wire    clk,
  
  input wire [15:0]           adc_data_i,
  input wire                  adc_valid_i,
  input wire [15:0]           adc_data_q,
  input wire                  adc_valid_q,
  output reg [15:0]           adc_data_i0,
  output reg [15:0]           adc_data_q0,
  //axi interface
  input                   s_axi_aclk,
  input                   s_axi_aresetn,
  input                   s_axi_awvalid,
  input       [15:0]      s_axi_awaddr,
  input       [ 2:0]      s_axi_awprot,
  output                  s_axi_awready,
  input                   s_axi_wvalid,
  input       [31:0]      s_axi_wdata,
  input       [ 3:0]      s_axi_wstrb,
  output                  s_axi_wready,
  output                  s_axi_bvalid,
  output      [ 1:0]      s_axi_bresp,
  input                   s_axi_bready,
  input                   s_axi_arvalid,
  input       [15:0]      s_axi_araddr,
  input       [ 2:0]      s_axi_arprot,
  output                  s_axi_arready,
  output                  s_axi_rvalid,
  output      [ 1:0]      s_axi_rresp,
  output      [31:0]      s_axi_rdata,
  input                   s_axi_rready);

parameter width = 16;
parameter maxdelaytime = 10000;
parameter currentdly = 10000;
reg [31:0] currentdlycount = 20;
reg [width*currentdly-1:0] dly1i = 0;
reg [width*currentdly-1:0] dly1q = 0;

reg [width*currentdly-1:0] dly2i = 0;
reg [width*currentdly-1:0] dly2q = 0;

reg [width*currentdly-1:0] dly3i = 0;
reg [width*currentdly-1:0] dly3q = 0;

reg [width*currentdly-1:0] dly4i = 0;
reg [width*currentdly-1:0] dly4q = 0;

reg [width*currentdly-1:0] dly5i = 0;
reg [width*currentdly-1:0] dly5q = 0;

reg [width*currentdly-1:0] dly6i = 0;
reg [width*currentdly-1:0] dly6q = 0;

reg [width*currentdly-1:0] dly7i = 0;
reg [width*currentdly-1:0] dly7q = 0;


reg [width*currentdly-1:0] dly8i = 0;
reg [width*currentdly-1:0] dly8q = 0;

reg [width*currentdly-1:0] dly9i = 0;
reg [width*currentdly-1:0] dly9q = 0;

reg [width*currentdly-1:0] dly10i = 0;
reg [width*currentdly-1:0] dly10q = 0;
/*
reg [width*currentdly-1:0] dly11i = 0;
reg [width*currentdly-1:0] dly11q = 0;

reg [width*currentdly-1:0] dly12i = 0;
reg [width*currentdly-1:0] dly12q = 0;

reg [width*currentdly-1:0] dly13i = 0;
reg [width*currentdly-1:0] dly13q = 0;

reg [width*currentdly-1:0] dly14i = 0;
reg [width*currentdly-1:0] dly14q = 0;

reg [width*currentdly-1:0] dly15i = 0;
reg [width*currentdly-1:0] dly15q = 0;

reg [width*currentdly-1:0] dly16i = 0;
reg [width*currentdly-1:0] dly16q = 0;

reg [width*currentdly-1:0] dly17i = 0;
reg [width*currentdly-1:0] dly17q = 0;

reg [width*currentdly-1:0] dly18i = 0;
reg [width*currentdly-1:0] dly18q = 0;

reg [width*currentdly-1:0] dly19i = 0;
reg [width*currentdly-1:0] dly19q = 0;

reg [width*currentdly-1:0] dly20i = 0;
reg [width*currentdly-1:0] dly20q = 0;

reg [width*currentdly-1:0] dly21i = 0;
reg [width*currentdly-1:0] dly21q = 0;

reg [width*currentdly-1:0] dly22i = 0;
reg [width*currentdly-1:0] dly22q = 0;

reg [width*currentdly-1:0] dly23i = 0;
reg [width*currentdly-1:0] dly23q = 0;

reg [width*currentdly-1:0] dly24i = 0;
reg [width*currentdly-1:0] dly24q = 0;

reg [width*currentdly-1:0] dly25i = 0;
reg [width*currentdly-1:0] dly25q = 0;

reg [width*currentdly-1:0] dly26i = 0;
reg [width*currentdly-1:0] dly26q = 0;

reg [width*currentdly-1:0] dly27i = 0;
reg [width*currentdly-1:0] dly27q = 0;

reg [width*currentdly-1:0] dly28i = 0;
reg [width*currentdly-1:0] dly28q = 0;

reg [width*currentdly-1:0] dly29i = 0;
reg [width*currentdly-1:0] dly29q = 0;

reg [width*currentdly-1:0] dly30i = 0;
reg [width*currentdly-1:0] dly30q = 0;


reg [width*currentdly-1:0] dly31i = 0;
reg [width*currentdly-1:0] dly31q = 0;

reg [width*currentdly-1:0] dly32i = 0;
reg [width*currentdly-1:0] dly32q = 0;

reg [width*currentdly-1:0] dly33i = 0;
reg [width*currentdly-1:0] dly33q = 0;

reg [width*currentdly-1:0] dly34i = 0;
reg [width*currentdly-1:0] dly34q = 0;

reg [width*currentdly-1:0] dly35i = 0;
reg [width*currentdly-1:0] dly35q = 0;

reg [width*currentdly-1:0] dly36i = 0;
reg [width*currentdly-1:0] dly36q = 0;

reg [width*currentdly-1:0] dly37i = 0;
reg [width*currentdly-1:0] dly37q = 0;


reg [width*currentdly-1:0] dly38i = 0;
reg [width*currentdly-1:0] dly38q = 0;

reg [width*currentdly-1:0] dly39i = 0;
reg [width*currentdly-1:0] dly39q = 0;

reg [width*currentdly-1:0] dly40i = 0;
reg [width*currentdly-1:0] dly40q = 0;

reg [width*currentdly-1:0] dly41i = 0;
reg [width*currentdly-1:0] dly41q = 0;

reg [width*currentdly-1:0] dly42i = 0;
reg [width*currentdly-1:0] dly42q = 0;

reg [width*currentdly-1:0] dly43i = 0;
reg [width*currentdly-1:0] dly43q = 0;

reg [width*currentdly-1:0] dly44i = 0;
reg [width*currentdly-1:0] dly44q = 0;

reg [width*currentdly-1:0] dly45i = 0;
reg [width*currentdly-1:0] dly45q = 0;

reg [width*currentdly-1:0] dly46i = 0;
reg [width*currentdly-1:0] dly46q = 0;

reg [width*currentdly-1:0] dly47i = 0;
reg [width*currentdly-1:0] dly47q = 0;


reg [width*currentdly-1:0] dly48i = 0;
reg [width*currentdly-1:0] dly48q = 0;

reg [width*currentdly-1:0] dly49i = 0;
reg [width*currentdly-1:0] dly49q = 0;

reg [width*currentdly-1:0] dly50i = 0;
reg [width*currentdly-1:0] dly50q = 0;*/
/*
reg [width*currentdly-1:0] dly51i = 0;
reg [width*currentdly-1:0] dly51q = 0;

reg [width*currentdly-1:0] dly52i = 0;
reg [width*currentdly-1:0] dly52q = 0;

reg [width*currentdly-1:0] dly53i = 0;
reg [width*currentdly-1:0] dly53q = 0;

reg [width*currentdly-1:0] dly54i = 0;
reg [width*currentdly-1:0] dly54q = 0;

reg [width*currentdly-1:0] dly55i = 0;
reg [width*currentdly-1:0] dly55q = 0;

reg [width*currentdly-1:0] dly56i = 0;
reg [width*currentdly-1:0] dly56q = 0;

reg [width*currentdly-1:0] dly57i = 0;
reg [width*currentdly-1:0] dly57q = 0;


reg [width*currentdly-1:0] dly58i = 0;
reg [width*currentdly-1:0] dly58q = 0;

reg [width*currentdly-1:0] dly59i = 0;
reg [width*currentdly-1:0] dly59q = 0;

reg [width*currentdly-1:0] dly60i = 0;
reg [width*currentdly-1:0] dly60q = 0;

reg [width*currentdly-1:0] dly61i = 0;
reg [width*currentdly-1:0] dly61q = 0;

reg [width*currentdly-1:0] dly62i = 0;
reg [width*currentdly-1:0] dly62q = 0;

reg [width*currentdly-1:0] dly63i = 0;
reg [width*currentdly-1:0] dly63q = 0;

reg [width*currentdly-1:0] dly64i = 0;
reg [width*currentdly-1:0] dly64q = 0;

reg [width*currentdly-1:0] dly65i = 0;
reg [width*currentdly-1:0] dly65q = 0;

reg [width*currentdly-1:0] dly66i = 0;
reg [width*currentdly-1:0] dly66q = 0;

reg [width*currentdly-1:0] dly67i = 0;
reg [width*currentdly-1:0] dly67q = 0;


reg [width*currentdly-1:0] dly68i = 0;
reg [width*currentdly-1:0] dly68q = 0;

reg [width*currentdly-1:0] dly69i = 0;
reg [width*currentdly-1:0] dly69q = 0;

reg [width*currentdly-1:0] dly70i = 0;
reg [width*currentdly-1:0] dly70q = 0;

reg [width*currentdly-1:0] dly71i = 0;
reg [width*currentdly-1:0] dly71q = 0;

reg [width*currentdly-1:0] dly72i = 0;
reg [width*currentdly-1:0] dly72q = 0;

reg [width*currentdly-1:0] dly73i = 0;
reg [width*currentdly-1:0] dly73q = 0;

reg [width*currentdly-1:0] dly74i = 0;
reg [width*currentdly-1:0] dly74q = 0;

reg [width*currentdly-1:0] dly75i = 0;
reg [width*currentdly-1:0] dly75q = 0;

reg [width*currentdly-1:0] dly76i = 0;
reg [width*currentdly-1:0] dly76q = 0;

reg [width*currentdly-1:0] dly77i = 0;
reg [width*currentdly-1:0] dly77q = 0;


reg [width*currentdly-1:0] dly78i = 0;
reg [width*currentdly-1:0] dly78q = 0;

reg [width*currentdly-1:0] dly79i = 0;
reg [width*currentdly-1:0] dly79q = 0;

reg [width*currentdly-1:0] dly80i = 0;
reg [width*currentdly-1:0] dly80q = 0;

reg [width*currentdly-1:0] dly81i = 0;
reg [width*currentdly-1:0] dly81q = 0;

reg [width*currentdly-1:0] dly82i = 0;
reg [width*currentdly-1:0] dly82q = 0;

reg [width*currentdly-1:0] dly83i = 0;
reg [width*currentdly-1:0] dly83q = 0;

reg [width*currentdly-1:0] dly84i = 0;
reg [width*currentdly-1:0] dly84q = 0;

reg [width*currentdly-1:0] dly85i = 0;
reg [width*currentdly-1:0] dly85q = 0;

reg [width*currentdly-1:0] dly86i = 0;
reg [width*currentdly-1:0] dly86q = 0;

reg [width*currentdly-1:0] dly87i = 0;
reg [width*currentdly-1:0] dly87q = 0;


reg [width*currentdly-1:0] dly88i = 0;
reg [width*currentdly-1:0] dly88q = 0;

reg [width*currentdly-1:0] dly89i = 0;
reg [width*currentdly-1:0] dly89q = 0;

reg [width*currentdly-1:0] dly90i = 0;
reg [width*currentdly-1:0] dly90q = 0;

reg [width*currentdly-1:0] dly91i = 0;
reg [width*currentdly-1:0] dly91q = 0;

reg [width*currentdly-1:0] dly92i = 0;
reg [width*currentdly-1:0] dly92q = 0;

reg [width*currentdly-1:0] dly93i = 0;
reg [width*currentdly-1:0] dly93q = 0;

reg [width*currentdly-1:0] dly94i = 0;
reg [width*currentdly-1:0] dly94q = 0;

reg [width*currentdly-1:0] dly95i = 0;
reg [width*currentdly-1:0] dly95q = 0;

reg [width*currentdly-1:0] dly96i = 0;
reg [width*currentdly-1:0] dly96q = 0;

reg [width*currentdly-1:0] dly97i = 0;
reg [width*currentdly-1:0] dly97q = 0;


reg [width*currentdly-1:0] dly98i = 0;
reg [width*currentdly-1:0] dly98q = 0;

reg [width*currentdly-1:0] dly99i = 0;
reg [width*currentdly-1:0] dly99q = 0;

reg [width*currentdly-1:0] dly100i = 0;
reg [width*currentdly-1:0] dly100q = 0;
*/
//reg [width*currentdly-1:0] dly101i = 0;
//reg [width*currentdly-1:0] dly101q = 0;

//reg [width*currentdly-1:0] dly102i = 0;
//reg [width*currentdly-1:0] dly102q = 0;

//reg [width*currentdly-1:0] dly103i = 0;
//reg [width*currentdly-1:0] dly103q = 0;

//reg [width*currentdly-1:0] dly104i = 0;
//reg [width*currentdly-1:0] dly104q = 0;

//reg [width*currentdly-1:0] dly105i = 0;
//reg [width*currentdly-1:0] dly105q = 0;

//reg [width*currentdly-1:0] dly106i = 0;
//reg [width*currentdly-1:0] dly106q = 0;

//reg [width*currentdly-1:0] dly107i = 0;
//reg [width*currentdly-1:0] dly107q = 0;


//reg [width*currentdly-1:0] dly108i = 0;
//reg [width*currentdly-1:0] dly108q = 0;

//reg [width*currentdly-1:0] dly109i = 0;
//reg [width*currentdly-1:0] dly109q = 0;

//reg [width*currentdly-1:0] dly110i = 0;
//reg [width*currentdly-1:0] dly110q = 0;

//reg [width*currentdly-1:0] dly111i = 0;
//reg [width*currentdly-1:0] dly111q = 0;

//reg [width*currentdly-1:0] dly112i = 0;
//reg [width*currentdly-1:0] dly112q = 0;

//reg [width*currentdly-1:0] dly113i = 0;
//reg [width*currentdly-1:0] dly113q = 0;

//reg [width*currentdly-1:0] dly114i = 0;
//reg [width*currentdly-1:0] dly114q = 0;

//reg [width*currentdly-1:0] dly115i = 0;
//reg [width*currentdly-1:0] dly115q = 0;

//reg [width*currentdly-1:0] dly116i = 0;
//reg [width*currentdly-1:0] dly116q = 0;

//reg [width*currentdly-1:0] dly117i = 0;
//reg [width*currentdly-1:0] dly117q = 0;

//reg [width*currentdly-1:0] dly118i = 0;
//reg [width*currentdly-1:0] dly118q = 0;


//reg [width*currentdly-1:0] dly119i = 0;
//reg [width*currentdly-1:0] dly119q = 0;

//reg [width*currentdly-1:0] dly120i = 0;
//reg [width*currentdly-1:0] dly120q = 0;

//reg [width*currentdly-1:0] dly121i = 0;
//reg [width*currentdly-1:0] dly121q = 0;

//reg [width*currentdly-1:0] dly122i = 0;
//reg [width*currentdly-1:0] dly122q = 0;

//reg [width*currentdly-1:0] dly123i = 0;
//reg [width*currentdly-1:0] dly123q = 0;

//reg [width*currentdly-1:0] dly124i = 0;
//reg [width*currentdly-1:0] dly124q = 0;

//reg [width*currentdly-1:0] dly125i = 0;
//reg [width*currentdly-1:0] dly125q = 0;

//reg [width*currentdly-1:0] dly126i = 0;
//reg [width*currentdly-1:0] dly126q = 0;

//reg [width*currentdly-1:0] dly127i = 0;
//reg [width*currentdly-1:0] dly127q = 0;

//reg [width*currentdly-1:0] dly128i = 0;
//reg [width*currentdly-1:0] dly128q = 0;

//reg [width*currentdly-1:0] dly129i = 0;
//reg [width*currentdly-1:0] dly129q = 0;


//reg [width*currentdly-1:0] dly130i = 0;
//reg [width*currentdly-1:0] dly130q = 0;

//reg [width*currentdly-1:0] dly131i = 0;
//reg [width*currentdly-1:0] dly131q = 0;

//reg [width*currentdly-1:0] dly132i = 0;
//reg [width*currentdly-1:0] dly132q = 0;

//reg [width*currentdly-1:0] dly133i = 0;
//reg [width*currentdly-1:0] dly133q = 0;

//reg [width*currentdly-1:0] dly134i = 0;
//reg [width*currentdly-1:0] dly134q = 0;

//reg [width*currentdly-1:0] dly135i = 0;
//reg [width*currentdly-1:0] dly135q = 0;

//reg [width*currentdly-1:0] dly136i = 0;
//reg [width*currentdly-1:0] dly136q = 0;

//reg [width*currentdly-1:0] dly137i = 0;
//reg [width*currentdly-1:0] dly137q = 0;

//reg [width*currentdly-1:0] dly138i = 0;
//reg [width*currentdly-1:0] dly138q = 0;

//reg [width*currentdly-1:0] dly139i = 0;
//reg [width*currentdly-1:0] dly139q = 0;

//reg [width*currentdly-1:0] dly140i = 0;
//reg [width*currentdly-1:0] dly140q = 0;


//reg [width*currentdly-1:0] dly141i = 0;
//reg [width*currentdly-1:0] dly141q = 0;

//reg [width*currentdly-1:0] dly142i = 0;
//reg [width*currentdly-1:0] dly142q = 0;

//reg [width*currentdly-1:0] dly143i = 0;
//reg [width*currentdly-1:0] dly143q = 0;

//reg [width*currentdly-1:0] dly144i = 0;
//reg [width*currentdly-1:0] dly144q = 0;

//reg [width*currentdly-1:0] dly145i = 0;
//reg [width*currentdly-1:0] dly145q = 0;

//reg [width*currentdly-1:0] dly146i = 0;
//reg [width*currentdly-1:0] dly146q = 0;

//reg [width*currentdly-1:0] dly147i = 0;
//reg [width*currentdly-1:0] dly147q = 0;

//reg [width*currentdly-1:0] dly148i = 0;
//reg [width*currentdly-1:0] dly148q = 0;

//reg [width*currentdly-1:0] dly149i = 0;
//reg [width*currentdly-1:0] dly149q = 0;

//reg [width*currentdly-1:0] dly150i = 0;
//reg [width*currentdly-1:0] dly150q = 0;

//reg [width*currentdly-1:0] dly151i = 0;
//reg [width*currentdly-1:0] dly151q = 0;


//reg [width*currentdly-1:0] dly152i = 0;
//reg [width*currentdly-1:0] dly152q = 0;

//reg [width*currentdly-1:0] dly153i = 0;
//reg [width*currentdly-1:0] dly153q = 0;

//reg [width*currentdly-1:0] dly154i = 0;
//reg [width*currentdly-1:0] dly154q = 0;

//reg [width*currentdly-1:0] dly155i = 0;
//reg [width*currentdly-1:0] dly155q = 0;

//reg [width*currentdly-1:0] dly156i = 0;
//reg [width*currentdly-1:0] dly156q = 0;

//reg [width*currentdly-1:0] dly157i = 0;
//reg [width*currentdly-1:0] dly157q = 0;

//reg [width*currentdly-1:0] dly158i = 0;
//reg [width*currentdly-1:0] dly158q = 0;

//reg [width*currentdly-1:0] dly159i = 0;
//reg [width*currentdly-1:0] dly159q = 0;

//reg [width*currentdly-1:0] dly160i = 0;
//reg [width*currentdly-1:0] dly160q = 0;

//reg [width*currentdly-1:0] dly161i = 0;
//reg [width*currentdly-1:0] dly161q = 0;

//reg [width*currentdly-1:0] dly162i = 0;
//reg [width*currentdly-1:0] dly162q = 0;


//reg [width*currentdly-1:0] dly163i = 0;
//reg [width*currentdly-1:0] dly163q = 0;

//reg [width*currentdly-1:0] dly164i = 0;
//reg [width*currentdly-1:0] dly164q = 0;

//reg [width*currentdly-1:0] dly165i = 0;
//reg [width*currentdly-1:0] dly165q = 0;


//reg [width*currentdly-1:0] dly166i = 0;
//reg [width*currentdly-1:0] dly166q = 0;

//reg [width*currentdly-1:0] dly167i = 0;
//reg [width*currentdly-1:0] dly167q = 0;

//reg [width*currentdly-1:0] dly168i = 0;
//reg [width*currentdly-1:0] dly168q = 0;

//reg [width*currentdly-1:0] dly169i = 0;
//reg [width*currentdly-1:0] dly169q = 0;

//reg [width*currentdly-1:0] dly170i = 0;
//reg [width*currentdly-1:0] dly170q = 0;

//reg [width*currentdly-1:0] dly171i = 0;
//reg [width*currentdly-1:0] dly171q = 0;

//reg [width*currentdly-1:0] dly172i = 0;
//reg [width*currentdly-1:0] dly172q = 0;

//reg [width*currentdly-1:0] dly173i = 0;
//reg [width*currentdly-1:0] dly173q = 0;


//reg [width*currentdly-1:0] dly174i = 0;
//reg [width*currentdly-1:0] dly174q = 0;

//reg [width*currentdly-1:0] dly175i = 0;
//reg [width*currentdly-1:0] dly175q = 0;

//reg [width*currentdly-1:0] dly176i = 0;
//reg [width*currentdly-1:0] dly176q = 0;

//reg [width*currentdly-1:0] dly177i = 0;
//reg [width*currentdly-1:0] dly177q = 0;

//reg [width*currentdly-1:0] dly178i = 0;
//reg [width*currentdly-1:0] dly178q = 0;

//reg [width*currentdly-1:0] dly179i = 0;
//reg [width*currentdly-1:0] dly179q = 0;

//reg [width*currentdly-1:0] dly180i = 0;
//reg [width*currentdly-1:0] dly180q = 0;

//reg [width*currentdly-1:0] dly181i = 0;
//reg [width*currentdly-1:0] dly181q = 0;

//reg [width*currentdly-1:0] dly182i = 0;
//reg [width*currentdly-1:0] dly182q = 0;

//reg [width*currentdly-1:0] dly183i = 0;
//reg [width*currentdly-1:0] dly183q = 0;

//reg [width*currentdly-1:0] dly184i = 0;
//reg [width*currentdly-1:0] dly184q = 0;


//reg [width*currentdly-1:0] dly185i = 0;
//reg [width*currentdly-1:0] dly185q = 0;


//reg [width*currentdly-1:0] dly186i = 0;
//reg [width*currentdly-1:0] dly186q = 0;

//reg [width*currentdly-1:0] dly187i = 0;
//reg [width*currentdly-1:0] dly187q = 0;

////reg [width*currentdly-1:0] dly188i = 0;
////reg [width*currentdly-1:0] dly188q = 0;

//reg [width*currentdly-1:0] dly189i = 0;
//reg [width*currentdly-1:0] dly189q = 0;

//reg [width*currentdly-1:0] dly190i = 0;
//reg [width*currentdly-1:0] dly190q = 0;

//reg [width*currentdly-1:0] dly191i = 0;
//reg [width*currentdly-1:0] dly191q = 0;

//reg [width*currentdly-1:0] dly192i = 0;
//reg [width*currentdly-1:0] dly192q = 0;

//reg [width*currentdly-1:0] dly193i = 0;
//reg [width*currentdly-1:0] dly193q = 0;

//reg [width*currentdly-1:0] dly194i = 0;
//reg [width*currentdly-1:0] dly194q = 0;


//reg [width*currentdly-1:0] dly195i = 0;
//reg [width*currentdly-1:0] dly195q = 0;

////reg [width*currentdly-1:0] dly196i = 0;
////reg [width*currentdly-1:0] dly196q = 0;

//reg [width*currentdly-1:0] dly197i = 0;
//reg [width*currentdly-1:0] dly197q = 0;
//reg [width*currentdly-1:0] dly198i = 0;
//reg [width*currentdly-1:0] dly198q = 0;
//reg [width*currentdly-1:0] dly199i = 0;
//reg [width*currentdly-1:0] dly199q = 0;
//reg [width*currentdly-1:0] dly200i = 0;
//reg [width*currentdly-1:0] dly200q = 0;
//assign adc_data_i0 = dly200i[(currentdly)*width-1-:16];
//assign adc_data_q0 = dly200q[(currentdly)*width-1-:16];
always  @(posedge clk)
begin
	dly1i <= {dly1i[(currentdly-1)*width-1:0],adc_data_i[15:0]};
	dly1q <= {dly1q[(currentdly-1)*width-1:0],adc_data_q[15:0]};
end
always  @(posedge clk)
begin
	dly2i <= {dly2i[(currentdly-1)*width-1:0],dly1i[15:0]};
	dly2q <= {dly2q[(currentdly-1)*width-1:0],dly1q[15:0]};
end
always  @(posedge clk)
begin
	dly3i <= {dly3i[(currentdly-1)*width-1:0],dly2i[15:0]};
	dly3q <= {dly3q[(currentdly-1)*width-1:0],dly2q[15:0]};
end
always  @(posedge clk)
begin
	dly4i <= {dly4i[(currentdly-1)*width-1:0],dly3i[15:0]};
	dly4q <= {dly4q[(currentdly-1)*width-1:0],dly3q[15:0]};
end
always  @(posedge clk)
begin
	dly5i <= {dly5i[(currentdly-1)*width-1:0],dly4i[15:0]};
	dly5q <= {dly5q[(currentdly-1)*width-1:0],dly4q[15:0]};
end
always  @(posedge clk)
begin
	dly6i <= {dly6i[(currentdly-1)*width-1:0],dly5i[15:0]};
	dly6q <= {dly6q[(currentdly-1)*width-1:0],dly5q[15:0]};
end
always  @(posedge clk)
begin
	dly7i <= {dly7i[(currentdly-1)*width-1:0],dly6i[15:0]};
	dly7q <= {dly7q[(currentdly-1)*width-1:0],dly6q[15:0]};
	end
always  @(posedge clk)
begin
	dly8i <= {dly8i[(currentdly-1)*width-1:0],dly7i[15:0]};
	dly8q <= {dly8q[(currentdly-1)*width-1:0],dly7q[15:0]};
	end
always  @(posedge clk)
begin
	dly9i <= {dly9i[(currentdly-1)*width-1:0],dly8i[15:0]};
	dly9q <= {dly9q[(currentdly-1)*width-1:0],dly8q[15:0]};
	end
always  @(posedge clk)
	begin
	dly10i <= {dly10i[(currentdly-1)*width-1:0],dly9i[15:0]};
	dly10q <= {dly10q[(currentdly-1)*width-1:0],dly9q[15:0]};
	end
/*
	dly11i <= {dly11i[(currentdly-1)*width-1:0],dly10i[15:0]};
	dly11q <= {dly11q[(currentdly-1)*width-1:0],dly10q[15:0]};
	

	dly12i <= {dly12i[(currentdly-1)*width-1:0],dly11i[15:0]};
	dly12q <= {dly12q[(currentdly-1)*width-1:0],dly11q[15:0]};

	dly13i <= {dly13i[(currentdly-1)*width-1:0],dly12i[15:0]};
	dly13q <= {dly13q[(currentdly-1)*width-1:0],dly12q[15:0]};

	dly14i <= {dly14i[(currentdly-1)*width-1:0],dly13i[15:0]};
	dly14q <= {dly14q[(currentdly-1)*width-1:0],dly13q[15:0]};

	dly15i <= {dly15i[(currentdly-1)*width-1:0],dly14i[15:0]};
	dly15q <= {dly15q[(currentdly-1)*width-1:0],dly14q[15:0]};

	dly16i <= {dly16i[(currentdly-1)*width-1:0],dly15i[15:0]};
	dly16q <= {dly16q[(currentdly-1)*width-1:0],dly15q[15:0]};

	dly17i <= {dly17i[(currentdly-1)*width-1:0],dly16i[15:0]};
	dly17q <= {dly17q[(currentdly-1)*width-1:0],dly16q[15:0]};

	dly18i <= {dly18i[(currentdly-1)*width-1:0],dly17i[15:0]};
	dly18q <= {dly18q[(currentdly-1)*width-1:0],dly17q[15:0]};

	dly19i <= {dly19i[(currentdly-1)*width-1:0],dly18i[15:0]};
	dly19q <= {dly19q[(currentdly-1)*width-1:0],dly18q[15:0]};

	dly20i <= {dly20i[(currentdly-1)*width-1:0],dly19i[15:0]};
	dly20q <= {dly20q[(currentdly-1)*width-1:0],dly19q[15:0]};
	dly21i <= {dly21i[(currentdly-1)*width-1:0],dly20i[15:0]};
	dly21q <= {dly21q[(currentdly-1)*width-1:0],dly20q[15:0]};
	dly22i <= {dly22i[(currentdly-1)*width-1:0],dly21i[15:0]};
	dly22q <= {dly22q[(currentdly-1)*width-1:0],dly21q[15:0]};
	dly23i <= {dly23i[(currentdly-1)*width-1:0],dly22i[15:0]};
	dly23q <= {dly23q[(currentdly-1)*width-1:0],dly22q[15:0]};
	dly24i <= {dly24i[(currentdly-1)*width-1:0],dly23i[15:0]};
	dly24q <= {dly24q[(currentdly-1)*width-1:0],dly23q[15:0]};
	dly25i <= {dly25i[(currentdly-1)*width-1:0],dly24i[15:0]};
	dly25q <= {dly25q[(currentdly-1)*width-1:0],dly24q[15:0]};
	dly26i <= {dly26i[(currentdly-1)*width-1:0],dly25i[15:0]};
	dly26q <= {dly26q[(currentdly-1)*width-1:0],dly25q[15:0]};
	dly27i <= {dly27i[(currentdly-1)*width-1:0],dly26i[15:0]};
	dly17q <= {dly17q[(currentdly-1)*width-1:0],dly26q[15:0]};
	dly28i <= {dly28i[(currentdly-1)*width-1:0],dly27i[15:0]};
	dly28q <= {dly28q[(currentdly-1)*width-1:0],dly27q[15:0]};
	dly29i <= {dly29i[(currentdly-1)*width-1:0],dly28i[15:0]};
	dly29q <= {dly29q[(currentdly-1)*width-1:0],dly28q[15:0]};
	dly30i <= {dly30i[(currentdly-1)*width-1:0],dly29i[15:0]};
	dly30q <= {dly30q[(currentdly-1)*width-1:0],dly29q[15:0]};

	dly31i <= {dly31i[(currentdly-1)*width-1:0],dly30i[15:0]};
	dly31q <= {dly31q[(currentdly-1)*width-1:0],dly30q[15:0]};
	dly32i <= {dly32i[(currentdly-1)*width-1:0],dly31i[15:0]};
	dly32q <= {dly32q[(currentdly-1)*width-1:0],dly31q[15:0]};
	dly33i <= {dly33i[(currentdly-1)*width-1:0],dly32i[15:0]};
	dly33q <= {dly33q[(currentdly-1)*width-1:0],dly32q[15:0]};
	dly34i <= {dly34i[(currentdly-1)*width-1:0],dly33i[15:0]};
	dly34q <= {dly34q[(currentdly-1)*width-1:0],dly33q[15:0]};
	dly35i <= {dly35i[(currentdly-1)*width-1:0],dly34i[15:0]};
	dly35q <= {dly35q[(currentdly-1)*width-1:0],dly34q[15:0]};
	dly36i <= {dly36i[(currentdly-1)*width-1:0],dly35i[15:0]};
	dly36q <= {dly36q[(currentdly-1)*width-1:0],dly35q[15:0]};
	dly37i <= {dly37i[(currentdly-1)*width-1:0],dly36i[15:0]};
	dly37q <= {dly37q[(currentdly-1)*width-1:0],dly36q[15:0]};
	dly38i <= {dly38i[(currentdly-1)*width-1:0],dly37i[15:0]};
	dly38q <= {dly38q[(currentdly-1)*width-1:0],dly37q[15:0]};
	dly39i <= {dly39i[(currentdly-1)*width-1:0],dly38i[15:0]};
	dly39q <= {dly39q[(currentdly-1)*width-1:0],dly38q[15:0]};
	dly40i <= {dly40i[(currentdly-1)*width-1:0],dly39i[15:0]};
	dly40q <= {dly40q[(currentdly-1)*width-1:0],dly39q[15:0]};

	dly41i <= {dly41i[(currentdly-1)*width-1:0],dly40i[15:0]};
	dly41q <= {dly41q[(currentdly-1)*width-1:0],dly40q[15:0]};
	dly42i <= {dly42i[(currentdly-1)*width-1:0],dly41i[15:0]};
	dly42q <= {dly42q[(currentdly-1)*width-1:0],dly41q[15:0]};
	dly43i <= {dly43i[(currentdly-1)*width-1:0],dly42i[15:0]};
	dly43q <= {dly43q[(currentdly-1)*width-1:0],dly42q[15:0]};
	dly44i <= {dly44i[(currentdly-1)*width-1:0],dly43i[15:0]};
	dly44q <= {dly44q[(currentdly-1)*width-1:0],dly43q[15:0]};
	dly45i <= {dly45i[(currentdly-1)*width-1:0],dly44i[15:0]};
	dly45q <= {dly45q[(currentdly-1)*width-1:0],dly44q[15:0]};
	dly46i <= {dly46i[(currentdly-1)*width-1:0],dly45i[15:0]};
	dly46q <= {dly46q[(currentdly-1)*width-1:0],dly45q[15:0]};
	dly47i <= {dly47i[(currentdly-1)*width-1:0],dly46i[15:0]};
	dly47q <= {dly47q[(currentdly-1)*width-1:0],dly46q[15:0]};
	dly48i <= {dly48i[(currentdly-1)*width-1:0],dly47i[15:0]};
	dly48q <= {dly48q[(currentdly-1)*width-1:0],dly47q[15:0]};
	dly49i <= {dly49i[(currentdly-1)*width-1:0],dly48i[15:0]};
	dly49q <= {dly49q[(currentdly-1)*width-1:0],dly48q[15:0]};
	dly50i <= {dly50i[(currentdly-1)*width-1:0],dly49i[15:0]};
	dly50q <= {dly50q[(currentdly-1)*width-1:0],dly49q[15:0]};
*/
	/*dly51i <= {dly51i[(currentdly-1)*width-1:0],dly50i[15:0]};
	dly51q <= {dly51q[(currentdly-1)*width-1:0],dly50q[15:0]};
	dly52i <= {dly52i[(currentdly-1)*width-1:0],dly51i[15:0]};
	dly52q <= {dly52q[(currentdly-1)*width-1:0],dly51q[15:0]};
	dly53i <= {dly53i[(currentdly-1)*width-1:0],dly52i[15:0]};
	dly53q <= {dly53q[(currentdly-1)*width-1:0],dly52q[15:0]};
	dly54i <= {dly54i[(currentdly-1)*width-1:0],dly53i[15:0]};
	dly54q <= {dly54q[(currentdly-1)*width-1:0],dly53q[15:0]};
	dly55i <= {dly55i[(currentdly-1)*width-1:0],dly54i[15:0]};
	dly55q <= {dly55q[(currentdly-1)*width-1:0],dly54q[15:0]};
	dly56i <= {dly56i[(currentdly-1)*width-1:0],dly55i[15:0]};
	dly56q <= {dly56q[(currentdly-1)*width-1:0],dly55q[15:0]};
	dly57i <= {dly57i[(currentdly-1)*width-1:0],dly56i[15:0]};
	dly57q <= {dly57q[(currentdly-1)*width-1:0],dly56q[15:0]};
	dly58i <= {dly58i[(currentdly-1)*width-1:0],dly57i[15:0]};
	dly58q <= {dly58q[(currentdly-1)*width-1:0],dly57q[15:0]};
	dly59i <= {dly59i[(currentdly-1)*width-1:0],dly58i[15:0]};
	dly59q <= {dly59q[(currentdly-1)*width-1:0],dly58q[15:0]};
	dly60i <= {dly60i[(currentdly-1)*width-1:0],dly59i[15:0]};
	dly60q <= {dly60q[(currentdly-1)*width-1:0],dly59q[15:0]};

	dly61i <= {dly61i[(currentdly-1)*width-1:0],dly60i[15:0]};
	dly61q <= {dly61q[(currentdly-1)*width-1:0],dly60q[15:0]};
	dly62i <= {dly62i[(currentdly-1)*width-1:0],dly61i[15:0]};
	dly62q <= {dly62q[(currentdly-1)*width-1:0],dly61q[15:0]};
	dly63i <= {dly63i[(currentdly-1)*width-1:0],dly62i[15:0]};
	dly63q <= {dly63q[(currentdly-1)*width-1:0],dly62q[15:0]};
	dly64i <= {dly64i[(currentdly-1)*width-1:0],dly63i[15:0]};
	dly64q <= {dly64q[(currentdly-1)*width-1:0],dly63q[15:0]};
	dly65i <= {dly65i[(currentdly-1)*width-1:0],dly64i[15:0]};
	dly65q <= {dly65q[(currentdly-1)*width-1:0],dly64q[15:0]};
	dly66i <= {dly66i[(currentdly-1)*width-1:0],dly65i[15:0]};
	dly66q <= {dly66q[(currentdly-1)*width-1:0],dly65q[15:0]};
	dly67i <= {dly67i[(currentdly-1)*width-1:0],dly66i[15:0]};
	dly67q <= {dly67q[(currentdly-1)*width-1:0],dly66q[15:0]};
	dly68i <= {dly68i[(currentdly-1)*width-1:0],dly67i[15:0]};
	dly68q <= {dly68q[(currentdly-1)*width-1:0],dly67q[15:0]};
	dly69i <= {dly69i[(currentdly-1)*width-1:0],dly68i[15:0]};
	dly69q <= {dly69q[(currentdly-1)*width-1:0],dly68q[15:0]};
	dly70i <= {dly70i[(currentdly-1)*width-1:0],dly69i[15:0]};
	dly70q <= {dly70q[(currentdly-1)*width-1:0],dly69q[15:0]};

	dly71i <= {dly71i[(currentdly-1)*width-1:0],dly70i[15:0]};
	dly71q <= {dly71q[(currentdly-1)*width-1:0],dly70q[15:0]};
	dly72i <= {dly72i[(currentdly-1)*width-1:0],dly71i[15:0]};
	dly72q <= {dly72q[(currentdly-1)*width-1:0],dly71q[15:0]};
	dly73i <= {dly73i[(currentdly-1)*width-1:0],dly72i[15:0]};
	dly73q <= {dly73q[(currentdly-1)*width-1:0],dly72q[15:0]};
	dly74i <= {dly74i[(currentdly-1)*width-1:0],dly73i[15:0]};
	dly74q <= {dly74q[(currentdly-1)*width-1:0],dly73q[15:0]};
	dly75i <= {dly75i[(currentdly-1)*width-1:0],dly74i[15:0]};
	dly75q <= {dly75q[(currentdly-1)*width-1:0],dly74q[15:0]};
	dly76i <= {dly76i[(currentdly-1)*width-1:0],dly75i[15:0]};
	dly76q <= {dly76q[(currentdly-1)*width-1:0],dly75q[15:0]};
	dly77i <= {dly77i[(currentdly-1)*width-1:0],dly76i[15:0]};
	dly77q <= {dly77q[(currentdly-1)*width-1:0],dly76q[15:0]};
	dly78i <= {dly78i[(currentdly-1)*width-1:0],dly77i[15:0]};
	dly78q <= {dly78q[(currentdly-1)*width-1:0],dly77q[15:0]};
	dly79i <= {dly79i[(currentdly-1)*width-1:0],dly78i[15:0]};
	dly79q <= {dly79q[(currentdly-1)*width-1:0],dly78q[15:0]};
	dly80i <= {dly80i[(currentdly-1)*width-1:0],dly79i[15:0]};
	dly80q <= {dly80q[(currentdly-1)*width-1:0],dly79q[15:0]};

	dly81i <= {dly81i[(currentdly-1)*width-1:0],dly80i[15:0]};
	dly81q <= {dly81q[(currentdly-1)*width-1:0],dly80q[15:0]};
	dly82i <= {dly82i[(currentdly-1)*width-1:0],dly81i[15:0]};
	dly82q <= {dly82q[(currentdly-1)*width-1:0],dly81q[15:0]};
	dly83i <= {dly83i[(currentdly-1)*width-1:0],dly82i[15:0]};
	dly83q <= {dly83q[(currentdly-1)*width-1:0],dly82q[15:0]};
	dly84i <= {dly84i[(currentdly-1)*width-1:0],dly83i[15:0]};
	dly84q <= {dly84q[(currentdly-1)*width-1:0],dly83q[15:0]};
	dly85i <= {dly85i[(currentdly-1)*width-1:0],dly84i[15:0]};
	dly85q <= {dly85q[(currentdly-1)*width-1:0],dly84q[15:0]};
	dly86i <= {dly86i[(currentdly-1)*width-1:0],dly85i[15:0]};
	dly86q <= {dly86q[(currentdly-1)*width-1:0],dly85q[15:0]};
	dly87i <= {dly87i[(currentdly-1)*width-1:0],dly86i[15:0]};
	dly87q <= {dly87q[(currentdly-1)*width-1:0],dly86q[15:0]};
	dly88i <= {dly88i[(currentdly-1)*width-1:0],dly87i[15:0]};
	dly88q <= {dly88q[(currentdly-1)*width-1:0],dly87q[15:0]};
	dly89i <= {dly89i[(currentdly-1)*width-1:0],dly88i[15:0]};
	dly89q <= {dly89q[(currentdly-1)*width-1:0],dly88q[15:0]};
	dly90i <= {dly90i[(currentdly-1)*width-1:0],dly89i[15:0]};
	dly90q <= {dly90q[(currentdly-1)*width-1:0],dly89q[15:0]};

	dly91i <= {dly91i[(currentdly-1)*width-1:0],dly90i[15:0]};
	dly91q <= {dly91q[(currentdly-1)*width-1:0],dly90q[15:0]};
	dly92i <= {dly92i[(currentdly-1)*width-1:0],dly91i[15:0]};
	dly92q <= {dly92q[(currentdly-1)*width-1:0],dly91q[15:0]};
	dly93i <= {dly93i[(currentdly-1)*width-1:0],dly92i[15:0]};
	dly93q <= {dly93q[(currentdly-1)*width-1:0],dly92q[15:0]};
	dly94i <= {dly94i[(currentdly-1)*width-1:0],dly93i[15:0]};
	dly94q <= {dly94q[(currentdly-1)*width-1:0],dly63q[15:0]};
	dly95i <= {dly95i[(currentdly-1)*width-1:0],dly94i[15:0]};
	dly95q <= {dly95q[(currentdly-1)*width-1:0],dly94q[15:0]};
	dly96i <= {dly96i[(currentdly-1)*width-1:0],dly95i[15:0]};
	dly96q <= {dly96q[(currentdly-1)*width-1:0],dly95q[15:0]};
	dly97i <= {dly97i[(currentdly-1)*width-1:0],dly96i[15:0]};
	dly97q <= {dly97q[(currentdly-1)*width-1:0],dly96q[15:0]};
	dly98i <= {dly98i[(currentdly-1)*width-1:0],dly97i[15:0]};
	dly98q <= {dly98q[(currentdly-1)*width-1:0],dly97q[15:0]};
	dly99i <= {dly99i[(currentdly-1)*width-1:0],dly98i[15:0]};
	dly99q <= {dly99q[(currentdly-1)*width-1:0],dly98q[15:0]};
	dly100i <= {dly100i[(currentdly-1)*width-1:0],dly99i[15:0]};
	dly100q <= {dly100q[(currentdly-1)*width-1:0],dly99q[15:0]};
*/
	//dly101i <= {dly101i[(currentdly-1)*width-1:0],dly100i[15:0]};
	//dly101q <= {dly101q[(currentdly-1)*width-1:0],dly100q[15:0]};
	//dly102i <= {dly102i[(currentdly-1)*width-1:0],dly101i[15:0]};
	//dly102q <= {dly102q[(currentdly-1)*width-1:0],dly101q[15:0]};
	//dly103i <= {dly103i[(currentdly-1)*width-1:0],dly102i[15:0]};
	//dly103q <= {dly103q[(currentdly-1)*width-1:0],dly102q[15:0]};
	//dly104i <= {dly104i[(currentdly-1)*width-1:0],dly103i[15:0]};
	//dly104q <= {dly104q[(currentdly-1)*width-1:0],dly103q[15:0]};
	//dly105i <= {dly105i[(currentdly-1)*width-1:0],dly104i[15:0]};
	//dly105q <= {dly105q[(currentdly-1)*width-1:0],dly104q[15:0]};
	//dly106i <= {dly106i[(currentdly-1)*width-1:0],dly105i[15:0]};
	//dly106q <= {dly106q[(currentdly-1)*width-1:0],dly105q[15:0]};
	//dly107i <= {dly107i[(currentdly-1)*width-1:0],dly106i[15:0]};
	//dly107q <= {dly107q[(currentdly-1)*width-1:0],dly106q[15:0]};
	//dly108i <= {dly108i[(currentdly-1)*width-1:0],dly107i[15:0]};
	//dly108q <= {dly108q[(currentdly-1)*width-1:0],dly107q[15:0]};
	//dly109i <= {dly109i[(currentdly-1)*width-1:0],dly108i[15:0]};
	//dly109q <= {dly109q[(currentdly-1)*width-1:0],dly108q[15:0]};
	//dly110i <= {dly110i[(currentdly-1)*width-1:0],dly109i[15:0]};
	//dly110q <= {dly110q[(currentdly-1)*width-1:0],dly109q[15:0]};

	//dly111i <= {dly111i[(currentdly-1)*width-1:0],dly110i[15:0]};
	//dly111q <= {dly111q[(currentdly-1)*width-1:0],dly110q[15:0]};
	//dly112i <= {dly112i[(currentdly-1)*width-1:0],dly111i[15:0]};
	//dly112q <= {dly112q[(currentdly-1)*width-1:0],dly111q[15:0]};
	//dly113i <= {dly113i[(currentdly-1)*width-1:0],dly112i[15:0]};
	//dly113q <= {dly113q[(currentdly-1)*width-1:0],dly112q[15:0]};
	//dly114i <= {dly114i[(currentdly-1)*width-1:0],dly113i[15:0]};
	//dly114q <= {dly114q[(currentdly-1)*width-1:0],dly113q[15:0]};
	//dly115i <= {dly115i[(currentdly-1)*width-1:0],dly114i[15:0]};
	//dly115q <= {dly115q[(currentdly-1)*width-1:0],dly114q[15:0]};
	//dly116i <= {dly116i[(currentdly-1)*width-1:0],dly115i[15:0]};
	//dly116q <= {dly116q[(currentdly-1)*width-1:0],dly115q[15:0]};
	//dly117i <= {dly117i[(currentdly-1)*width-1:0],dly116i[15:0]};
	//dly117q <= {dly117q[(currentdly-1)*width-1:0],dly116q[15:0]};
	//dly118i <= {dly118i[(currentdly-1)*width-1:0],dly117i[15:0]};
	//dly118q <= {dly118q[(currentdly-1)*width-1:0],dly117q[15:0]};
	//dly119i <= {dly119i[(currentdly-1)*width-1:0],dly118i[15:0]};
	//dly119q <= {dly119q[(currentdly-1)*width-1:0],dly118q[15:0]};
	//dly120i <= {dly120i[(currentdly-1)*width-1:0],dly119i[15:0]};
	//dly120q <= {dly120q[(currentdly-1)*width-1:0],dly119q[15:0]};


	//dly121i <= {dly121i[(currentdly-1)*width-1:0],dly120i[15:0]};
	//dly121q <= {dly121q[(currentdly-1)*width-1:0],dly120q[15:0]};
	//dly122i <= {dly122i[(currentdly-1)*width-1:0],dly121i[15:0]};
	//dly122q <= {dly122q[(currentdly-1)*width-1:0],dly121q[15:0]};
	//dly123i <= {dly123i[(currentdly-1)*width-1:0],dly122i[15:0]};
	//dly123q <= {dly123q[(currentdly-1)*width-1:0],dly122q[15:0]};
	//dly124i <= {dly124i[(currentdly-1)*width-1:0],dly123i[15:0]};
	//dly124q <= {dly124q[(currentdly-1)*width-1:0],dly123q[15:0]};
	//dly125i <= {dly125i[(currentdly-1)*width-1:0],dly124i[15:0]};
	//dly125q <= {dly125q[(currentdly-1)*width-1:0],dly124q[15:0]};
	//dly126i <= {dly126i[(currentdly-1)*width-1:0],dly125i[15:0]};
	//dly126q <= {dly126q[(currentdly-1)*width-1:0],dly125q[15:0]};
	//dly127i <= {dly127i[(currentdly-1)*width-1:0],dly126i[15:0]};
	//dly127q <= {dly127q[(currentdly-1)*width-1:0],dly126q[15:0]};
	//dly128i <= {dly128i[(currentdly-1)*width-1:0],dly127i[15:0]};
	//dly128q <= {dly128q[(currentdly-1)*width-1:0],dly127q[15:0]};
	//dly129i <= {dly129i[(currentdly-1)*width-1:0],dly128i[15:0]};
	//dly129q <= {dly129q[(currentdly-1)*width-1:0],dly128q[15:0]};
	//dly130i <= {dly130i[(currentdly-1)*width-1:0],dly129i[15:0]};
	//dly130q <= {dly130q[(currentdly-1)*width-1:0],dly129q[15:0]};

	//dly131i <= {dly131i[(currentdly-1)*width-1:0],dly130i[15:0]};
	//dly131q <= {dly131q[(currentdly-1)*width-1:0],dly130q[15:0]};
	//dly132i <= {dly132i[(currentdly-1)*width-1:0],dly131i[15:0]};
	//dly132q <= {dly132q[(currentdly-1)*width-1:0],dly131q[15:0]};
	//dly133i <= {dly133i[(currentdly-1)*width-1:0],dly132i[15:0]};
	//dly133q <= {dly133q[(currentdly-1)*width-1:0],dly132q[15:0]};
	//dly134i <= {dly134i[(currentdly-1)*width-1:0],dly133i[15:0]};
	//dly134q <= {dly134q[(currentdly-1)*width-1:0],dly133q[15:0]};
	//dly135i <= {dly135i[(currentdly-1)*width-1:0],dly134i[15:0]};
	//dly135q <= {dly135q[(currentdly-1)*width-1:0],dly134q[15:0]};
	//dly136i <= {dly136i[(currentdly-1)*width-1:0],dly135i[15:0]};
	//dly136q <= {dly136q[(currentdly-1)*width-1:0],dly135q[15:0]};
	//dly137i <= {dly137i[(currentdly-1)*width-1:0],dly136i[15:0]};
	//dly137q <= {dly137q[(currentdly-1)*width-1:0],dly136q[15:0]};
	//dly138i <= {dly138i[(currentdly-1)*width-1:0],dly137i[15:0]};
	//dly138q <= {dly138q[(currentdly-1)*width-1:0],dly137q[15:0]};
	//dly139i <= {dly139i[(currentdly-1)*width-1:0],dly138i[15:0]};
	//dly139q <= {dly139q[(currentdly-1)*width-1:0],dly138q[15:0]};
	//dly140i <= {dly140i[(currentdly-1)*width-1:0],dly139i[15:0]};
	//dly140q <= {dly140q[(currentdly-1)*width-1:0],dly139q[15:0]};

	//dly141i <= {dly141i[(currentdly-1)*width-1:0],dly140i[15:0]};
	//dly141q <= {dly141q[(currentdly-1)*width-1:0],dly140q[15:0]};
	//dly142i <= {dly142i[(currentdly-1)*width-1:0],dly141i[15:0]};
	//dly142q <= {dly142q[(currentdly-1)*width-1:0],dly141q[15:0]};
	//dly143i <= {dly143i[(currentdly-1)*width-1:0],dly142i[15:0]};
	//dly143q <= {dly143q[(currentdly-1)*width-1:0],dly142q[15:0]};
	//dly144i <= {dly144i[(currentdly-1)*width-1:0],dly143i[15:0]};
	//dly144q <= {dly144q[(currentdly-1)*width-1:0],dly143q[15:0]};
	//dly145i <= {dly145i[(currentdly-1)*width-1:0],dly144i[15:0]};
	//dly115q <= {dly145q[(currentdly-1)*width-1:0],dly144q[15:0]};
	//dly146i <= {dly146i[(currentdly-1)*width-1:0],dly145i[15:0]};
	//dly146q <= {dly146q[(currentdly-1)*width-1:0],dly145q[15:0]};
	//dly147i <= {dly147i[(currentdly-1)*width-1:0],dly146i[15:0]};
	//dly147q <= {dly147q[(currentdly-1)*width-1:0],dly146q[15:0]};
	//dly148i <= {dly148i[(currentdly-1)*width-1:0],dly147i[15:0]};
	//dly148q <= {dly148q[(currentdly-1)*width-1:0],dly147q[15:0]};
	//dly149i <= {dly149i[(currentdly-1)*width-1:0],dly148i[15:0]};
	//dly149q <= {dly149q[(currentdly-1)*width-1:0],dly148q[15:0]};
	//dly150i <= {dly150i[(currentdly-1)*width-1:0],dly149i[15:0]};
	//dly150q <= {dly150q[(currentdly-1)*width-1:0],dly149q[15:0]};

	//dly151i <= {dly151i[(currentdly-1)*width-1:0],dly150i[15:0]};
	//dly151q <= {dly151q[(currentdly-1)*width-1:0],dly150q[15:0]};
	//dly152i <= {dly152i[(currentdly-1)*width-1:0],dly151i[15:0]};
	//dly152q <= {dly152q[(currentdly-1)*width-1:0],dly151q[15:0]};
	//dly153i <= {dly153i[(currentdly-1)*width-1:0],dly152i[15:0]};
	//dly153q <= {dly153q[(currentdly-1)*width-1:0],dly152q[15:0]};
	//dly154i <= {dly154i[(currentdly-1)*width-1:0],dly153i[15:0]};
	//dly154q <= {dly154q[(currentdly-1)*width-1:0],dly153q[15:0]};
	//dly155i <= {dly155i[(currentdly-1)*width-1:0],dly154i[15:0]};
	//dly155q <= {dly155q[(currentdly-1)*width-1:0],dly154q[15:0]};
	//dly156i <= {dly156i[(currentdly-1)*width-1:0],dly155i[15:0]};
	//dly156q <= {dly156q[(currentdly-1)*width-1:0],dly155q[15:0]};
	//dly157i <= {dly157i[(currentdly-1)*width-1:0],dly156i[15:0]};
	//dly157q <= {dly157q[(currentdly-1)*width-1:0],dly156q[15:0]};
	//dly158i <= {dly158i[(currentdly-1)*width-1:0],dly157i[15:0]};
	//dly158q <= {dly158q[(currentdly-1)*width-1:0],dly157q[15:0]};
	//dly159i <= {dly159i[(currentdly-1)*width-1:0],dly158i[15:0]};
	//dly159q <= {dly159q[(currentdly-1)*width-1:0],dly158q[15:0]};
	//dly160i <= {dly160i[(currentdly-1)*width-1:0],dly159i[15:0]};
	//dly160q <= {dly160q[(currentdly-1)*width-1:0],dly159q[15:0]};

	//dly161i <= {dly161i[(currentdly-1)*width-1:0],dly160i[15:0]};
	//dly161q <= {dly161q[(currentdly-1)*width-1:0],dly160q[15:0]};
	//dly162i <= {dly162i[(currentdly-1)*width-1:0],dly161i[15:0]};
	//dly162q <= {dly162q[(currentdly-1)*width-1:0],dly161q[15:0]};
	//dly163i <= {dly163i[(currentdly-1)*width-1:0],dly162i[15:0]};
	//dly163q <= {dly163q[(currentdly-1)*width-1:0],dly162q[15:0]};
	//dly164i <= {dly164i[(currentdly-1)*width-1:0],dly163i[15:0]};
	//dly164q <= {dly164q[(currentdly-1)*width-1:0],dly163q[15:0]};
	//dly165i <= {dly165i[(currentdly-1)*width-1:0],dly164i[15:0]};
	//dly165q <= {dly165q[(currentdly-1)*width-1:0],dly164q[15:0]};
	//dly166i <= {dly166i[(currentdly-1)*width-1:0],dly165i[15:0]};
	//dly166q <= {dly166q[(currentdly-1)*width-1:0],dly165q[15:0]};
	//dly167i <= {dly167i[(currentdly-1)*width-1:0],dly166i[15:0]};
	//dly167q <= {dly167q[(currentdly-1)*width-1:0],dly166q[15:0]};
	//dly168i <= {dly168i[(currentdly-1)*width-1:0],dly167i[15:0]};
	//dly168q <= {dly168q[(currentdly-1)*width-1:0],dly167q[15:0]};
	//dly169i <= {dly169i[(currentdly-1)*width-1:0],dly168i[15:0]};
	//dly169q <= {dly169q[(currentdly-1)*width-1:0],dly168q[15:0]};
	//dly170i <= {dly170i[(currentdly-1)*width-1:0],dly169i[15:0]};
	//dly170q <= {dly170q[(currentdly-1)*width-1:0],dly169q[15:0]};

	//dly171i <= {dly171i[(currentdly-1)*width-1:0],dly170i[15:0]};
	//dly171q <= {dly171q[(currentdly-1)*width-1:0],dly170q[15:0]};
	//dly172i <= {dly172i[(currentdly-1)*width-1:0],dly171i[15:0]};
	//dly172q <= {dly172q[(currentdly-1)*width-1:0],dly171q[15:0]};
	//dly173i <= {dly173i[(currentdly-1)*width-1:0],dly172i[15:0]};
	//dly173q <= {dly173q[(currentdly-1)*width-1:0],dly172q[15:0]};
	//dly174i <= {dly114i[(currentdly-1)*width-1:0],dly173i[15:0]};
	//dly174q <= {dly174q[(currentdly-1)*width-1:0],dly173q[15:0]};
	//dly175i <= {dly175i[(currentdly-1)*width-1:0],dly174i[15:0]};
	//dly175q <= {dly175q[(currentdly-1)*width-1:0],dly174q[15:0]};
	//dly176i <= {dly176i[(currentdly-1)*width-1:0],dly175i[15:0]};
	//dly176q <= {dly176q[(currentdly-1)*width-1:0],dly175q[15:0]};
	//dly177i <= {dly177i[(currentdly-1)*width-1:0],dly176i[15:0]};
	//dly177q <= {dly177q[(currentdly-1)*width-1:0],dly176q[15:0]};
	//dly178i <= {dly178i[(currentdly-1)*width-1:0],dly177i[15:0]};
	//dly178q <= {dly178q[(currentdly-1)*width-1:0],dly177q[15:0]};
	//dly179i <= {dly179i[(currentdly-1)*width-1:0],dly178i[15:0]};
	//dly179q <= {dly179q[(currentdly-1)*width-1:0],dly178q[15:0]};
	//dly180i <= {dly180i[(currentdly-1)*width-1:0],dly179i[15:0]};
	//dly180q <= {dly180q[(currentdly-1)*width-1:0],dly179q[15:0]};

	//dly181i <= {dly181i[(currentdly-1)*width-1:0],dly180i[15:0]};
	//dly181q <= {dly181q[(currentdly-1)*width-1:0],dly180q[15:0]};
	//dly182i <= {dly182i[(currentdly-1)*width-1:0],dly181i[15:0]};
	//dly182q <= {dly182q[(currentdly-1)*width-1:0],dly181q[15:0]};
	//dly183i <= {dly183i[(currentdly-1)*width-1:0],dly182i[15:0]};
	//dly183q <= {dly183q[(currentdly-1)*width-1:0],dly182q[15:0]};
	//dly184i <= {dly184i[(currentdly-1)*width-1:0],dly183i[15:0]};
	//dly184q <= {dly184q[(currentdly-1)*width-1:0],dly183q[15:0]};
	//dly185i <= {dly185i[(currentdly-1)*width-1:0],dly184i[15:0]};
	//dly185q <= {dly185q[(currentdly-1)*width-1:0],dly184q[15:0]};
	//dly186i <= {dly186i[(currentdly-1)*width-1:0],dly185i[15:0]};
	//dly186q <= {dly186q[(currentdly-1)*width-1:0],dly185q[15:0]};
	//dly187i <= {dly187i[(currentdly-1)*width-1:0],dly186i[15:0]};
	//dly187q <= {dly187q[(currentdly-1)*width-1:0],dly186q[15:0]};
	//dly188i <= {dly188i[(currentdly-1)*width-1:0],dly187i[15:0]};
	//dly188q <= {dly188q[(currentdly-1)*width-1:0],dly187q[15:0]};
	//dly189i <= {dly189i[(currentdly-1)*width-1:0],dly188i[15:0]};
	//dly189q <= {dly189q[(currentdly-1)*width-1:0],dly188q[15:0]};
	//dly190i <= {dly190i[(currentdly-1)*width-1:0],dly189i[15:0]};
	//dly190q <= {dly190q[(currentdly-1)*width-1:0],dly189q[15:0]};

	//dly191i <= {dly191i[(currentdly-1)*width-1:0],dly190i[15:0]};
	//dly191q <= {dly191q[(currentdly-1)*width-1:0],dly190q[15:0]};
	//dly192i <= {dly192i[(currentdly-1)*width-1:0],dly191i[15:0]};
	//dly192q <= {dly192q[(currentdly-1)*width-1:0],dly191q[15:0]};
	//dly193i <= {dly193i[(currentdly-1)*width-1:0],dly192i[15:0]};
	//dly193q <= {dly193q[(currentdly-1)*width-1:0],dly192q[15:0]};
	//dly194i <= {dly194i[(currentdly-1)*width-1:0],dly193i[15:0]};
	//dly194q <= {dly194q[(currentdly-1)*width-1:0],dly193q[15:0]};
	/*dly195i <= {dly195i[(currentdly-1)*width-1:0],dly194i[15:0]};
	dly195q <= {dly195q[(currentdly-1)*width-1:0],dly194q[15:0]};
	dly196i <= {dly196i[(currentdly-1)*width-1:0],dly195i[15:0]};
	dly196q <= {dly196q[(currentdly-1)*width-1:0],dly195q[15:0]};
	dly197i <= {dly197i[(currentdly-1)*width-1:0],dly196i[15:0]};
	dly197q <= {dly197q[(currentdly-1)*width-1:0],dly196q[15:0]};
	dly198i <= {dly198i[(currentdly-1)*width-1:0],dly197i[15:0]};
	dly198q <= {dly198q[(currentdly-1)*width-1:0],dly197q[15:0]};
	dly199i <= {dly199i[(currentdly-1)*width-1:0],dly198i[15:0]};
	dly199q <= {dly199q[(currentdly-1)*width-1:0],dly198q[15:0]};
	dly200i <= {dly200i[(currentdly-1)*width-1:0],dly199i[15:0]};
	dly200q <= {dly200q[(currentdly-1)*width-1:0],dly199q[15:0]};*/
always @(*)
begin
case(currentdlycount)
	32'd1:begin
		 adc_data_i0 = dly1i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly1q[(currentdly)*width-1-:16];
		end
	32'd2:begin
		 adc_data_i0 = dly2i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly2q[(currentdly)*width-1-:16];
		end
	32'd3:begin
		 adc_data_i0 = dly3i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly3q[(currentdly)*width-1-:16];
		end
	32'd4:begin
		 adc_data_i0 = dly4i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly4q[(currentdly)*width-1-:16];
		end
	32'd5:begin
		 adc_data_i0 = dly5i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly5q[(currentdly)*width-1-:16];
		end
	32'd6:begin
		 adc_data_i0 = dly6i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly6q[(currentdly)*width-1-:16];
		end
	32'd7:begin
		 adc_data_i0 = dly7i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly7q[(currentdly)*width-1-:16];
		end
	32'd8:begin
		 adc_data_i0 = dly8i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly8q[(currentdly)*width-1-:16];
		end
	32'd9:begin
		 adc_data_i0 = dly9i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly9q[(currentdly)*width-1-:16];
		end
	32'd10:begin
		 adc_data_i0 = dly10i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly10q[(currentdly)*width-1-:16];
		end
	/*32'd11:begin
		 adc_data_i0 = dly11i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly11q[(currentdly)*width-1-:16];
		end
	32'd12:begin
		 adc_data_i0 = dly12i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly12q[(currentdly)*width-1-:16];
		end
	32'd13:begin
		 adc_data_i0 = dly13i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly13q[(currentdly)*width-1-:16];
		end
	32'd14:begin
		 adc_data_i0 = dly14i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly14q[(currentdly)*width-1-:16];
		end
	32'd15:begin
		 adc_data_i0 = dly15i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly15q[(currentdly)*width-1-:16];
		end
	32'd16:begin
		 adc_data_i0 = dly16i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly16q[(currentdly)*width-1-:16];
		end
	32'd17:begin
		 adc_data_i0 = dly17i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly17q[(currentdly)*width-1-:16];
		end
	32'd18:begin
		 adc_data_i0 = dly18i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly18q[(currentdly)*width-1-:16];
		end
	32'd19:begin
		 adc_data_i0 = dly19i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly19q[(currentdly)*width-1-:16];
		end
	32'd20:begin
		 adc_data_i0 = dly20i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly20q[(currentdly)*width-1-:16];
		end
	32'd21:begin
		 adc_data_i0 = dly21i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly21q[(currentdly)*width-1-:16];
		end
	32'd22:begin
		 adc_data_i0 = dly22i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly22q[(currentdly)*width-1-:16];
		end
	32'd23:begin
		 adc_data_i0 = dly23i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly23q[(currentdly)*width-1-:16];
		end
	32'd24:begin
		 adc_data_i0 = dly24i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly24q[(currentdly)*width-1-:16];
		end
	32'd25:begin
		 adc_data_i0 = dly25i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly25q[(currentdly)*width-1-:16];
		end
	32'd26:begin
		 adc_data_i0 = dly26i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly26q[(currentdly)*width-1-:16];
		end
	32'd27:begin
		 adc_data_i0 = dly27i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly27q[(currentdly)*width-1-:16];
		end
	32'd28:begin
		 adc_data_i0 = dly28i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly28q[(currentdly)*width-1-:16];
		end
	32'd29:begin
		 adc_data_i0 = dly29i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly29q[(currentdly)*width-1-:16];
		end
	32'd30:begin
		 adc_data_i0 = dly30i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly30q[(currentdly)*width-1-:16];
		end
	32'd31:begin
		 adc_data_i0 = dly31i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly31q[(currentdly)*width-1-:16];
		end
	32'd32:begin
		 adc_data_i0 = dly32i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly32q[(currentdly)*width-1-:16];
		end
	32'd33:begin
		 adc_data_i0 = dly33i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly33q[(currentdly)*width-1-:16];
		end
	32'd34:begin
		 adc_data_i0 = dly34i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly34q[(currentdly)*width-1-:16];
		end
	32'd35:begin
		 adc_data_i0 = dly35i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly35q[(currentdly)*width-1-:16];
		end
	32'd36:begin
		 adc_data_i0 = dly36i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly36q[(currentdly)*width-1-:16];
		end
	32'd37:begin
		 adc_data_i0 = dly37i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly37q[(currentdly)*width-1-:16];
		end
	32'd38:begin
		 adc_data_i0 = dly38i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly38q[(currentdly)*width-1-:16];
		end
	32'd39:begin
		 adc_data_i0 = dly39i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly39q[(currentdly)*width-1-:16];
		end
	32'd40:begin
		 adc_data_i0 = dly40i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly40q[(currentdly)*width-1-:16];
		end
	32'd41:begin
		 adc_data_i0 = dly41i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly41q[(currentdly)*width-1-:16];
		end
	32'd42:begin
		 adc_data_i0 = dly42i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly42q[(currentdly)*width-1-:16];
		end
	32'd43:begin
		 adc_data_i0 = dly43i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly43q[(currentdly)*width-1-:16];
		end
	32'd44:begin
		 adc_data_i0 = dly44i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly44q[(currentdly)*width-1-:16];
		end
	32'd45:begin
		 adc_data_i0 = dly45i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly45q[(currentdly)*width-1-:16];
		end
	32'd46:begin
		 adc_data_i0 = dly46i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly46q[(currentdly)*width-1-:16];
		end
	32'd47:begin
		 adc_data_i0 = dly47i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly47q[(currentdly)*width-1-:16];
		end
	32'd48:begin
		 adc_data_i0 = dly48i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly48q[(currentdly)*width-1-:16];
		end
	32'd49:begin
		 adc_data_i0 = dly49i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly49q[(currentdly)*width-1-:16];
		end
	32'd50:begin
		 adc_data_i0 = dly50i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly50q[(currentdly)*width-1-:16];
		end
	/*32'd51:begin
		 adc_data_i0 = dly51i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly51q[(currentdly)*width-1-:16];
		end
	32'd52:begin
		 adc_data_i0 = dly52i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly52q[(currentdly)*width-1-:16];
		end
	32'd53:begin
		 adc_data_i0 = dly53i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly53q[(currentdly)*width-1-:16];
		end
	32'd54:begin
		 adc_data_i0 = dly54i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly54q[(currentdly)*width-1-:16];
		end
	32'd55:begin
		 adc_data_i0 = dly55i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly55q[(currentdly)*width-1-:16];
		end
	32'd56:begin
		 adc_data_i0 = dly56i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly56q[(currentdly)*width-1-:16];
		end
	32'd57:begin
		 adc_data_i0 = dly57i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly57q[(currentdly)*width-1-:16];
		end
	32'd58:begin
		 adc_data_i0 = dly58i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly58q[(currentdly)*width-1-:16];
		end
	32'd59:begin
		 adc_data_i0 = dly59i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly59q[(currentdly)*width-1-:16];
		end
	32'd60:begin
		 adc_data_i0 = dly60i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly60q[(currentdly)*width-1-:16];
		end
	32'd61:begin
		 adc_data_i0 = dly61i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly61q[(currentdly)*width-1-:16];
		end
	32'd62:begin
		 adc_data_i0 = dly62i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly62q[(currentdly)*width-1-:16];
		end
	32'd63:begin
		 adc_data_i0 = dly63i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly63q[(currentdly)*width-1-:16];
		end
	32'd64:begin
		 adc_data_i0 = dly64i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly64q[(currentdly)*width-1-:16];
		end
	32'd65:begin
		 adc_data_i0 = dly65i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly65q[(currentdly)*width-1-:16];
		end
	32'd66:begin
		 adc_data_i0 = dly66i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly66q[(currentdly)*width-1-:16];
		end
	32'd67:begin
		 adc_data_i0 = dly67i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly67q[(currentdly)*width-1-:16];
		end
	32'd68:begin
		 adc_data_i0 = dly68i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly68q[(currentdly)*width-1-:16];
		end
	32'd69:begin
		 adc_data_i0 = dly69i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly69q[(currentdly)*width-1-:16];
		end
	32'd70:begin
		 adc_data_i0 = dly70i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly70q[(currentdly)*width-1-:16];
		end
	32'd71:begin
		 adc_data_i0 = dly71i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly71q[(currentdly)*width-1-:16];
		end
	32'd72:begin
		 adc_data_i0 = dly72i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly72q[(currentdly)*width-1-:16];
		end
	32'd73:begin
		 adc_data_i0 = dly73i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly73q[(currentdly)*width-1-:16];
		end
	32'd74:begin
		 adc_data_i0 = dly74i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly74q[(currentdly)*width-1-:16];
		end
	32'd75:begin
		 adc_data_i0 = dly75i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly75q[(currentdly)*width-1-:16];
		end
	32'd76:begin
		 adc_data_i0 = dly76i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly76q[(currentdly)*width-1-:16];
		end
	32'd77:begin
		 adc_data_i0 = dly77i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly77q[(currentdly)*width-1-:16];
		end
	32'd78:begin
		 adc_data_i0 = dly78i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly78q[(currentdly)*width-1-:16];
		end
	32'd79:begin
		 adc_data_i0 = dly79i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly79q[(currentdly)*width-1-:16];
		end
	32'd80:begin
		 adc_data_i0 = dly80i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly80q[(currentdly)*width-1-:16];
		end
	32'd81:begin
		 adc_data_i0 = dly81i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly81q[(currentdly)*width-1-:16];
		end
	32'd82:begin
		 adc_data_i0 = dly82i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly82q[(currentdly)*width-1-:16];
		end
	32'd83:begin
		 adc_data_i0 = dly83i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly83q[(currentdly)*width-1-:16];
		end
	32'd84:begin
		 adc_data_i0 = dly84i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly84q[(currentdly)*width-1-:16];
		end
	32'd85:begin
		 adc_data_i0 = dly85i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly85q[(currentdly)*width-1-:16];
		end
	32'd86:begin
		 adc_data_i0 = dly86i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly86q[(currentdly)*width-1-:16];
		end
	32'd87:begin
		 adc_data_i0 = dly87i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly87q[(currentdly)*width-1-:16];
		end
	32'd88:begin
		 adc_data_i0 = dly88i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly88q[(currentdly)*width-1-:16];
		end
	32'd89:begin
		 adc_data_i0 = dly89i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly89q[(currentdly)*width-1-:16];
		end
	32'd90:begin
		 adc_data_i0 = dly90i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly90q[(currentdly)*width-1-:16];
		end
	32'd91:begin
		 adc_data_i0 = dly91i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly91q[(currentdly)*width-1-:16];
		end
	32'd92:begin
		 adc_data_i0 = dly92i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly92q[(currentdly)*width-1-:16];
		end
	32'd93:begin
		 adc_data_i0 = dly93i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly93q[(currentdly)*width-1-:16];
		end
	32'd94:begin
		 adc_data_i0 = dly94i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly94q[(currentdly)*width-1-:16];
		end
	32'd95:begin
		 adc_data_i0 = dly95i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly95q[(currentdly)*width-1-:16];
		end
	32'd96:begin
		 adc_data_i0 = dly96i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly96q[(currentdly)*width-1-:16];
		end
	32'd97:begin
		 adc_data_i0 = dly97i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly97q[(currentdly)*width-1-:16];
		end
	32'd98:begin
		 adc_data_i0 = dly98i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly98q[(currentdly)*width-1-:16];
		end
	32'd99:begin
		 adc_data_i0 = dly99i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly99q[(currentdly)*width-1-:16];
		end
	32'd100:begin
		 adc_data_i0 = dly100i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly100q[(currentdly)*width-1-:16];
		end
	/*32'd101:begin
		 adc_data_i0 = dly101i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly101q[(currentdly)*width-1-:16];
		end
	32'd102:begin
		 adc_data_i0 = dly102i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly102q[(currentdly)*width-1-:16];
		end
	32'd103:begin
		 adc_data_i0 = dly103i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly103q[(currentdly)*width-1-:16];
		end
	32'd104:begin
		 adc_data_i0 = dly104i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly104q[(currentdly)*width-1-:16];
		end
	32'd105:begin
		 adc_data_i0 = dly105i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly105q[(currentdly)*width-1-:16];
		end
	32'd106:begin
		 adc_data_i0 = dly106i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly106q[(currentdly)*width-1-:16];
		end
	32'd107:begin
		 adc_data_i0 = dly107i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly107q[(currentdly)*width-1-:16];
		end
	32'd108:begin
		 adc_data_i0 = dly108i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly108q[(currentdly)*width-1-:16];
		end
	32'd109:begin
		 adc_data_i0 = dly109i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly109q[(currentdly)*width-1-:16];
		end
	32'd110:begin
		 adc_data_i0 = dly110i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly110q[(currentdly)*width-1-:16];
		end
	32'd111:begin
		 adc_data_i0 = dly111i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly111q[(currentdly)*width-1-:16];
		end
	32'd112:begin
		 adc_data_i0 = dly112i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly112q[(currentdly)*width-1-:16];
		end
	32'd113:begin
		 adc_data_i0 = dly113i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly113q[(currentdly)*width-1-:16];
		end
	32'd114:begin
		 adc_data_i0 = dly114i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly114q[(currentdly)*width-1-:16];
		end
	32'd115:begin
		 adc_data_i0 = dly115i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly115q[(currentdly)*width-1-:16];
		end
	32'd116:begin
		 adc_data_i0 = dly116i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly116q[(currentdly)*width-1-:16];
		end
	32'd117:begin
		 adc_data_i0 = dly117i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly117q[(currentdly)*width-1-:16];
		end
	32'd118:begin
		 adc_data_i0 = dly118i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly118q[(currentdly)*width-1-:16];
		end
	32'd119:begin
		 adc_data_i0 = dly119i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly119q[(currentdly)*width-1-:16];
		end
	32'd120:begin
		 adc_data_i0 = dly120i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly120q[(currentdly)*width-1-:16];
		end
	32'd121:begin
		 adc_data_i0 = dly121i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly121q[(currentdly)*width-1-:16];
		end
	32'd122:begin
		 adc_data_i0 = dly122i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly122q[(currentdly)*width-1-:16];
		end
	32'd123:begin
		 adc_data_i0 = dly123i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly123q[(currentdly)*width-1-:16];
		end
	32'd124:begin
		 adc_data_i0 = dly124i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly124q[(currentdly)*width-1-:16];
		end
	32'd125:begin
		 adc_data_i0 = dly125i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly125q[(currentdly)*width-1-:16];
		end
	32'd126:begin
		 adc_data_i0 = dly126i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly126q[(currentdly)*width-1-:16];
		end
	32'd127:begin
		 adc_data_i0 = dly127i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly127q[(currentdly)*width-1-:16];
		end
	32'd128:begin
		 adc_data_i0 = dly128i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly128q[(currentdly)*width-1-:16];
		end
	32'd129:begin
		 adc_data_i0 = dly129i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly129q[(currentdly)*width-1-:16];
		end

	32'd130:begin
		 adc_data_i0 = dly130i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly130q[(currentdly)*width-1-:16];
		end
	32'd131:begin
		 adc_data_i0 = dly131i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly131q[(currentdly)*width-1-:16];
		end
	32'd132:begin
		 adc_data_i0 = dly132i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly132q[(currentdly)*width-1-:16];
		end
	32'd133:begin
		 adc_data_i0 = dly133i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly133q[(currentdly)*width-1-:16];
		end
	32'd134:begin
		 adc_data_i0 = dly134i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly134q[(currentdly)*width-1-:16];
		end
	32'd135:begin
		 adc_data_i0 = dly135i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly135q[(currentdly)*width-1-:16];
		end
	32'd136:begin
		 adc_data_i0 = dly136i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly136q[(currentdly)*width-1-:16];
		end
	32'd137:begin
		 adc_data_i0 = dly137i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly137q[(currentdly)*width-1-:16];
		end
	32'd138:begin
		 adc_data_i0 = dly138i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly138q[(currentdly)*width-1-:16];
		end
	32'd139:begin
		 adc_data_i0 = dly139i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly139q[(currentdly)*width-1-:16];
		end
	32'd140:begin
		 adc_data_i0 = dly140i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly140q[(currentdly)*width-1-:16];
		end
	32'd141:begin
		 adc_data_i0 = dly141i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly141q[(currentdly)*width-1-:16];
		end
	32'd142:begin
		 adc_data_i0 = dly142i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly142q[(currentdly)*width-1-:16];
		end
	32'd143:begin
		 adc_data_i0 = dly143i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly143q[(currentdly)*width-1-:16];
		end
	32'd144:begin
		 adc_data_i0 = dly144i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly144q[(currentdly)*width-1-:16];
		end
	32'd145:begin
		 adc_data_i0 = dly145i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly145q[(currentdly)*width-1-:16];
		end
	32'd146:begin
		 adc_data_i0 = dly146i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly146q[(currentdly)*width-1-:16];
		end
	32'd147:begin
		 adc_data_i0 = dly147i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly147q[(currentdly)*width-1-:16];
		end
	32'd148:begin
		 adc_data_i0 = dly148i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly148q[(currentdly)*width-1-:16];
		end
	32'd149:begin
		 adc_data_i0 = dly149i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly149q[(currentdly)*width-1-:16];
		end
	32'd150:begin
		 adc_data_i0 = dly150i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly150q[(currentdly)*width-1-:16];
		end
	32'd151:begin
		 adc_data_i0 = dly151i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly151q[(currentdly)*width-1-:16];
		end
	32'd152:begin
		 adc_data_i0 = dly152i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly152q[(currentdly)*width-1-:16];
		end
	32'd153:begin
		 adc_data_i0 = dly153i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly153q[(currentdly)*width-1-:16];
		end
	32'd154:begin
		 adc_data_i0 = dly154i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly154q[(currentdly)*width-1-:16];
		end
	32'd155:begin
		 adc_data_i0 = dly155i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly155q[(currentdly)*width-1-:16];
		end
	32'd156:begin
		 adc_data_i0 = dly156i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly156q[(currentdly)*width-1-:16];
		end
	32'd157:begin
		 adc_data_i0 = dly157i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly157q[(currentdly)*width-1-:16];
		end
	32'd158:begin
		 adc_data_i0 = dly158i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly158q[(currentdly)*width-1-:16];
		end
	32'd159:begin
		 adc_data_i0 = dly159i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly159q[(currentdly)*width-1-:16];
		end
	32'd160:begin
		 adc_data_i0 = dly160i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly160q[(currentdly)*width-1-:16];
		end
	32'd161:begin
		 adc_data_i0 = dly161i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly161q[(currentdly)*width-1-:16];
		end
	32'd162:begin
		 adc_data_i0 = dly162i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly162q[(currentdly)*width-1-:16];
		end
	32'd163:begin
		 adc_data_i0 = dly163i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly163q[(currentdly)*width-1-:16];
		end
	32'd164:begin
		 adc_data_i0 = dly164i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly164q[(currentdly)*width-1-:16];
		end
	32'd165:begin
		 adc_data_i0 = dly165i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly165q[(currentdly)*width-1-:16];
		end
	32'd166:begin
		 adc_data_i0 = dly166i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly166q[(currentdly)*width-1-:16];
		end
	32'd167:begin
		 adc_data_i0 = dly167i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly167q[(currentdly)*width-1-:16];
		end
	32'd168:begin
		 adc_data_i0 = dly168i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly168q[(currentdly)*width-1-:16];
		end
	32'd169:begin
		 adc_data_i0 = dly169i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly169q[(currentdly)*width-1-:16];
		end
	32'd170:begin
		 adc_data_i0 = dly170i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly170q[(currentdly)*width-1-:16];
		end
	32'd171:begin
		 adc_data_i0 = dly171i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly171q[(currentdly)*width-1-:16];
		end
	32'd172:begin
		 adc_data_i0 = dly172i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly172q[(currentdly)*width-1-:16];
		end
	32'd173:begin
		 adc_data_i0 = dly173i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly173q[(currentdly)*width-1-:16];
		end
	32'd174:begin
		 adc_data_i0 = dly174i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly174q[(currentdly)*width-1-:16];
		end
	32'd175:begin
		 adc_data_i0 = dly175i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly175q[(currentdly)*width-1-:16];
		end
	32'd176:begin
		 adc_data_i0 = dly176i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly176q[(currentdly)*width-1-:16];
		end
	32'd177:begin
		 adc_data_i0 = dly177i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly177q[(currentdly)*width-1-:16];
		end
	32'd178:begin
		 adc_data_i0 = dly178i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly178q[(currentdly)*width-1-:16];
		end
	32'd179:begin
		 adc_data_i0 = dly179i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly179q[(currentdly)*width-1-:16];
		end
	32'd180:begin
		 adc_data_i0 = dly180i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly180q[(currentdly)*width-1-:16];
		end
	32'd181:begin
		 adc_data_i0 = dly181i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly181q[(currentdly)*width-1-:16];
		end
	32'd182:begin
		 adc_data_i0 = dly182i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly182q[(currentdly)*width-1-:16];
		end
	32'd183:begin
		 adc_data_i0 = dly183i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly183q[(currentdly)*width-1-:16];
		end
	32'd184:begin
		 adc_data_i0 = dly184i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly184q[(currentdly)*width-1-:16];
		end
	32'd185:begin
		 adc_data_i0 = dly185i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly185q[(currentdly)*width-1-:16];
		end
	32'd186:begin
		 adc_data_i0 = dly186i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly186q[(currentdly)*width-1-:16];
		end
	32'd187:begin
		 adc_data_i0 = dly187i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly187q[(currentdly)*width-1-:16];
		end
	32'd188:begin
		 adc_data_i0 = dly188i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly188q[(currentdly)*width-1-:16];
		end
	32'd189:begin
		 adc_data_i0 = dly189i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly189q[(currentdly)*width-1-:16];
		end
	32'd190:begin
		 adc_data_i0 = dly190i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly190q[(currentdly)*width-1-:16];
		end
	32'd191:begin
		 adc_data_i0 = dly191i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly191q[(currentdly)*width-1-:16];
		end
	32'd192:begin
		 adc_data_i0 = dly192i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly192q[(currentdly)*width-1-:16];
		end
	32'd193:begin
		 adc_data_i0 = dly193i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly193q[(currentdly)*width-1-:16];
		end
	32'd194:begin
		 adc_data_i0 = dly194i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly194q[(currentdly)*width-1-:16];
		end
	32'd195:begin
		 adc_data_i0 = dly195i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly195q[(currentdly)*width-1-:16];
		end
	32'd196:begin
		 adc_data_i0 = dly196i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly196q[(currentdly)*width-1-:16];
		end
	32'd197:begin
		 adc_data_i0 = dly197i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly197q[(currentdly)*width-1-:16];
		end
	32'd198:begin
		 adc_data_i0 = dly198i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly198q[(currentdly)*width-1-:16];
		end
	32'd199:begin
		 adc_data_i0 = dly199i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly199q[(currentdly)*width-1-:16];
		end
	32'd200:begin
		 adc_data_i0 = dly200i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly200q[(currentdly)*width-1-:16];
		end*/
	default:begin
		 adc_data_i0 = dly10i[(currentdly)*width-1-:16];
		 adc_data_q0 = dly10q[(currentdly)*width-1-:16];
		end
	endcase
end


endmodule
