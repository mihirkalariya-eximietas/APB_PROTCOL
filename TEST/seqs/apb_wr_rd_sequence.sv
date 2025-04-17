/////////////////////////////////////////////////////////////////
//  file name   : apb_wr_rd_sequence.sv
//  module name : apb_wr_rd_sequence CLASS
/////////////////////////////////////////////////////////////////

`ifndef apb_wr_rd_sequence_SV
`define apb_wr_rd_sequence_SV

class apb_wr_rd_sequence extends apb_master_base_sequence;

  // Factory registration
  `uvm_object_utils(apb_wr_rd_sequence)

  // Sequence item handle
  apb_sanity_wr_sequence wr_seq;
  apb_sanity_rd_sequence rd_seq;

  rand int itr = 10;

  // Constructor
  extern function new(string name = "apb_wr_rd_sequence");

  // body - generates back-to-back write and read transactions
  extern task body();

endclass : apb_wr_rd_sequence

// Constructor
function apb_wr_rd_sequence::new(string name = "apb_wr_rd_sequence");
  super.new(name);
endfunction

// body - generates back-to-back write and read transactions
task apb_wr_rd_sequence::body();
  wr_seq = apb_sanity_wr_sequence::type_id::create("wr_seq");
  rd_seq = apb_sanity_rd_sequence::type_id::create("rd_seq");

  repeat (itr) begin
    wr_seq.start(p_sequencer);
  end

  repeat (itr) begin
    rd_seq.start(p_sequencer);
  end
endtask

`endif

