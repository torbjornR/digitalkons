-- lev2puls.vhd
-- 2013_12_11
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lev2puls is
  Port ( clk  : in STD_LOGIC;
    reset     : in STD_LOGIC;
    levin     : in STD_LOGIC;
    pulson    : out STD_LOGIC);
end lev2puls;

architecture arch of lev2puls is
  type state_type is (s0,s1,s2,s3);
  signal state, nstate: state_type;
begin
  
process (levin,state)
begin
  if reset = '1' then nstate <= s0; end if;
    pulson <= '0';
    nstate <= state;
  case state is
    when s0 => if levin = '1' then nstate <= s1; end if;
    when s1 => if levin = '1' then nstate <= s2; pulson <= '1'; end if;
    when s2 => if levin = '0' then nstate <= s3; end if;
    when s3 => nstate <= s0;
    when others =>
  end case;
end process;

process(clk)
begin
  if clk'event and clk = '1' then
    state <= nstate;
  end if;
end process;
end arch;
