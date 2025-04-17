/////////////////////////////////////////////////////////////////
//  file name   : apb_test_pkg.sv
//  module name : APB_TEST_PKG
//////////////////////////////////////////////////////////////////

`ifndef APB_TEST_PKG_SV
`define APB_TEST_PKG_SV

package apb_test_pkg;
  event reset_done;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import apb_env_pkg::*;
  
  //-----------sequences
  `include "apb_sanity_wr_sequence.sv"
  `include "apb_sanity_rd_sequence.sv"
  `include "apb_wr_rd_sequence.sv"
  `include "apb_slv_sequence.sv"
  `include "apb_wait_sequence.sv"
  `include "apb_rd_wait_sequence.sv"
  `include "apb_wr_wait_sequence.sv"
  `include "apb_b2b_sequence.sv"
  `include "apb_in_btw_rst_sequence.sv"
  `include "apb_random_sequence.sv"
  //`include "apb_wr_rd_all_memory_sequence.sv"
  
  //-----------testcsaes
  `include "apb_base_test.sv"
  `include "apb_wr_rd_no_wait_test.sv"
  `include "apb_wr_rd_wait_test.sv"
  `include "apb_wr_wait_rd_nowait_test.sv"
  `include "apb_wr_nowait_rd_wait_test.sv"
  `include "apb_b2b_test.sv"
  `include "apb_in_btw_rst_test.sv"
  `include "apb_pslverr_test.sv"
  `include "apb_random_test.sv"

endpackage

`endif
