--manch.do
--datum: 2013-12-01

restart -f nowave
vsim work.manch2
view signals wave

add wave clk reset v d y state_reg state_next


force clk 0 0, 1 25 -repeat 50
force reset 0 0, 1 25, 0 100
force d  0 0, 0 200, 1 300, 0 400, 1 500, 0 600, 1 700, 0 800, 1 900
force v  0 0, 1 200, 0 900
run 1000ns
