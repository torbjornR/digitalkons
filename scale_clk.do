--transmitt.do
--datum: 2013-12-10

--restart -f nowave
vsim work.scale_clk
view signals wave

add wave clk clk_300hz RST

force clk 0 0, 1 25 -repeat 50
force RST 0 0, 1 25, 0 100

run 5000


