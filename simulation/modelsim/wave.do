onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Testbench /testbench/rstn
add wave -noupdate -expand -group Testbench /testbench/clk
add wave -noupdate -expand -group Testbench /testbench/pix
add wave -noupdate -expand -group Testbench /testbench/pix_o
add wave -noupdate -expand -group Testbench /testbench/w_FlagProcess
add wave -noupdate -expand -group TopLevel /testbench/topLevel/i_clk
add wave -noupdate -expand -group TopLevel /testbench/topLevel/i_pixel
add wave -noupdate -expand -group TopLevel /testbench/topLevel/o_pixel
add wave -noupdate -expand -group TopLevel /testbench/topLevel/o_FlagProcess
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer1x0
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer1x1
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer1x2
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer2x0
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer2x1
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_OUT_RowBuffer2x2
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_Buffer0x0
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_Buffer0x1
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_Buffer0x2
add wave -noupdate -expand -group TopLevel /testbench/topLevel/w_Flag_Process
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_clk
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel0x0
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel0x1
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel0x2
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel1x0
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel1x1
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel1x2
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel2x0
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel2x1
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/i_Pixel2x2
add wave -noupdate -expand -group WINDOW /testbench/topLevel/window/o_Result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104333312 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {228283362 ps} {332616674 ps}
