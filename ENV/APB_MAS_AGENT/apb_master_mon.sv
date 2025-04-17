/////////////////////////////////////////////////////////////////
//  File Name   : apb_master_mon.sv
//  Module Name : APB MASTER MONITOR CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_MAS_MON_SV
`define APB_MAS_MON_SV

class apb_master_monitor extends uvm_monitor;

  // Factory registration
  `uvm_component_utils(apb_master_monitor)

  // handle of seq_item (transaction class)
  apb_seq_item req;
  
  // virtual interface declaration
  virtual apb_if m_vif;

  // analysis port declaration
  uvm_analysis_port #(apb_seq_item) master_mon_port;
  
  // Sampled signals
  logic penable_sample, psel_sample, pready_sample, pwrite_sample;
  logic [31:0] pwdata_sample, paddr_sample;
  logic [3:0] pstrb_sample;

  // constructor
  extern function new(string name = "", uvm_component parent = null);

  // build phase - create and configure monitor components
  extern function void build_phase(uvm_phase phase);

  // run phase - continuously monitors the signals for transactions
  extern task run_phase(uvm_phase phase);

  // master monitor task - captures and writes transaction data
  extern task master_monitor();
  
  extern task sample_signals();
  extern task check_idle();
  extern task check_wait_state();
  extern task check_setup2access();
  extern task check_penable_deassertion_after_access();

endclass

// constructor
function apb_master_monitor::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
  master_mon_port = new("master_mon_port", this);
endfunction

// build phase - create and configure monitor components
function void apb_master_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  req = apb_seq_item::type_id::create("req");
endfunction

// run phase - continuously monitors the signals for transactions
task apb_master_monitor::run_phase(uvm_phase phase);
  wait(m_vif.RESETn);
  fork
    sample_signals();       // Background signal sampling
    check_idle();           // Checker tasks
    check_wait_state();
    check_setup2access();
    check_penable_deassertion_after_access();
  join_none
  forever begin
    master_monitor();
  end
endtask

// master monitor task - captures and writes transaction data
task apb_master_monitor::master_monitor();
  // Wait until PREADY and PENABLE are both high
  wait(m_vif.PREADY && m_vif.PENABLE);

  req.PENABLE = m_vif.PENABLE;
  req.PSLEx = m_vif.PSLEx;
  req.PADDR   = m_vif.PADDR;
  req.PWRITE  = m_vif.PWRITE;

  if (m_vif.PWRITE) begin
    req.PWDATA = m_vif.PWDATA;
    req.PSTRB  = m_vif.PSTRB;
    req.PREADY = m_vif.PREADY;
    req.PRDATA = 'b0;
  end else begin
    req.PREADY = m_vif.PREADY;
    req.PWDATA = 'b0;
    @(negedge m_vif.PCLK);
    req.PRDATA = m_vif.PRDATA;
  end  

  `uvm_info(get_type_name(), $sformatf("From Master Mon: \n%s", req.sprint()), UVM_LOW)
  master_mon_port.write(req);

  // Wait for PENABLE deassertion
  wait(m_vif.PENABLE == 0);

endtask

//-----------------------------------checker--------------------------------------------
task apb_master_monitor::sample_signals();
  forever begin
    @(posedge m_vif.PCLK);
    psel_sample   = m_vif.PSLEx;
    penable_sample = m_vif.PENABLE;
    pready_sample  = m_vif.PREADY;
    paddr_sample   = m_vif.PADDR;
    pwrite_sample  = m_vif.PWRITE;
    pwdata_sample  = m_vif.PWDATA;
    pstrb_sample   = m_vif.PSTRB;
  end
endtask

// --------------------------------Idle check ------------------------------
// When PSELx is low, in the same cycle, PENABLE must also be low.
task apb_master_monitor::check_idle();
  forever begin
    @(posedge m_vif.PCLK);
    if (!psel_sample && penable_sample)
      `uvm_error("IDLE_CHECK", "PENABLE should be low when PSELx is low.")
    else
      `uvm_info(get_type_name(),"idle check pass", UVM_LOW)
  end
endtask

// --------------------------Wait state check -------------------------------
// "If PREADY is low in the access phase, the next cycle should remain in the access phase."
task apb_master_monitor::check_wait_state();
  forever begin
    @(posedge m_vif.PCLK);
    if (penable_sample && !pready_sample) begin
      @(posedge m_vif.PCLK);
      if (m_vif.PENABLE == 0)
        `uvm_error("WAIT_CHECK", "Wait state violation detected")
      else
        `uvm_info(get_type_name(),"wait check pass", UVM_LOW)
    end
  end
endtask

// ------------------------Access-to-setup phase signal integrity check---------------------
// "PADDR, PWRITE, PSTRB, and PWDATA values should remain the 
// same during the setup and access phases, including during wait states."
task apb_master_monitor::check_setup2access();
  logic [31:0] temp_pwdata, temp_paddr;
  logic temp_pwrite;
  logic [3:0] temp_pstrb;

  forever begin
    @(posedge m_vif.PCLK);
    if (!penable_sample && psel_sample) begin
      temp_pwdata = pwdata_sample;
      temp_paddr  = paddr_sample;
      temp_pwrite = pwrite_sample;
      temp_pstrb  = pstrb_sample;
      @(posedge m_vif.PCLK);
      if (m_vif.PENABLE && m_vif.PSLEx) begin
        if ((temp_pwdata != m_vif.PWDATA) ||
            (temp_paddr  != m_vif.PADDR) ||
            (temp_pwrite != m_vif.PWRITE) ||
            (temp_pstrb  != m_vif.PSTRB))
          `uvm_error("ACCESS2SETUP", "Setup-to-access signal mismatch")
        else
          `uvm_info(get_type_name(),"access to setup check pass", UVM_LOW)
      end
    end
  end
endtask

//-----------------------------check_penable_deassertion_after_access----------------------
//"In the access phase, if PREADY is high, PENABLE must be zero in the next cycle."
task apb_master_monitor::check_penable_deassertion_after_access();
  forever begin
    @(posedge m_vif.PCLK);
    if (m_vif.PENABLE && m_vif.PREADY) begin
      // Access phase is ending
      @(posedge m_vif.PCLK); // Wait for next cycle
      if (m_vif.PENABLE)
        `uvm_error("PENABLE_DEASSERT", "PENABLE should be deasserted (low) after access phase.")
      else 
        `uvm_info(get_type_name(),"check_penable_deassertion_after_access pass", UVM_LOW)
    end
  end
endtask

`endif
