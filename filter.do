--filter.do
--datum: 2013-12-01

--restart -f nowave
vsim work.filter
view signals wave

add wave clk reset skift sigout datain

force clk 0 0, 1 25 -repeat 50
force reset 0 0, 1 25, 0 100
force datain 0 0, 1 200, 0 250, 1 300

run 5000

