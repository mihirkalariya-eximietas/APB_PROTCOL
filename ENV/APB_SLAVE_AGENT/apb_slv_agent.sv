/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_agent.sv 
//  module name : apb SLVTER AGENT CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_slv_AGENT_SV
`define APB_slv_AGENT_SV

class apb_slv_agent extends uvm_agent;

  // slvter config handle
  apb_slv_config s_cfg_h;

  // Factory Registration
  `uvm_component_utils(apb_slv_agent)

  // virtual interface
  virtual apb_if s_vif;

  // component handles and config 
  apb_slv_driver s_drv_h;
  apb_slv_sequencer s_sequencer_h;
  apb_slv_monitor s_mon_h;

  // extern function declarations
  extern function new (string name="apb_slv_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

// Definition of the 'new' function outside the class
function apb_slv_agent::new (string name="apb_slv_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Definition of the 'build_phase' function outside the class
function void apb_slv_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create handle of slvter config 
  s_cfg_h = apb_slv_config::type_id::create("s_cfg_h",this);

  // get slvter configuration 
  if(!uvm_config_db #(apb_slv_config)::get(this,"","slv_config",s_cfg_h))
    `uvm_fatal("AGENT_CONFIG_GET","slvter config is not available")

  // if agent is active create driver and sequencer 
  if(s_cfg_h.is_active == UVM_ACTIVE) begin
    s_drv_h = apb_slv_driver::type_id::create("s_drv_h",this);
    s_sequencer_h = apb_slv_sequencer::type_id::create("s_sequencer_h",this);
  end

  // create monitor 
  s_mon_h = apb_slv_monitor::type_id::create("s_mon_h",this);

  // get virtual interface 
  if(!uvm_config_db #(virtual apb_if)::get(this,"","s_vif",s_vif))
    `uvm_fatal("AGNET_VIRTUAL_INTERFACE","slvter Interface is not available")

endfunction

// Definition of the 'connect_phase' function outside the class
function void apb_slv_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  // if slvter agent is active, connect components
  if(s_cfg_h.is_active == UVM_ACTIVE) begin
    s_drv_h.seq_item_port.connect(s_sequencer_h.seq_item_export);
    s_drv_h.s_vif = this.s_vif;
    s_mon_h.req_aport.connect(s_sequencer_h.req_fifo.analysis_export);
  end

  // connect slvter interface with this interface 
  s_mon_h.s_vif = this.s_vif;

endfunction

`endif
