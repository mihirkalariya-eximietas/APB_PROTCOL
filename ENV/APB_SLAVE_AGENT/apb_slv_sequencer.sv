/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_sequencer.sv
//  module name : APB_SLV_sequencer CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_SLV_sequencer_SV
`define APB_SLV_sequencer_SV

class apb_slv_sequencer extends uvm_sequencer #(apb_seq_item);

  // Factory registration
  `uvm_component_utils(apb_slv_sequencer)

  // Analysis port declaration
  uvm_analysis_export #(apb_seq_item) req_aexport;
  uvm_tlm_analysis_fifo #(apb_seq_item) req_fifo;

  // extern constructor declaration
  extern function new(string name = "apb_slv_sequencer", uvm_component parent = null);

  // extern build phase declaration
  extern function void build_phase(uvm_phase phase);

  // extern connect phase declaration
  extern function void connect_phase(uvm_phase phase);

endclass

// Constructor definition outside class
function apb_slv_sequencer::new(string name = "apb_slv_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase definition outside class
function void apb_slv_sequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  req_fifo = new("my_fifo", this);
  req_aexport = new("req_aexport", this);
endfunction

// Connect phase definition outside class
function void apb_slv_sequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  req_aexport.connect(req_fifo.analysis_export);
endfunction

`endif
