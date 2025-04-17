`ifndef APB_MAS_DRV_SV
`define APB_MAS_DRV_SV

class apb_master_driver extends uvm_driver #(apb_seq_item);

  `uvm_component_utils(apb_master_driver)

  // virtual interface
  virtual apb_if m_vif;

  // count for tracking transactions

  apb_seq_item temp_req;

  extern function new(string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task initialize();
  extern task idle();
  extern task setup();
  extern task access();
  extern task drive();

endclass

// constructor
function apb_master_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase - create and configure driver components
function void apb_master_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

// run phase - drive transactions based on sequence items
task apb_master_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  wait(m_vif.RESETn);
  // Initialization of Signals 
  initialize(); 
  forever begin
    if (!m_vif.RESETn) begin
      initialize(); 
    end 
    else begin
      seq_item_port.try_next_item(temp_req);
      if(temp_req!=null) begin
        req= temp_req;
        drive();
        seq_item_port.item_done();
      end
      else begin
        idle();
        @(posedge m_vif.PCLK);
      end
    end
  end
endtask

// Initialize Signals Task
task apb_master_driver::initialize();
  m_vif.PSLEx   <= 0;
  m_vif.PENABLE <= 0;
  m_vif.PWRITE  <= 0;
  m_vif.PWDATA  <= 0;
  m_vif.PSTRB   <= 0;
  m_vif.PRDATA  <= 0;
  m_vif.PREADY  <= 0;
   @(posedge m_vif.PCLK);
endtask

// idle state task - sets signals to idle
task apb_master_driver::idle();
  m_vif.PSLEx   <= 0;
  m_vif.PENABLE <= 0;
endtask

// setup task - configure the interface signals for a transaction
task apb_master_driver::setup();
  m_vif.PSLEx   <= 1;
  m_vif.PENABLE <= 0;
  m_vif.PWRITE  <= req.PWRITE;
  m_vif.PADDR   <= req.PADDR;
  if (req.PWRITE) begin
    m_vif.PWDATA <= req.PWDATA;
    m_vif.PSTRB  <= req.PSTRB;
  end
endtask

// access task - handle transaction readiness and flow control
task apb_master_driver::access();
  @(posedge m_vif.PCLK);
  do begin
    m_vif.PENABLE <= 1;
    @(posedge m_vif.PCLK);
  end while (!m_vif.PREADY); 
endtask

// drive task - sequence the transaction through setup and access
task apb_master_driver::drive();
  setup();
  access();
  `uvm_info(get_type_name(), $sformatf("Printing req, \n %s", req.sprint()), UVM_MEDIUM)
endtask

`endif
