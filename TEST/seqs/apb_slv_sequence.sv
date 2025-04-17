/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_sequence.sv
//  module name : apb apb_slv_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef apb_slv_sequence
`define apb_slv_sequence

class apb_slv_sequence extends apb_slv_base_sequence;
  
  // Factory registration
  `uvm_object_utils(apb_slv_sequence)
  
  rand bit[31:0] temp_rdata;
  
  // Sequence item handle
  apb_seq_item req;

  // Constructor
  extern function new(string name = "apb_slv_sequence");

  // Body - reads sequence items from the FIFO and processes them
  extern task body();

endclass : apb_slv_sequence

// Constructor implementation
function apb_slv_sequence::new(string name = "apb_slv_sequence");
  super.new(name);
endfunction

// Body implementation - reads from the FIFO and processes transactions
task apb_slv_sequence::body();
  forever begin
    p_sequencer.req_fifo.get(req);
    `uvm_info(get_type_name(), $sformatf(" Printing req, \n %s", req.sprint()), UVM_LOW)
	if (!randomize()) begin
      `uvm_fatal(get_type_name(), "Randomization failed!")
    end
    start_item(req);
	  req.PRDATA = temp_rdata;
	finish_item(req);
  end
endtask

`endif
