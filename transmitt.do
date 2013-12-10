--transmitt.do
--datum: 2013-12-09

restart -f nowave
vsim work.transmitt
view signals wave

add wave clk sclk reset sendin datain dataut sendut intdata state

force sclk 0 0, 1 25 -repeat 50
force reset 0 0, 1 25, 0 100
force sendin 1 100
force datain(0) 1 0
force datain(1) 0 0
force datain(2) 1 0
force datain(3) 1 0
run 5000

