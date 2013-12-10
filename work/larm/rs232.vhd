-- uartt.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
ENTITY rs232 IS
  PORT (clk,reset,start,tclk: in std_logic;
    trdata: in std_logic_vector(3 downto 0);
    txd,donet: out std_logic);
end rs232;

ARCHITECTURE rtl of uartt is
  type state_type is (s0,s1,s2,b0,b1,b2,b3,b4,b5,b6,b7,sx,sy);
  signal state, nstate: state_type;
begin
Process(clk)
begin
  if clk'event and clk = '1' then
    if reset = '1' then
      state <= s0;
    else state <= nstate;
    end if;
  end if;
end process;

process(state,tclk,start)
begin
txd <= '1';
nstate <= state;
donet <= '0';
case state is
--- waiting fore start bitt 
when s0 => 
  if start= '1' 
    then nstate <= s1; 
  end if;
--- waiting fore clock pulls  
when s1 => 
if tclk = '1' 
  then nstate <= s2; 
end if;
--- sending start bitt
when s2 => 
  txd <= '0'; 
if tclk = '1' 
  then nstate <= b0; 
end if;
--- sending bit 0
when b0 => 
  txd <= trdata(0); 
if tclk = '1' 
  then nstate <= b1; 
end if;
--- sending bit 1
when b1 => 
  txd <= trdata(1); 
if tclk = '1' 
  then nstate <= b2; 
end if;
--- sending bit 2
when b2 => 
  txd <= trdata(2); 
if tclk = '1' 
  then nstate <= b3; 
end if;
--- Sending bit 3
when b3 => 
  txd <= trdata(3); 
if tclk = '1' 
  then nstate <= sx; 
end if;
-- ???
when sx => 
if tclk = '1' 
then nstate <= sy; 
end if;
--- skickar done transmitt
when sy => 
  donet <= '1'; 
  nstate <= s0;

when others =>
end case;
end process;
end rtl;
