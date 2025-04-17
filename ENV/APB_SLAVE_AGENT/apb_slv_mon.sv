`ifndef APB_SLV_MON_SV
`define APB_SLV_MON_SV

class apb_slv_monitor extends uvm_monitor;

  // Factory Registration
  `uvm_component_utils(apb_slv_monitor)

  // Handles for transaction
  apb_seq_item req, req_sample;

  // Virtual Interface
  virtual apb_if s_vif;

  // Analysis Ports
  uvm_analysis_port #(apb_seq_item) slv_mon_port;
  uvm_analysis_port #(apb_seq_item) req_aport;

  // Coverage group instance
  covergroup cg_inst;
    PADDR_CP : coverpoint req.PADDR {
	 bins low_range    = {[32'h00000000 : 32'hFFFFFFFF]};
	}

    PWDATA_CP : coverpoint req.PWDATA {
      bins low_range    = {[32'h00000000 : 32'h55555554]};
      bins mid_range    = {[32'h55555555 : 32'hAAAAAAAA]};
      bins high_range   = {[32'hAAAAAAAB : 32'hFFFFFFFF]};
      bins corner_range = {32'h00000000, 32'hFFFFFFFF};
    }

    PRDATA_CP : coverpoint req.PRDATA {
      bins low_range    = {[32'h00000000 : 32'h55555554]};
      bins mid_range    = {[32'h55555555 : 32'hAAAAAAAA]};
      bins high_range   = {[32'hAAAAAAAB : 32'hFFFFFFFF]};
      bins corner_range = {32'h00000000, 32'hFFFFFFFF};
    }

    PWRITE_CP : coverpoint req.PWRITE {
      bins write        = {1};
      bins read         = {0};
      bins b2b          = (1 => 0 => 1 => 0);
      bins con_write    = (1 => 1 => 1 => 1 => 1 => 1);
      bins con_read     = (0 => 0 => 0 => 0 => 0 => 0);
    }

    COV5: cross PADDR_CP, PWDATA_CP, PWRITE_CP {
      ignore_bins read_related     = binsof(PWRITE_CP.read);
      ignore_bins con_read_related = binsof(PWRITE_CP.con_read);
    }

    COV6: cross PADDR_CP, PRDATA_CP, PWRITE_CP {
      ignore_bins write_related     = binsof(PWRITE_CP.write);
      ignore_bins con_write_related = binsof(PWRITE_CP.con_write);
    }

    PSTRB_CP : coverpoint req.PSTRB {
	  bins pstrb_range[] = {[0:15]};
	}

    PSLVERR_CP : coverpoint req.PSLVERR {
      bins bins_1 = {0, 1};
    }
  endgroup

  extern function new(string name = "apb_slv_monitor", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task sample();
  extern task slv_monitor();

endclass : apb_slv_monitor

  // Constructor
function apb_slv_monitor::new(string name = "apb_slv_monitor", uvm_component parent = null);
  super.new(name, parent);
  slv_mon_port = new("slv_mon_port", this);
  req_aport = new("req_aport", this);
  cg_inst = new(); // coverage group instantiation
endfunction

  // Build phase
function void apb_slv_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  req = apb_seq_item::type_id::create("req");
  req_sample = apb_seq_item::type_id::create("req_sample");
endfunction

  // Run phase
task apb_slv_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  wait(s_vif.RESETn);
  forever begin
    sample();      // collect fields to sample
    cg_inst.sample();  // sample coverage group
    slv_monitor(); // push transaction to scoreboard
  end
endtask

  // Sample task
task apb_slv_monitor::sample();
  wait(s_vif.PSLEx);
  req_sample.PENABLE = s_vif.PENABLE;
  req_sample.PREADY  = s_vif.PREADY;
  req_sample.PADDR   = s_vif.PADDR;
  req_sample.PSTRB   = s_vif.PSTRB;
  req_sample.PWRITE  = s_vif.PWRITE;
  req_sample.PWDATA  = s_vif.PWDATA;
  req_aport.write(req_sample);
endtask

  // Monitor task
task apb_slv_monitor::slv_monitor();
  wait(s_vif.PSLEx && s_vif.PENABLE && s_vif.PREADY);
  req.PWRITE = s_vif.PWRITE;
  req.PADDR  = s_vif.PADDR;
  req.PSTRB  = s_vif.PSTRB;
  req.PREADY = s_vif.PREADY;
  req.PSLVERR = s_vif.PSLVERR;

  if (s_vif.PWRITE) begin
    req.PWDATA = s_vif.PWDATA;
    req.PRDATA = 'b0;
  end else begin
    req.PWDATA = 'b0;
    @(negedge s_vif.PCLK);
    req.PRDATA = s_vif.PRDATA;
  end
  
  slv_mon_port.write(req);
  wait(s_vif.PENABLE == 0);
endtask

`endif
