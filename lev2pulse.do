--transmitt.do
--datum: 2013-12-11

restart -f nowave
vsim work.lev2puls
view signals wave

add wave clk reset levin pulson state

force clk 0 0, 1 25 -repeat 50
force reset 0 0, 1 25, 0 100
force levin 1 150, 0 300, 1 350, 0 500

run 1000


