/////////////////////////////////////////////////////////////////
//  file name   : apb_seq_item.sv
//  module name : apb MAS_SEQ_ITEM CLASS
/////////////////////////////////////////////////////////////////

`ifndef APB_SEQ_ITEM_SV
`define APB_SEQ_ITEM_SV

class apb_seq_item extends uvm_sequence_item;

  rand bit [`ADDR_WIDTH-1:0] PADDR;
  rand bit [`DATA_WIDTH-1:0] PWDATA;
  rand bit [(`DATA_WIDTH/8)-1:0] PSTRB;
  rand bit PWRITE;
  bit [`DATA_WIDTH-1:0] PRDATA;
  rand bit PREADY;
  bit PENABLE; //remove
  bit PSLEx;
  bit PSLVERR = 0;
  int delay;
  
  // Constructor
  extern function new(string name = "apb_seq_item");

  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  
  // Factory registration
  `uvm_object_utils_begin(apb_seq_item)
    `uvm_field_int(PWRITE , UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PWDATA , UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PREADY , UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PRDATA , UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PADDR  , UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PSLVERR, UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(PSTRB  , UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

endclass : apb_seq_item

// Constructor definition
function apb_seq_item::new(string name = "apb_seq_item");
  super.new(name);
endfunction

// Compare method to check equality of two apb_seq_item objects
function bit apb_seq_item::do_compare(uvm_object rhs, uvm_comparer comparer);
  apb_seq_item rhs_;
  if (!$cast(rhs_, rhs)) begin
    `uvm_error(get_type_name(), "Comparison failed: rhs is not of type apb_seq_item")
    return 0;
  end

  // Field-by-field comparison
  if (PADDR    !== rhs_.PADDR)    return 0;
  if (PWDATA   !== rhs_.PWDATA)   return 0;
  if (PWRITE   !== rhs_.PWRITE)   return 0;
  if (PRDATA   !== rhs_.PRDATA)   return 0;

  return 1;
endfunction

`endif
