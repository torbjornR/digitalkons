--Halfadd.do
--datum: 2013-11-01

vsim work.halfadd
--restart -f nowave
view signals wave
add wave x y s cut

force x 0 0, 1 100 -repeat 200
force y 0 0, 1 200 -repeat 400
run 800
