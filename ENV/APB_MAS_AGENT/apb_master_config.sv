/////////////////////////////////////////////////////////////////
//  File Name   : apb_master_config.sv
//  Module Name : APB MASTER CONFIG CLASS
/////////////////////////////////////////////////////////////////

`ifndef apb_MAS_CONFIG_SV
`define apb_MAS_CONFIG_SV

class apb_master_config extends uvm_object;

  // To set apb Master agent mode i.e. ACTIVE, PASSIVE
  uvm_active_passive_enum is_active = UVM_ACTIVE;  // by default it is active

  // factory registration
  `uvm_object_utils_begin(apb_master_config)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  // constructor
  extern function new(string name = "apb_master_config");

endclass

// constructor
function apb_master_config::new(string name = "apb_master_config");
  super.new(name);
endfunction

`endif
