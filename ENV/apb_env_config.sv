/////////////////////////////////////////////////////////////////
//  file name   : apb_env_config.sv
//  module name : apb ENV CONFIG CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_ENV_CONFIG_SV
`define APB_ENV_CONFIG_SV

class apb_env_config extends uvm_object;

  // To set No of apb Master Agent
  int no_of_master_agents = 1;
  int no_of_slave_agents= 4;

  // Factory Registration
  `uvm_object_utils_begin(apb_env_config)
    `uvm_field_int(no_of_master_agents , UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(no_of_slave_agents , UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  // extern constructor declaration
  extern function new(string name = "apb_env_config");

endclass

// Constructor definition 
function apb_env_config::new(string name = "apb_env_config");
  super.new(name);
endfunction

`endif
