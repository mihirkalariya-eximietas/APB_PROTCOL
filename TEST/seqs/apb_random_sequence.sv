/////////////////////////////////////////////////////////////////
//  file name   : apb_random_sequence.sv
//  module name : apb_random_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_RANDOM_sequence_SV
`define APB_RANDOM_sequence_SV

class apb_random_sequence extends apb_master_base_sequence;
  
  // Factory registration
  `uvm_object_utils(apb_random_sequence)

  // Sequence item handle
  apb_seq_item req;
  
  rand int itr = 10;

  // Constructor
  extern function new(string name = "apb_random_sequence");

  // Body - generates random transactions
  extern task body();

endclass : apb_random_sequence

// Constructor implementation
function apb_random_sequence::new(string name = "apb_random_sequence");
  super.new(name);
endfunction

// Body implementation - generates random transactions
task apb_random_sequence::body();
  `uvm_create(req)
  repeat(itr) begin
    start_item(req);
    assert(req.randomize()) else
      `uvm_fatal("get_full_name()", "Randomization failed!!!!!!!!");
    finish_item(req);
    `uvm_info(get_type_name(), $sformatf(" Printing req, \n %s", req.sprint()), UVM_MEDIUM);  
  end
endtask

`endif
