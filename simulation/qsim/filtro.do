onerror {quit -f}
vlib work
vlog -work work filtro.vo
vlog -work work filtro.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.topLevel_vlg_vec_tst
vcd file -direction filtro.msim.vcd
vcd add -internal topLevel_vlg_vec_tst/*
vcd add -internal topLevel_vlg_vec_tst/i1/*
add wave /*
run -all
