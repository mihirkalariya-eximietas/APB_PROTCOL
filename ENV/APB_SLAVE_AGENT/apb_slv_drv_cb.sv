/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_drv_cb.sv
//  module name : apb SLAVE DRIVER CALLBACK CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_SLV_DRV_CB_SV
`define APB_SLV_DRV_CB_SV

class apb_slv_drv_cb extends uvm_callback;

  // Factory registration
  `uvm_object_utils(apb_slv_drv_cb)

  // Control flag
  bit inject_err = 0;
  
  // extern function declaration for constructor
  extern function new(string name = "apb_slv_drv_cb");

  // extern task declaration
  extern virtual task inject_pslverr(apb_seq_item req);

endclass

// Function definition outside the class in the same file
function apb_slv_drv_cb::new(string name = "apb_slv_drv_cb");
  super.new(name);
endfunction

// Task definition outside the class in the same file
task apb_slv_drv_cb::inject_pslverr(apb_seq_item req);
  if (inject_err) begin
    req.PSLVERR = 1;
    `uvm_info("CB", "PSLVERR injected!", UVM_NONE)
  end
endtask

`endif
