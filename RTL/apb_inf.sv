/////////////////////////////////////////////////////////////////
//  file name   : apb_master_inf.sv
//  module name : apb INTERFACE
/////////////////////////////////////////////////////////////////

`ifndef APB_INF_SV
`define APB_INF_SV

`define DATA_WIDTH 32
`define ADDR_WIDTH 32

interface apb_if(input PCLK);
  logic RESETn;
  logic [`ADDR_WIDTH-1:0] PADDR;
  logic [`DATA_WIDTH-1:0] PWDATA;
  logic PSLEx;
  logic PENABLE;
  logic PWRITE;
  logic [(`DATA_WIDTH/8)-1:0] PSTRB;
  logic [`DATA_WIDTH-1:0] PRDATA;
  logic PREADY;
  logic PSLVERR;


  // Idle_to_setup Assertion
//  property idle_to_setup_check;
//    @(posedge PCLK)
//      (!PSLEx && !PENABLE) ##1
//      ($rose(PWRITE) || $fell(PWRITE)) |-> PSLEx;
//  endproperty
//
//  assert property (idle_to_setup_check)
//  else 
//    $error("PSELx must be high when PWRITE toggles after idle.");
//  
//  //Pready_high_in_access
//  property pready_during_access_phase;
//    @(posedge PCLK)
//    disable iff (!RESETn)
//    PENABLE |-> ##[0:$] $rose(PREADY);
//  endproperty
//
//  assert property (pready_during_access_phase)
//  else $error("PREADY must go high at least once during the access phase when PENABLE is high.");

endinterface



`endif
