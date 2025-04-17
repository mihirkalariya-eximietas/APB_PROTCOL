/////////////////////////////////////////////////////////////////
//  file name   : apb_rd_wait_sequence.sv
//  module name : apb_rd_wait_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_RD_WAIT_sequence_SV
`define APB_RD_WAIT_sequence_SV

class apb_rd_wait_sequence extends apb_slv_base_sequence;
	
  // Factory Registration
  `uvm_object_utils(apb_rd_wait_sequence)

  // Sequence Item Handle
  apb_seq_item req;
  rand bit[2:0] delay;
  rand bit[31:0] temp_rdata;

  constraint con1 {
    delay dist { 0 := 70, [1:4] := 30 };
  }

  // Constructor 
  extern function new(string name = "apb_rd_wait_sequence");

  // Body Task
  extern task body();

endclass: apb_rd_wait_sequence

// Constructor implementation
function apb_rd_wait_sequence::new(string name = "apb_rd_wait_sequence");
  super.new(name);
endfunction

// Body implementation
task apb_rd_wait_sequence::body();
  forever begin
    // Get request from FIFO
    p_sequencer.req_fifo.get(req);
    `uvm_info(get_type_name(), $sformatf(" Received req: \n %s", req.sprint()), UVM_LOW)
    
    if (!randomize()) begin
      `uvm_error(get_type_name(), "Randomization of delay failed!")
    end

    start_item(req);
      if(req.PWRITE) begin
        req.delay = 0;
        req.PRDATA = 0;
      end
      else begin
        req.PRDATA = temp_rdata;
        req.delay = delay;
      end
    finish_item(req);
  end  
endtask

`endif
