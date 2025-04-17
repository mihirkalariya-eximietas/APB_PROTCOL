/////////////////////////////////////////////////////////////////
//  file name   : apb_env_pkg.sv
//  module name : apb ENV PKG
//////////////////////////////////////////////////////////////////

`ifndef APB_ENV_PKG_SV
`define APB_ENV_PKG_SV

package apb_env_pkg;
  
  // Event for read done signal

  import uvm_pkg::*;

  `include "uvm_macros.svh"
  
  `include "apb_define.sv"
  `include "apb_seq_item.sv"
  
  `include "apb_master_config.sv"
  `include "apb_master_driver.sv"
  `include "apb_master_sequencer.sv"
  `include "apb_master_mon.sv"
  `include "apb_master_agent.sv"
  `include "apb_master_base_sequence.sv"
  
  `include "apb_slv_config.sv"
  `include "apb_slv_drv_cb.sv"
  `include "apb_slv_driver.sv"
  `include "apb_slv_sequencer.sv"
  `include "apb_slv_mon.sv"
  `include "apb_slv_agent.sv"
  `include "apb_slv_base_sequence.sv"
  
  `include "apb_env_config.sv"
  `include "apb_scoreboard.sv"
  `include "apb_env.sv"
  
endpackage

`endif
