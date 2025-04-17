/////////////////////////////////////////////////////////////////
//  file name   : wr_rd_all_memory_test.sv
//  module name : wr_rd_all_memory_test
//////////////////////////////////////////////////////////////////

`ifndef WR_RD_ALL_MEMORY_TEST
`define WR_RD_ALL_MEMORY_TEST

class wr_rd_all_memory_test extends apb_base_test;
  
  // Factory registration
  `uvm_component_utils(wr_rd_all_memory_test)
  
  // APB SEQUENCES
  wr_rd_all_memory_sequence wsq_h;
  apb_rd_sequence rsq_h;
  
  // Constructor 
  extern function new(string name = "wr_rd_all_memory_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : wr_rd_all_memory_test

// Constructor 
function wr_rd_all_memory_test::new(string name = "wr_rd_all_memory_test", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// Run Phase Task
task wr_rd_all_memory_test::run_phase(uvm_phase phase);
  wsq_h = wr_rd_all_memory_sequence::type_id::create("wsq_h");
  rsq_h = apb_rd_sequence::type_id::create("rsq_h");

  // void'(wsq_h.randomize() with { wsq_h.itr == 50; });

  fork begin
    uvm_test_done.raise_objection(this);
    wsq_h.start(env_h.m_agnt_h[0].m_sequencer_h);
    #20;
    uvm_test_done.drop_objection(this);
  end
  
  rsq_h.start(env_h.s_agnt_h[0].s_sequencer_h);
  
  join

endtask

`endif
