-- prio avkodare
-- file name: encoder42.vhd
-- date:  2013-11-01
-- name of author: Torbjorn 
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY encoder42 IS
  PORT (a   : IN STD_LOGIC_VECTOR (3 downto 0);
        f   : OUT STD_LOGIC_VECTOR (1 downto 0);
        z   : OUT STD_LOGIC);
END encoder42;

ARCHITECTURE behaviour OF encoder42 IS
BEGIN
  z   <=  '1' when a = "0000" else
          '0';
  f   <=  "11" when a(3) = '1'  else 
          "10" when a(3 downto 2) =   "01" else
          "01" when a(3 downto 1) =   "001" else
          "00"; 
END behaviour;
