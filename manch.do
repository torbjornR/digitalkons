--manch.do
--datum: 2013-11-27

--restart -f nowave
vsim work.manch
view signals wave

add wave data output clk state recet


force clk 0 0, 1 50 -repeat 100
force recet 0 0, 1 25, 0 100
force data  0 0, 0 200, 1 300, 0 400, 1 500, 0 600, 1 700, 0 800, 1 900

run 1000ns