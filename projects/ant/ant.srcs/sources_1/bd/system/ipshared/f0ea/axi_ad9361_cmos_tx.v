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
reg [31:0] maxdelaytime_temp = 61440000/1000;//max delay 1ms
reg [31:0] capturetimes_temp = 20000;//雷达信号捕获次数  1s
reg [31:0] Countdowntime_temp = 10*61440000;//倒计时间
reg  [31:0]  wavelength_temp = 3072;//雷达信号捕获50us
reg  isContinuouslaunch_temp = 0;


reg [31:0] maxdelaytime = 61440000/1000;//max delay 1ms
reg [31:0] capturetimes = 20000;//雷达信号捕获次数  1s
reg [31:0] Countdowntime = 5*61440000;//倒计时间
reg  [31:0]  wavelength = 3072;//雷达信号捕获50us
reg [width-1:0] datafifoAi [61440000/10000-1:0];//1ms  sample period 1/61440000
reg [width-1:0] datafifoAq [61440000/10000-1:0];
reg [width-1:0] datafifoBi [61440000/10000-1:0];//1ms
reg [width-1:0] datafifoBq [61440000/10000-1:0];
reg  isContinuouslaunch = 0;
reg [31:0] countnumA=0;
reg [31:0] countnumB=0;
reg [31:0] countnumC=0;
reg [31:0] countcaclutimes = 0;
reg [31:0] avgappitudeA= 0;
reg [31:0] avgappitudeB= 0;
reg [31:0]countsendtime =0;
reg [31:0]countdelaytime = 0;
reg [4:0] idle = 0;


//up_axi
wire          up_clk;
wire          up_rreq_s;
wire  [7:0]   up_raddr_s;
wire          up_wreq_s;
wire  [7:0]   up_waddr_s;
wire  [31:0]  up_wdata_s;

reg           up_wack = 'd0;
reg   [31:0]  up_rdata = 'd0;
reg           up_rack = 'd0;
reg           up_resetn = 1'b0;
/*延迟采样法
//此方法主要针对多位宽的数据传输。

例如当两个异步时钟频率比为 5 时，可以先用延迟打拍的方法对数据使能信号进行 2 级打拍缓存，然后再在快时钟域对慢时钟域的数据信号进行采集。

该方法的基本思想是保证信号被安全采集的时刻，而不用同步多位宽的数据信号，可节省部分硬件资源。
*/
always @(posedge clk) begin
	maxdelaytime <= maxdelaytime_temp;//max delay 
	capturetimes <= capturetimes_temp;//雷达信号捕获次数  
	Countdowntime <= Countdowntime_temp;//倒计时间
	wavelength <= wavelength_temp;//雷达信号捕获
	isContinuouslaunch <= isContinuouslaunch_temp;
end
wire m_axis_dout_tvalid;
wire [31 : 0] m_axis_dout_tdata;
wire [31 : 0] s_axis_cartesian_tdata;
wire [15:0] adc_data_i_Q;
wire [15:0] adc_data_q_Q;
assign s_axis_cartesian_tdata = {adc_data_i,adc_data_q};
//delay iq  17 period
ram_shift_reg0 instance_i (
  .D(adc_data_i),      // input wire [15 : 0] D
  .CLK(clk),  // input wire CLK
  .Q(adc_data_i_Q)      // output wire [15 : 0] Q
);
ram_shift_reg0 instance_q (
  .D(adc_data_q),      // input wire [15 : 0] D
  .CLK(clk),  // input wire CLK
  .Q(adc_data_q_Q)      // output wire [15 : 0] Q
);
// iq mod
cordic_0 instance_modapt (
  .aclk(clk),
  .s_axis_cartesian_tvalid(1'b1),  // input wire s_axis_cartesian_tvalid
  .s_axis_cartesian_tdata(s_axis_cartesian_tdata),    // input wire [31 : 0] s_axis_cartesian_tdata
  .m_axis_dout_tvalid(m_axis_dout_tvalid),            // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(m_axis_dout_tdata)              // output wire [31 : 0] m_axis_dout_tdata
);
ila_1 instance_ila_1 (
	.clk(clk), // input wire clk

	.probe0(maxdelaytime), // input wire [31:0]  probe0  
	.probe1(capturetimes), // input wire [31:0]  probe1 
	.probe2(Countdowntime), // input wire [31:0]  probe2 
	.probe3(wavelength), // input wire [31:0]  probe3 
	.probe4(idle),
	.probe5(countnumA),
	.probe6(countnumB),
	.probe7(countcaclutimes),
	.probe8(countsendtime),
	.probe9(countdelaytime),
	.probe10(avgappitudeA),
	.probe11(avgappitudeB),
	.probe12(adc_data_i0),
	.probe13(adc_data_q0),
	.probe14(isContinuouslaunch) // input wire [0:0]  probe4 
);
assign up_clk = s_axi_aclk;
up_axi #(
  .AXI_ADDRESS_WIDTH(10))
