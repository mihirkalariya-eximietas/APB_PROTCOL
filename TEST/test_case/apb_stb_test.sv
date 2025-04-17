/////////////////////////////////////////////////////////////////
//  file name   : apb_stb_test.sv
//  module name : apb_stb_test
//////////////////////////////////////////////////////////////////

`ifndef APB_STB_TEST
`define APB_STB_TEST

class apb_stb_test extends apb_base_test;
  
  // Factory registration
  `uvm_component_utils(apb_stb_test)
  
  // APB SEQUENCES
  apb_wr_sequence w_seq_h;
  apb_rd_sequence rd_seq_h;

  // Constructor 
  extern function new(string name = "apb_stb_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : apb_stb_test

// Constructor 
function apb_stb_test::new(string name = "apb_stb_test", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// Run Phase Task
task apb_stb_test::run_phase(uvm_phase phase);

  w_seq_h = apb_wr_sequence::type_id::create("w_seq_h");
  rd_seq_h = apb_rd_sequence::type_id::create("rd_seq_h");

  void'(w_seq_h.randomize() with { w_seq_h.itr == 5; });
  
  fork begin
	uvm_test_done.raise_objection(this);
    w_seq_h.start(env_h.m_agnt_h[0].m_sequencer_h);	  
	#20;
	uvm_test_done.drop_objection(this);
  end
	rd_seq_h.start(env_h.s_agnt_h[0].s_sequencer_h);	  
  join

endtask

`endif
