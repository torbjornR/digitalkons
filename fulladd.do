--fulladd.do
--datum: 2013-11-01

vsim work.fulladd
--restart -f nowave
view signals wave
add wave a b cin s cut

force a 0 0, 1 100 -repeat 200
force b 0 0, 1 200 -repeat 400
force cin 0 0, 1 300 -repeat 600


run 1000
