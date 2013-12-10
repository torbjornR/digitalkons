-- halfadd.vhd
-- 110115 name of author
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY halfadd IS
  PORT (x: IN STD_LOGIC;
    y   : IN  STD_LOGIC;
    s   : OUT STD_LOGIC;
    cut : OUT STD_LOGIC);
END halfadd;
ARCHITECTURE comb OF halfadd IS
  
BEGIN
  s   <= x xor y;
  cut <= x and y;
END comb;
