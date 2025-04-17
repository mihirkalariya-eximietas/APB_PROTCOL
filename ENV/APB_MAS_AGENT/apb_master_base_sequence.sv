/////////////////////////////////////////////////////////////////
//  File Name   : apb_master_base_sequence.sv
//  Module Name : APB MAS_BASE_sequence CLASS
/////////////////////////////////////////////////////////////////

`ifndef apb_MAS_BASE_sequence_SV
`define apb_MAS_BASE_sequence_SV

class apb_master_base_sequence extends uvm_sequence #(apb_seq_item);

  // factory registration
  `uvm_object_utils(apb_master_base_sequence)
  `uvm_declare_p_sequencer(apb_master_sequencer)
  // sequence item handle
  apb_seq_item req;

  rand int itr = 10;

  // constructor
  extern function new(string name = "apb_master_base_sequence");

  // task body - sequence behavior defined here
  extern virtual task body();

endclass : apb_master_base_sequence

// constructor
function apb_master_base_sequence::new(string name = "apb_master_base_sequence");
  super.new(name);
endfunction

// task body - sequence behavior defined here
task apb_master_base_sequence::body();
endtask

`endif
