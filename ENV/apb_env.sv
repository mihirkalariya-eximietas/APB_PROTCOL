/////////////////////////////////////////////////////////////////
//  file name   : apb_env.sv
//  module name : apb ENV CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_ENV_SV
`define APB_ENV_SV

`include "apb_env_config.sv"

class apb_env extends uvm_env;

  //-------factory registration
  `uvm_component_utils(apb_env)

  //------ENV CONFIG
  apb_env_config env_cfg;

  //------MASTER CONFIG & AGENT HANDLES
  apb_master_config m_cfg_h[];
  apb_master_agent m_agnt_h[];

  //------SLAVE CONFIG & AGENT HANDLES
  apb_slv_config s_cfg_h[];
  apb_slv_agent s_agnt_h[];
  apb_scoreboard scr_h;

  //-------constructor 
  function new(string name = "apb_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //-------build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create and set environment configuration
    env_cfg = apb_env_config::type_id::create("env_cfg");
          
    scr_h = apb_scoreboard::type_id::create("scr_h",this);

    //=============================
    //  MASTER UVC IMPLEMENTATION
    //=============================
    m_cfg_h = new[env_cfg.no_of_master_agents];
    m_agnt_h = new[env_cfg.no_of_master_agents];

    foreach (m_cfg_h[i]) begin
	 m_cfg_h[i] = apb_master_config::type_id::create($sformatf("m_cfg_h[%0d]", i));
	 m_cfg_h[i].is_active = UVM_ACTIVE; // Master UVC is always active
	 m_agnt_h[i] = apb_master_agent::type_id::create($sformatf("m_agnt_h[%0d]", i), this);
	 uvm_config_db #(apb_master_config)::set(this, $sformatf("m_agnt_h[%0d]*", i), "master_config", m_cfg_h[i]);
    end

    //=============================
    //  SLAVE UVC IMPLEMENTATION
    //=============================
    s_cfg_h = new[env_cfg.no_of_slave_agents];
    s_agnt_h = new[env_cfg.no_of_slave_agents];

    foreach (s_cfg_h[i]) begin
	 s_cfg_h[i] = apb_slv_config::type_id::create($sformatf("s_cfg_h[%0d]", i));
	 if (i < 4)
        m_cfg_h[i].is_active = UVM_ACTIVE;
      else
        m_cfg_h[i].is_active = UVM_PASSIVE; // Active Slave Agent
	 s_agnt_h[i] = apb_slv_agent::type_id::create($sformatf("s_agnt_h[%0d]", i), this);
	 uvm_config_db #(apb_slv_config)::set(this, $sformatf("s_agnt_h[%0d]*", i), "slv_config", s_cfg_h[i]);
    end

  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_agnt_h[0].m_mon_h.master_mon_port.connect(scr_h.master_mon_imp);
    foreach(s_cfg_h[i]) begin
      s_agnt_h[i].s_mon_h.slv_mon_port.connect(scr_h.slv_mon_imp);  
    end
  endfunction

endclass : apb_env

`endif
