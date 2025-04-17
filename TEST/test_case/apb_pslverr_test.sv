/////////////////////////////////////////////////////////////////
//  file name   : apb_pslverr_test.sv
//  module name : apb_pslverr_test
//////////////////////////////////////////////////////////////////

`ifndef APB_PSLVERR_TEST
`define APB_PSLVERR_TEST

class apb_pslverr_test extends apb_base_test;
  
  // Factory registration
  `uvm_component_utils(apb_pslverr_test)

  // Sequence handles
  apb_wr_rd_sequence m_wr_rd_seq_h;
  apb_slv_sequence s_seq_h;

  // Callback class handle
  apb_slv_drv_cb cb_h;
  static int count;
  
  // Constructor 
  extern function new(string name = "apb_pslverr_test", uvm_component parent = null);

  // Run Phase 
  extern task run_phase(uvm_phase phase);

endclass : apb_pslverr_test

// Constructor 
function apb_pslverr_test::new(string name = "apb_pslverr_test", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Run Phase Task
task apb_pslverr_test::run_phase(uvm_phase phase);
  m_wr_rd_seq_h = apb_wr_rd_sequence::type_id::create("m_wr_rd_seq_h");
  cb_h = apb_slv_drv_cb::type_id::create("cb_h");

  void'(m_wr_rd_seq_h.randomize() with { m_wr_rd_seq_h.itr == 15; }); 
  fork 
    repeat (10) begin
      #10;
      count++;
    end
    // Create and configure callback
    wait(count == 10) begin
      cb_h.inject_err = 1;
      uvm_callbacks#(apb_slv_driver, apb_slv_drv_cb)::add(env_h.s_agnt_h[0].s_drv_h, cb_h);
    end
  join_none
  
  // Register callback on slave driver
  fork begin
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
