/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_base_sequence.sv
//  module name : apb slv_BASE_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_SLV_BASE_sequence_SV
`define APB_SLV_BASE_sequence_SV

class apb_slv_base_sequence extends uvm_sequence #(apb_seq_item);

  // Factory registration
  `uvm_object_utils(apb_slv_base_sequence)
  `uvm_declare_p_sequencer(apb_slv_sequencer)

  // seq_item handle
  apb_seq_item req; 

  // extern function declaration outside class
  extern function new(string name = "apb_slv_base_sequence");
  extern virtual task body();

endclass: apb_slv_base_sequence

// Function definition outside class in the same file
function apb_slv_base_sequence::new(string name = "apb_slv_base_sequence");
  super.new(name);
endfunction

// Task body definition outside class in the same file
task apb_slv_base_sequence::body();
  // Implement task functionality here
endtask

`endif
