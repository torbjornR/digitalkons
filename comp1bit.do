--comp1bit.do
--datum: 2013-11-01

vsim work.comp1bit
--restart -f nowave
view signals wave
add wave a b agtb aeqb altb 

force a 0 0, 1 100 -repeat 200
force b 0 0, 1 200 

run 500
