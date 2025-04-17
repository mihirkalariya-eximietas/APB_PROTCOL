/////////////////////////////////////////////////////////////////
//  file name   : wr_rd_all_memory_sequence.sv
//  module name : wr_rd_all_memory_sequence CLASS
/////////////////////////////////////////////////////////////////

`ifndef WR_RD_ALL_MEMORY_sequence_SV
`define WR_RD_ALL_MEMORY_sequence_SV

class wr_rd_all_memory_sequence extends apb_master_base_sequence;

  `uvm_object_utils(wr_rd_all_memory_sequence)

  apb_seq_item req;

  // Constructor
  extern function new(string name = "wr_rd_all_memory_sequence");

  // body - write to all addresses, then read back
  extern task body();

endclass : wr_rd_all_memory_sequence

// Constructor
function wr_rd_all_memory_sequence::new(string name = "wr_rd_all_memory_sequence");
  super.new(name);
endfunction

// body - write to all 256 addresses, then read from same addresses
task wr_rd_all_memory_sequence::body();
  `uvm_create(req)
  req.c3.constraint_mode(0);

  // Write phase
  for (int addr = 0; addr < 256; addr++) begin
    start_item(req);
    assert(req.randomize() with {
      PADDR == addr;
      PWRITE == 1;
    }) else
      `uvm_fatal("SEQ", $sformatf("Write randomization failed at addr = %0d", addr));
    finish_item(req);
    `uvm_info(get_type_name(), $sformatf("Write Req:\n%s", req.sprint()), UVM_MEDIUM);
  end

  #20;

  // Read phase
  for (int addr = 0; addr < 256; addr++) begin
    start_item(req);
    assert(req.randomize() with {
      PADDR == addr;
      PWRITE == 0;
    }) else
      `uvm_fatal("SEQ", $sformatf("Read randomization failed at addr = %0d", addr));
    finish_item(req);
    `uvm_info(get_type_name(), $sformatf("Read Req:\n%s", req.sprint()), UVM_MEDIUM);
  end
endtask

`endif
