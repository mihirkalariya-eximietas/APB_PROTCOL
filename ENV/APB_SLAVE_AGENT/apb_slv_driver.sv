/////////////////////////////////////////////////////////////////
//  file name   : apb_slv_driver.sv
//  module name : apb SLAVE DRIVER CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_SLV_DRV_SV
`define APB_SLV_DRV_SV

class apb_slv_driver extends uvm_driver #(apb_seq_item);

  // Factory registration
  `uvm_component_utils(apb_slv_driver)
  `uvm_register_cb(apb_slv_driver, apb_slv_drv_cb)

  // Virtual interface
  virtual apb_if s_vif;

  // Memory & temp
  bit [31:0] temp_data;

  // extern function declaration outside class
  extern function new(string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task initialize();
  extern task send_to_dut();

endclass

// constructor - initialize the driver
function apb_slv_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase - create/configure components and get interfaces
function void apb_slv_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

// run phase - main driver functionality for sending data to DUT
task apb_slv_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  wait(s_vif.RESETn);
  initialize();
  forever begin
    if (!s_vif.RESETn) begin
      initialize();
    end 
    else begin
      seq_item_port.get_next_item(req);
        send_to_dut();
        `uvm_info(get_type_name(), $sformatf("Printing req, \n%s", req.sprint()), UVM_LOW)
      seq_item_port.item_done();
    end
  end
endtask

// initialize slave
task apb_slv_driver::initialize();
  @(posedge s_vif.PCLK);
  s_vif.PRDATA  <= 0;
  s_vif.PREADY  <= 0;
endtask

// send to DUT - perform memory read/write operation based on request
task apb_slv_driver::send_to_dut();
  wait(s_vif.PSLEx);
  s_vif.PREADY <= 0;
  
  if (!s_vif.RESETn)
    s_vif.PRDATA <= 0;

  repeat(req.delay)
    @(posedge s_vif.PCLK);
	
  wait(s_vif.PENABLE)
  s_vif.PREADY <= 1;

  if(!s_vif.PWRITE) begin
    s_vif.PRDATA <= req.PRDATA;
  end

  wait(s_vif.PREADY) begin
    `uvm_do_callbacks(apb_slv_driver, apb_slv_drv_cb, inject_pslverr(req))
    s_vif.PSLVERR <= req.PSLVERR;
  end
endtask

`endif
