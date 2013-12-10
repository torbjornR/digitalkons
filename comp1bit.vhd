-- en bits komparator
-- file name: comp1bit.vhd
-- date:  2013-11-01
-- name of author: Torbjorn 
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY comp1bit IS
  PORT (a,b             : IN STD_LOGIC;
    agtb, aeqb, altb    : OUT STD_LOGIC);
END comp1bit;

ARCHITECTURE comb OF comp1bit IS
  begin
comp : process (a,b)
        begin
        agtb <= '0';
        aeqb <= '0';
        altb <= '0';
        if a > b then agtb <= '1';
        --if a = b then aeqb <= '1';
      elsif a < b then altb <= '1';
        else aeqb <= '1';
        end if;
end process; 
  
END comb;
