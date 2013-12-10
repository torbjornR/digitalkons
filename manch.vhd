-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-11-27
--Project Name:   manch
-------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity manch is
    Port (  data    : in  STD_LOGIC;
            clk     : in  STD_LOGIC;
            recet   : in  STD_LOGIC;
            output  : out STD_LOGIC);
end manch;

architecture state_machine of manch is
type StateType is (s1, s2, s3, s4);               -- 4 states
signal state, next_state :StateType;
begin                                             -- state machine starts

s_machine:process(data, recet)
begin 
  if (recet = '1') then
    state <= s1;
elsif (clk'event) then
  
case state is 
-------------------------------------------------------------------------
when s1 => output <= '0';
  next_state <= s2;
-------------------------------------------------------------------------
when s2 => output <= '1';
if (data = '0') then
  state <= s1;
else state <= s3;
end if;
-------------------------------------------------------------------------    
when s3 => output <= '1';
  state <= s4;
-------------------------------------------------------------------------
when s4 => output <= '0';
if (data = '0') then 
  state <= s1;
else state <= s3;
end if;
-------------------------------------------------------------------------
when others =>
  state <= s1;
end case;
end if;
end process; 

end state_machine;