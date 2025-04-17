/////////////////////////////////////////////////////////////////
//  file name   : apb_scoreboard.sv
//  module name : apb SCOREBOARD CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_SCOREBOARD_SV
`define APB_SCOREBOARD_SV

class apb_scoreboard extends uvm_scoreboard;

  // Factory registration
  `uvm_component_utils(apb_scoreboard)
  `uvm_analysis_imp_decl(_master_mon) // Master monitor analysis port
  `uvm_analysis_imp_decl(_slv_mon) // Slave monitor analysis port

  // Analysis port implementation
  uvm_analysis_imp_master_mon#(apb_seq_item, apb_scoreboard) master_mon_imp;
  uvm_analysis_imp_slv_mon#(apb_seq_item, apb_scoreboard) slv_mon_imp;

  apb_seq_item m_pkt_que[$],s_pkt_que[$];
  apb_seq_item m_pkt,s_pkt;
  uvm_comparer cmp; // Create comparer once
  

  // Constructor
  extern function new(string name = "apb_scoreboard", uvm_component parent);

  // Build phase - create and configure components
  extern function void build_phase(uvm_phase phase);

  // Write data to masterter monitor
  extern function void write_master_mon(apb_seq_item req);

  // Write data to slave monitor and update memory
  extern function void write_slv_mon(apb_seq_item req);

  // Run phase - compare masterter and slave data
  extern task run_phase(uvm_phase phase);

endclass : apb_scoreboard

// Constructor
function apb_scoreboard::new(string name = "apb_scoreboard", uvm_component parent);
  super.new(name, parent);
endfunction

// Build phase - create and configure components
function void apb_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  master_mon_imp = new("master_mon_imp", this);
  slv_mon_imp = new("slv_mon_imp", this);
  m_pkt=apb_seq_item::type_id::create("m_pkt");
  s_pkt=apb_seq_item::type_id::create("s_pkt");
  cmp=new();
endfunction

// Write data to masterter monitor
function void apb_scoreboard::write_master_mon(apb_seq_item req);
  m_pkt_que.push_back(req);
      //`uvm_info(get_type_name(), $sformatf("Printing mas, \n%s", req.sprint()), UVM_NONE)
endfunction

// Write data to slave monitor and update memory
function void apb_scoreboard::write_slv_mon(apb_seq_item req);
  s_pkt_que.push_back(req);
endfunction

// Run phase - compare masterter and slave data
task apb_scoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
    // Wait until both queues have data
    wait(m_pkt_que.size() != 0 && s_pkt_que.size() != 0);

    // Pop front items for comparison
    m_pkt = m_pkt_que.pop_front();
    s_pkt = s_pkt_que.pop_front();
    
    // Use do_compare to check equality
    if (!m_pkt.do_compare(s_pkt, cmp)) begin
      `uvm_error(get_type_name(), "Scoreboard comparison FAILED")
      `uvm_info(get_type_name(), $sformatf("Printing master, \n%s", m_pkt.sprint()), UVM_LOW)
    end else begin
      `uvm_info(get_type_name(), "Scoreboard comparison PASSSSSSSSSSS", UVM_NONE)
      `uvm_info(get_type_name(), $sformatf("Printing slave, \n%s", s_pkt.sprint()), UVM_LOW)
    end
  end
endtask

`endif
