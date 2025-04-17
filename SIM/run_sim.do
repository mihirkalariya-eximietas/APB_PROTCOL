


vlog ../RTL/apb_inf.sv ../ENV/apb_env_pkg.sv ../TEST/apb_test_pkg.sv  ../TOP/apb_interconnect.sv ../TOP/apb_top.sv +incdir+../ENV/APB_MAS_AGENT +incdir+../ENV/APB_SLAVE_AGENT +incdir+../ENV +incdir+../TEST +incdir+../TEST/seqs +incdir+../TEST/test_case
vsim -voptargs="+acc" apb_tb_top 
do ./wave.do
run -all



#do run_sim.do axi_sanity_test 123



