-- heladderare
-- file name: cfulladd.vhd
-- date:  2013-11-01
-- name of author: Torbjorn 
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fulladd IS
  PORT (a,b,cin : IN STD_LOGIC;
    s,cut : OUT STD_LOGIC);
END fulladd;

ARCHITECTURE comb OF fulladd IS
BEGIN
  s   <= (a xor b) xor cin;
  cut <= (a and b) or (cin and B) or (cin and a);
END comb;
