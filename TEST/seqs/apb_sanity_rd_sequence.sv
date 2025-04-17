/////////////////////////////////////////////////////////////////
//  file name   : apb_sanity_rd_sequence.sv
//  module name : apb_sanity_rd_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_sanity_rd_sequence_SV
`define APB_sanity_rd_sequence_SV

class apb_sanity_rd_sequence extends apb_master_base_sequence;

  // Factory registration
  `uvm_object_utils(apb_sanity_rd_sequence)

  // Sequence item handle
  apb_seq_item req;

  // Constructor
  extern function new(string name = "apb_sanity_rd_sequence");

  // body - generates rdite transactions followed by read transactions
  extern task body();

endclass : apb_sanity_rd_sequence

// Constructor
function apb_sanity_rd_sequence::new(string name = "apb_sanity_rd_sequence");
  super.new(name);
endfunction

// body - generates rdite transactions followed by read transactions
task apb_sanity_rd_sequence::body();
  `uvm_create(req)
    start_item(req);
      assert(req.randomize() with { req.PWRITE == 0; }) else
        `uvm_fatal("get_full_name()", "Randomization failed!!!!!!!!");
    finish_item(req);
    `uvm_info(get_type_name(), $sformatf(" Printing req, \n %s", req.sprint()), UVM_LOW);
endtask

`endif

