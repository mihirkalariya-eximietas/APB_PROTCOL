/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_config.sv
//  module name : apb slvTER CONFIG CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_SLV_CONFIG_SV
`define APB_SLV_CONFIG_SV

class apb_slv_config extends uvm_object;

  // To set apb slvter agent mode i.e. ACTIVE, PASSIVE
  uvm_active_passive_enum is_active = UVM_ACTIVE;  // by default it is active 

  // Factory Registration
  `uvm_object_utils_begin(apb_slv_config)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end

  // extern function declaration outside class
  extern function new(string name = "apb_slv_config");

endclass

// Function definition outside class in the same file
function apb_slv_config::new(string name = "apb_slv_config");
  super.new(name);
endfunction

`endif
