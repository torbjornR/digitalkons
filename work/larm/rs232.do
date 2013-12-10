--rs232.do
--datum: 2013-11-22

vsim work.comp1bit
--restart -f nowave
view signals wave
add wave trdata tclk start 

force tclk 0 0, 1 50 -repeat 100
force start 0 0
force trdata 0101 

run 1000
