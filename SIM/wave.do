onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PCLK
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/RESETn
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} -radix binary /apb_tb_top/m_vif/PADDR
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PWDATA
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PSLEx
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PENABLE
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PWRITE
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PSTRB
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PRDATA
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PREADY
add wave -noupdate -expand -label sim:/apb_tb_top/m_vif/Group1 -group {Region: sim:/apb_tb_top/m_vif} /apb_tb_top/m_vif/PSLVERR
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/NUM_SLAVES
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PADDR
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PWRITE
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PENABLE
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PWDATA
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PSLE
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PREADY_SLV
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PSLVERR_SLV
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PRDATA_SLV
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PRDATA
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PSLVERR
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/PREADY
add wave -noupdate -label sim:/apb_tb_top/interconnect_inst/Group1 -group {Region: sim:/apb_tb_top/interconnect_inst} /apb_tb_top/interconnect_inst/sel
add wave -noupdate -expand -group {slave 0} {/apb_tb_top/s_vif[0]/PREADY}
add wave -noupdate -expand -group {slave 0} {/apb_tb_top/s_vif[0]/PRDATA}
add wave -noupdate -expand -group {slave 1} {/apb_tb_top/s_vif[1]/PREADY}
add wave -noupdate -expand -group {slave 1} {/apb_tb_top/s_vif[1]/PRDATA}
add wave -noupdate -expand -group {slave 2} {/apb_tb_top/s_vif[2]/PREADY}
add wave -noupdate -expand -group {slave 2} {/apb_tb_top/s_vif[2]/PRDATA}
add wave -noupdate -expand -group {slave 3} {/apb_tb_top/s_vif[3]/PREADY}
add wave -noupdate -expand -group {slave 3} {/apb_tb_top/s_vif[3]/PRDATA}
add wave -noupdate -expand -group {slave 4} {/apb_tb_top/s_vif[4]/PREADY}
add wave -noupdate -expand -group {slave 4} {/apb_tb_top/s_vif[4]/PRDATA}
add wave -noupdate -expand -group {slave 5} {/apb_tb_top/s_vif[5]/PREADY}
add wave -noupdate -expand -group {slave 5} {/apb_tb_top/s_vif[5]/PRDATA}
add wave -noupdate -expand -group {slave 6} {/apb_tb_top/s_vif[6]/PREADY}
add wave -noupdate -expand -group {slave 6} {/apb_tb_top/s_vif[6]/PRDATA}
add wave -noupdate -expand -group {slave 7} {/apb_tb_top/s_vif[7]/PREADY}
add wave -noupdate -expand -group {slave 7} {/apb_tb_top/s_vif[7]/PRDATA}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {945 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {864 ns} {1292 ns}
