--rs232.do
--datum: 2013-11-22

vsim work.comp1bit
--restart -f nowave
view signals wave
add wave clk tclk trdata txd reset

force clk 0 0, 1 10 -repeat 20
force tclk 0 0, 1 50 -repeat 100
force reset 1 0, 0 20
force trdata(0) 0
force trdata(1) 1
force trdata(2) 0
force trdata(3) 1


run 1000
