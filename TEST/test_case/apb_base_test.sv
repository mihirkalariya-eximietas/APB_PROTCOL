/////////////////////////////////////////////////////////////////
//  file name   : apb_base_test.sv
//  module name : apb_base_test
//////////////////////////////////////////////////////////////////

`ifndef APB_BASE_TEST_SV
`define APB_BASE_TEST_SV

class apb_base_test extends uvm_test;
  
  // Factory Registration
  `uvm_component_utils(apb_base_test)
  
  // APB SEQUENCES
  apb_env env_h;
  apb_master_base_sequence msq_h;
  apb_slv_base_sequence ssq_h;

  // Constructor 
  extern function new(string name = "apb_base_test", uvm_component parent = null);

  // Build Phase
  extern function void build_phase(uvm_phase phase);

  // Start of Simulation
  extern function void start_of_simulation();

endclass : apb_base_test

// Constructor 
function apb_base_test::new(string name = "apb_base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction
  
// Build Phase 
function void apb_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  env_h = apb_env::type_id::create("env_h", this);
  msq_h = apb_master_base_sequence::type_id::create("msq_h");
  ssq_h = apb_slv_base_sequence::type_id::create("ssq_h");
endfunction

// Start of Simulation 
function void apb_base_test::start_of_simulation();
  super.start_of_simulation(); 
  uvm_top.print_topology();
endfunction

`endif
