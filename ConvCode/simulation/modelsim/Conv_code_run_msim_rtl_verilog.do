transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/Conv_code.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/M_series.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/encode.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/decode.v}

vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/Conv_code_tb.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/decode.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/encode.v}
vlog -vlog01compat -work work +incdir+E:/Program/quartus/ConvCode {E:/Program/quartus/ConvCode/M_series.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  Conv_code_tb

add wave *
view structure
view signals
run -all
