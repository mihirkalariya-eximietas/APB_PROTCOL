/////////////////////////////////////////////////////////////////
//  File Name   : apb_master_agent.sv 
//  Module Name : APB MASTER AGENT CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_MAS_AGENT_SV
`define APB_MAS_AGENT_SV

class apb_master_agent extends uvm_agent;

  // masterter config handle
  apb_master_config m_cfg_h;

  `uvm_component_utils(apb_master_agent)

  // virtual interface
  virtual apb_if m_vif;

  // component handles
  apb_master_driver m_drv_h;
  apb_master_sequencer m_sequencer_h;
  apb_master_monitor m_mon_h;

  // constructor
  extern function new(string name = "", uvm_component parent = null);

  // build phase - create/configure components and get interfaces
  extern function void build_phase(uvm_phase phase);

  // connect phase - hook up sequencer, driver, and monitor
  extern function void connect_phase(uvm_phase phase);

endclass : apb_master_agent

// constructor
function apb_master_agent::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase - create/configure components and get interfaces
function void apb_master_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  m_cfg_h = apb_master_config::type_id::create("m_cfg_h", this);

  if (!uvm_config_db #(apb_master_config)::get(this, "", "master_config", m_cfg_h))
    `uvm_fatal("AGENT_CONFIG_GET", "Master config is not available")

  if (m_cfg_h.is_active == UVM_ACTIVE) begin
    m_drv_h = apb_master_driver::type_id::create("m_drv_h", this);
    m_sequencer_h = apb_master_sequencer::type_id::create("m_sequencer_h", this);
  end

  m_mon_h = apb_master_monitor::type_id::create("m_mon_h", this);

  if (!uvm_config_db #(virtual apb_if)::get(this, "", "m_vif", m_vif))
    `uvm_fatal("AGNET_VIRTUAL_INTERFACE", "Master Interface is not available")
endfunction

// connect phase - hook up sequencer, driver, and monitor
function void apb_master_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if (m_cfg_h.is_active == UVM_ACTIVE) begin
    m_drv_h.seq_item_port.connect(m_sequencer_h.seq_item_export);
    m_drv_h.m_vif = this.m_vif;
  end

  m_mon_h.m_vif = this.m_vif;
endfunction

`endif
