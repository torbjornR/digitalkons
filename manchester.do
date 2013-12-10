--manchester.do
--datum: 2013-11-26

--restart -f nowave
vsim work.manchester
view signals wave

add wave data output clk reset

force reset 1 0, 0 100
force clk 0 0, 1 25 -repeat 50
force data  0 200, 1 300, 0 400, 1 500, 0 600, 1 700, 0 800, 1 900

run 1000ns