i_up_axi (
  .up_rstn (s_axi_aresetn),
  .up_clk (up_clk),
  .up_axi_awvalid (s_axi_awvalid),
  .up_axi_awaddr (s_axi_awaddr),
  .up_axi_awready (s_axi_awready),
  .up_axi_wvalid (s_axi_wvalid),
  .up_axi_wdata (s_axi_wdata),
  .up_axi_wstrb (s_axi_wstrb),
  .up_axi_wready (s_axi_wready),
  .up_axi_bvalid (s_axi_bvalid),
  .up_axi_bresp (s_axi_bresp),
  .up_axi_bready (s_axi_bready),
  .up_axi_arvalid (s_axi_arvalid),
  .up_axi_araddr (s_axi_araddr),
  .up_axi_arready (s_axi_arready),
  .up_axi_rvalid (s_axi_rvalid),
  .up_axi_rresp (s_axi_rresp),
  .up_axi_rdata (s_axi_rdata),
  .up_axi_rready (s_axi_rready),
  .up_wreq (up_wreq_s),
  .up_waddr (up_waddr_s),
  .up_wdata (up_wdata_s),
  .up_wack (up_wack),
  .up_rreq (up_rreq_s),
  .up_raddr (up_raddr_s),
  .up_rdata (up_rdata),
  .up_rack (up_rack));
//axi registers write
always @(posedge up_clk) begin
  if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h00)) begin
      wavelength_temp <= up_wdata_s;
    end
 if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h01)) begin
      capturetimes_temp <= up_wdata_s;
    end
	if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h02)) begin
      Countdowntime_temp <= up_wdata_s;
    end
	if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h03)) begin
      maxdelaytime_temp <= up_wdata_s;
    end
	if ((up_wreq_s == 1'b1) && (up_waddr_s == 8'h04)) begin
        isContinuouslaunch_temp <= up_wdata_s[0:0];
    end	
end
//writing reset
always @(posedge up_clk) begin
  if (s_axi_aresetn == 1'b0) begin
    up_wack <= 'd0;
    up_resetn <= 1'd0;
  end else begin
    up_wack <= up_wreq_s;
    up_resetn <= 1'd1;
  end
end

always@(posedge clk)
begin
case (idle)
    5'd0:begin
			idle <= 1;
			countnumA <= 0;
			countnumB <= 0;
			countcaclutimes <= 0;
			avgappitudeA <= 0;
			avgappitudeB <= 0;
			adc_data_i0<= 0;
			adc_data_q0<= 0;
			countsendtime <= 0;
			countdelaytime <= 0;
	end
	5'd1:begin
	 countnumA <=countnumA+1;
	 if(countnumA<wavelength)
		begin
			datafifoAi[countnumA] <= adc_data_i_Q;
			datafifoAq[countnumA] <= adc_data_q_Q;
			avgappitudeA <= avgappitudeA+m_axis_dout_tdata[15:0];
			adc_data_i0<= 0;
			adc_data_q0<= 0;
		end
	 	else
		begin
			
			countnumA <= 0;
			idle <=3;
			countnumB <= 0;
			countcaclutimes <=countcaclutimes+1;
		end
    end
	5'd2:begin
	 countnumB <=countnumB+1;
	 if(countnumB<wavelength)
		begin
			datafifoBi[countnumB] <= adc_data_i_Q;
			datafifoBq[countnumB] <= adc_data_q_Q;
			adc_data_i0<= 0;
			adc_data_q0<= 0;
			avgappitudeB <= avgappitudeB+m_axis_dout_tdata[15:0];
		end
	 	else
		begin
			countnumB <= 0;
			idle <=3;
			countcaclutimes <=countcaclutimes+1;	
		end
	end
    	
	5'd3: begin
		if(countcaclutimes<capturetimes)
		begin
			if(avgappitudeA>avgappitudeB)
			begin	
				idle <=2;
				avgappitudeB <= 0;
			end
			else
				begin
					idle <=1;
					avgappitudeA <= 0;
				end
		end
		else begin
		countsendtime <= 0;
		countdelaytime<= 0;
			if(avgappitudeA>avgappitudeB)
				idle <=4;
			else
					idle <=5;
			 end

	end
	5'd4: begin
		countsendtime <= countsendtime+1;
		countdelaytime <= countdelaytime+1;
		if(countsendtime < Countdowntime) begin
			if(countdelaytime< maxdelaytime)begin
				if(countdelaytime<wavelength)begin
				adc_data_i0<= datafifoAi[countdelaytime];
				adc_data_q0<= datafifoAq[countdelaytime];
				end
				else begin
						adc_data_i0<= 0;
						adc_data_q0<= 0;
				end
			end
			else 
					countdelaytime <= 0;
			end
			else begin
			 if(isContinuouslaunch != 1) begin
			idle <=0;
			countsendtime <= 0;
			countdelaytime <= 0; 
			end else begin
				countsendtime <= 0;
			end
			end
	end
	5'd5:begin
		countsendtime <= countsendtime+1;
		countdelaytime <= countdelaytime+1;
		if(countsendtime < Countdowntime) begin
			if(countdelaytime< maxdelaytime)begin
				if(countdelaytime<wavelength)begin
				adc_data_i0<= datafifoBi[countdelaytime];
				adc_data_q0<= datafifoBq[countdelaytime];
				end
				else begin
						adc_data_i0<= 0;
						adc_data_q0<= 0;
				end
			end
			else 
					countdelaytime <= 0;
			end
			else begin
			if(isContinuouslaunch != 1) begin
			idle <=0;
			countsendtime <= 0;
			countdelaytime <= 0; 
			end else begin
				countsendtime <= 0;
			end
			end

	end
 	default:begin
           idle <=0;
        end
	endcase
end
endmodule
