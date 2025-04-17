/////////////////////////////////////////////////////////////////
//  file name   : apb_b2b_sequence.sv
//  module name : apb_b2b_sequence CLASS
/////////////////////////////////////////////////////////////////

`ifndef apb_b2b_sequence_SV
`define apb_b2b_sequence_SV

class apb_b2b_sequence extends apb_master_base_sequence;

  // Factory registration
  `uvm_object_utils(apb_b2b_sequence)

  // Sequence item handle
  apb_seq_item req;
  apb_sanity_wr_sequence wr_seq;
  apb_sanity_rd_sequence rd_seq;
  
  rand int itr = 10;

  // Constructor
  extern function new(string name = "apb_b2b_sequence");

  // body - generates back-to-back write and read transactions
  extern task body();

endclass : apb_b2b_sequence

// Constructor
function apb_b2b_sequence::new(string name = "apb_b2b_sequence");
  super.new(name);
endfunction

// body - generates back-to-back write and read transactions
task apb_b2b_sequence::body();
  wr_seq = apb_sanity_wr_sequence::type_id::create("wr_seq");
  rd_seq = apb_sanity_rd_sequence::type_id::create("rd_seq");

  repeat (itr) begin
    wr_seq.start(p_sequencer);
    rd_seq.start(p_sequencer);
  end
endtask

`endif
