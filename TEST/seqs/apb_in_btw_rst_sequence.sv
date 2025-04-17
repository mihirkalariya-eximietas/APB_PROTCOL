/////////////////////////////////////////////////////////////////
//  file name   : apb_ibr_sequence.sv
//  module name : APB_IBR_sequence CLASS
//////////////////////////////////////////////////////////////////

`ifndef APB_IBR_sequence_SV
`define APB_IBR_sequence_SV

class apb_ibr_sequence extends apb_master_base_sequence;

  // Factory registration
  `uvm_object_utils(apb_ibr_sequence)

  // Sequence item handle
  virtual apb_if m_vif;
  apb_seq_item req;
  
  apb_sanity_wr_sequence wr_seq;
  apb_sanity_rd_sequence rd_seq;
  
  rand int itr = 10;

  // Constructor
  extern function new(string name = "apb_ibr_sequence");

  // Body - generates back-to-back write and read transactions with specific logic
  extern task body();

endclass : apb_ibr_sequence

// Constructor
function apb_ibr_sequence::new(string name = "apb_ibr_sequence");
  super.new(name);
  if(!uvm_config_db #(virtual apb_if)::get(null, "", "m_vif", m_vif))
    `uvm_fatal("get_full_name()","did not get interface")
endfunction

// Body - generates back-to-back write and read transactions with specific logic
task apb_ibr_sequence::body();
  wr_seq = apb_sanity_wr_sequence::type_id::create("wr_seq");
  rd_seq = apb_sanity_rd_sequence::type_id::create("rd_seq");
  
  fork
    begin
      repeat (itr) begin
        wr_seq.start(p_sequencer);
      end

      repeat (itr) begin
        rd_seq.start(p_sequencer);
      end
    end
    
    begin
      repeat(50)
        @(posedge m_vif.PCLK);
      m_vif.RESETn=0;
        @(posedge m_vif.PCLK);
      m_vif.RESETn=1;
    end
  join
endtask

`endif
