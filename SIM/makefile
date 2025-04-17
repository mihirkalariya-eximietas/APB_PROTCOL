#Makefile for UVM Testbench

run:
	qverilog ../ENV/axi_env_pkg.sv ../TEST/axi_test_pkg.sv ../apb_tb_top/axi_apb_tb_top.sv +incdir+../ENV/AXI_MASTER +incdir+../ENV/AXI_SLAVE +incdir+../ENV +incdir+../TEST
TEST=""

cmp:
	vlog ../RTL/apb_inf.sv ../ENV/apb_env_pkg.sv ../TEST/apb_test_pkg.sv  ../TOP/apb_interconnect.sv ../TOP/apb_top.sv +incdir+../ENV/APB_MAS_AGENT +incdir+../ENV/APB_SLAVE_AGENT +incdir+../ENV +incdir+../TEST +incdir+../TEST/seqs +incdir+../TEST/test_case

sim:
	vsim -voptargs="+acc" apb_tb_top -c -do "run -all;exit" 

wave:
	vsim -voptargs="+acc" apb_tb_apb_tb_top 
	
regress:
		vlib work
		vlog ../RTL/apb_inf.sv ../ENV/apb_env_pkg.sv ../TEST/apb_test_pkg.sv  ../TOP/apb_interconnect.sv ../TOP/apb_top.sv +incdir+../ENV/APB_MAS_AGENT +incdir+../ENV/APB_SLAVE_AGENT +incdir+../ENV +incdir+../TEST +incdir+../TEST/seqs +incdir+../TEST/test_case
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_b2b_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_b2b_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_ibr_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_ibr_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_pslverr_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_pslverr_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_random_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_random_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_wr_nowait_rd_wait_test.ucdb; run -all; 	exit" +UVM_TESTNAME=apb_wr_nowait_rd_wait_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_wr_rd_no_wait_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_wr_rd_no_wait_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_wr_rd_wait_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_wr_rd_wait_test
		vsim -vopt -coverage apb_tb_top -c -do "coverage save -onexit -directive -cvg -codeall apb_wr_wait_rd_nowait_test.ucdb; run -all; exit" +UVM_TESTNAME=apb_wr_wait_rd_nowait_test
		
		vcover merge apb_merged.ucdb apb_b2b_test.ucdb apb_ibr_test.ucdb apb_pslverr_test.ucdb apb_random_test.ucdb  apb_wr_nowait_rd_wait_test.ucdb apb_wr_rd_no_wait_test.ucdb apb_wr_rd_wait_test.ucdb apb_wr_wait_rd_nowait_test.ucdb 
		
		vcover report -details -html apb_merged.ucdb
