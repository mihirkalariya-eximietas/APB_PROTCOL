/////////////////////////////////////////////////////////////////
//  file name   : apb_random_test.sv
//  module name : apb_random_test
//////////////////////////////////////////////////////////////////

`ifndef APB_RANDOM_TEST_SV
`define APB_RANDOM_TEST_SV

class apb_random_test extends apb_base_test;
  
  // Factory registration
  `uvm_component_utils(apb_random_test)
  
  // APB SEQUENCES
  apb_random_sequence w_seq_h;
  apb_wait_sequence wait_seq_h;
  
  // Constructor 
  extern function new(string name = "apb_random_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : apb_random_test

// Constructor 
function apb_random_test::new(string name = "apb_random_test", uvm_component parent = null);
  super.new(name, parent);
endfunction 

// Run Phase Task
task apb_random_test::run_phase(uvm_phase phase);
  w_seq_h = apb_random_sequence::type_id::create("w_seq_h");

  void'(w_seq_h.randomize() with { w_seq_h.itr == 1000; });
  fork 
    begin
      uvm_test_done.raise_objection(this);
      w_seq_h.start(env_h.m_agnt_h[0].m_sequencer_h);	  
      uvm_test_done.drop_objection(this);
    end
    foreach (env_h.s_agnt_h[i]) begin
      if(env_h.s_cfg_h[i].is_active==UVM_ACTIVE) begin
        automatic int idx = i;  // Required to avoid loop variable issues in fork
        fork
          wait_seq_h = apb_wait_sequence::type_id::create($sformatf("wait_seq_h[%0d]", idx));
          wait_seq_h.start(env_h.s_agnt_h[idx].s_sequencer_h);
        join_none
      end
    end
  join    

endtask

`endif
