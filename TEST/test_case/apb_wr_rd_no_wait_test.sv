/////////////////////////////////////////////////////////////////
//  file name   : apb_wr_rd_no_wait_test.sv
//  module name : apb_wr_rd_no_wait_test
//////////////////////////////////////////////////////////////////

`ifndef APB_WR_RD_NO_WAIT_TEST
`define APB_WR_RD_NO_WAIT_TEST

class apb_wr_rd_no_wait_test extends apb_base_test;
  
  // Factory registration
  `uvm_component_utils(apb_wr_rd_no_wait_test)
  
  // APB SEQUENCES
  apb_wr_rd_sequence m_wr_rd_seq_h;
  apb_slv_sequence s_seq_h;
  
  // Constructor 
  extern function new(string name = "apb_wr_rd_no_wait_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : apb_wr_rd_no_wait_test

// Constructor 
function apb_wr_rd_no_wait_test::new(string name = "apb_wr_rd_no_wait_test", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// Run Phase Task
task apb_wr_rd_no_wait_test::run_phase(uvm_phase phase);
  m_wr_rd_seq_h = apb_wr_rd_sequence::type_id::create("m_wr_rd_seq_h");

  void'(m_wr_rd_seq_h.randomize() with { m_wr_rd_seq_h.itr == 5; });

  fork 
    begin
      uvm_test_done.raise_objection(this);
      m_wr_rd_seq_h.start(env_h.m_agnt_h[0].m_sequencer_h);
      uvm_test_done.drop_objection(this);
	end
    foreach (env_h.s_agnt_h[i]) begin
      automatic int idx = i;  // Required to avoid loop variable issues in fork
      fork
        s_seq_h = apb_slv_sequence::type_id::create($sformatf("s_seq_h[%0d]", idx));
        s_seq_h.start(env_h.s_agnt_h[idx].s_sequencer_h);
      join_none
    end
  join

endtask

`endif
