--encoder.do
--datum: 2013-11-01

--restart -f nowave
vsim work.encoder42
view signals wave
add wave a f z
force a 0000 
run 50
force a(1) 1
run 50
force a(2) 1
run 50
force a(3) 1
run 50
force a(0) 1
run 50
-- force a 0000 0, 0001 50, 0010 100, 0011 150, 0100 200, 0101 250, 0110 300, 0111 350, 1000 400, 1001 450, 1010 500, 1011 550, 1100 600, 1101 650, 1110 700, 1111 750, 0000 800
 

run 900ns
