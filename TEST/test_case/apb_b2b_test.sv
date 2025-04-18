/////////////////////////////////////////////////////////////////
//  file name   : apb_b2b_test.sv
//  module name : apb_b2b_test
//////////////////////////////////////////////////////////////////

`ifndef APB_B2B_TEST
`define APB_B2B_TEST

class apb_b2b_test extends apb_base_test;
  
  // Factory Registration
  `uvm_component_utils(apb_b2b_test)
  
  // APB SEQUENCES
  apb_b2b_sequence m_b2b_seq_h;
  apb_slv_sequence s_seq_h;

  // Constructor 
  extern function new(string name = "apb_b2b_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : apb_b2b_test

// Constructor 
function apb_b2b_test::new(string name = "apb_b2b_test", uvm_component parent = null);
  super.new(name, parent);
endfunction 
  
// Run Phase Task
task apb_b2b_test::run_phase(uvm_phase phase);
  
  m_b2b_seq_h = apb_b2b_sequence::type_id::create("m_b2b_seq_h");
  s_seq_h = apb_slv_sequence::type_id::create("s_seq_h");
  
  void'(m_b2b_seq_h.randomize() with { m_b2b_seq_h.itr == 25; });
  
  fork 
    begin
      uvm_test_done.raise_objection(this);
      m_b2b_seq_h.start(env_h.m_agnt_h[0].m_sequencer_h);  
	 uvm_test_done.drop_objection(this);
    end
    foreach (env_h.s_agnt_h[i]) begin
      if(env_h.s_cfg_h[i].is_active==UVM_ACTIVE) begin
        automatic int idx = i;  // Required to avoid loop variable issues in fork
        fork
          s_seq_h = apb_slv_sequence::type_id::create($sformatf("s_seq_h[%0d]", idx));
          s_seq_h.start(env_h.s_agnt_h[idx].s_sequencer_h);
        join_none
      end  
    end
  join
endtask

`endif
