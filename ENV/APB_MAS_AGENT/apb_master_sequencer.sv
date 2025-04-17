/////////////////////////////////////////////////////////////////
//  File Name   : apb_master_sequencer.sv
//  Module Name : APB MAS_sequencer CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_MAS_sequencer_SV
`define APB_MAS_sequencer_SV

class apb_master_sequencer extends uvm_sequencer #(apb_seq_item);

  // Factory registration
  `uvm_component_utils(apb_master_sequencer)

  // constructor declaration
  extern function new(string name = "", uvm_component parent = null);

endclass

// Definition of the 'new' function 
function apb_master_sequencer::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

`endif
