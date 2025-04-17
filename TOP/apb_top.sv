/////////////////////////////////////////////////////////////////
//  file name   : apb_top.sv
//  module name : apb_TOP
//////////////////////////////////////////////////////////////////

module apb_tb_top();

  import uvm_pkg::*;
  import apb_test_pkg::*;

  bit clk;

  // Clock generation
  initial begin
    forever begin 
      #5 clk = ~clk;
    end
  end
 
  // Interface instance
  apb_if m_vif(clk);
  apb_if s_vif[4](clk);
  
 // Interconnect signals
  logic [3:0] psel;
  logic [3:0] pready_slv;
  logic [3:0][31:0] prdata_slv;
  logic [3:0] pslverr_slv;

  logic [31:0] prdata;
  logic pslverr;
  logic pready;

  // DUT: Interconnect instance
  apb_interconnect interconnect_inst (
    .PADDR     (m_vif.PADDR),
    .PWRITE    (m_vif.PWRITE),
    .PENABLE   (m_vif.PENABLE),
    .PWDATA    (m_vif.PWDATA),
    .PSLE      (psel),
    .PREADY_SLV(pready_slv),
    .PSLVERR_SLV(pslverr_slv),
    .PRDATA_SLV(prdata_slv),
    .PRDATA    (prdata),
    .PSLVERR   (pslverr),
    .PREADY    (pready)
  );

  // Connect interconnect outputs to master
  assign m_vif.PRDATA  = prdata;
  assign m_vif.PREADY  = pready;
  assign m_vif.PSLVERR = pslverr;

  // Connect interconnect selects to slave PSLE signals
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin
      assign s_vif[i].PSLEx    = psel[i];
      assign pready_slv[i]    = s_vif[i].PREADY;
      assign prdata_slv[i]    = s_vif[i].PRDATA;
      assign pslverr_slv[i]   = s_vif[i].PSLVERR;

      // Drive master signals into each slave
      assign s_vif[i].PADDR   = m_vif.PADDR;
      assign s_vif[i].PWRITE  = m_vif.PWRITE;
      assign s_vif[i].PWDATA  = m_vif.PWDATA;
      assign s_vif[i].PENABLE = m_vif.PENABLE;
      assign s_vif[i].PSTRB   = m_vif.PSTRB;
      assign s_vif[i].PCLK    = m_vif.PCLK;
      assign s_vif[i].RESETn  = m_vif.RESETn;
    end
  endgenerate 

  // Reset assert task
  task reset_assert();
    @(posedge m_vif.PCLK);
    m_vif.RESETn = 1'b0;
    @(posedge m_vif.PCLK);
    @(posedge m_vif.PCLK);
    m_vif.RESETn = 1'b1;
  endtask

  // Initial reset assertion
  initial begin
    reset_assert();
  end
  
  initial begin
    uvm_config_db #(virtual apb_if)::set(null, "*", "m_vif", m_vif);
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env_h.s_agnt_h[0]", "s_vif", s_vif[0]);
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env_h.s_agnt_h[1]", "s_vif", s_vif[1]);
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env_h.s_agnt_h[2]", "s_vif", s_vif[2]);
    uvm_config_db#(virtual apb_if)::set(null, "uvm_test_top.env_h.s_agnt_h[3]", "s_vif", s_vif[3]);
  end

  // UVM Configuration and Test Run
  initial begin
    uvm_top.set_report_verbosity_level(UVM_NONE);
    run_test("apb_wr_rd_no_wait_test");
    //run_test("apb_wr_rd_wait_test");
    //run_test("apb_b2b_test");
    //run_test("apb_random_test");
    //run_test("apb_ibr_test");
    //run_test("apb_pslverr_test");
    //run_test("apb_wr_nowait_rd_wait_test");
    //run_test("apb_wr_wait_rd_nowait_test");
  end
 
endmodule
