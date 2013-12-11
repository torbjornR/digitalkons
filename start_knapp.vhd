-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-12-10
--Project Name:   start knapp
--to do we ned an end of transmittion
--se if i can hawe smaler heddCounter  
-------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity start_knapp is
    Port (  clk            : in  STD_LOGIC;
            start_knapp    : in  STD_LOGIC;
            reset          : in  STD_LOGIC;
            start_auht     : out STD_LOGIC); 
            
end start_knapp;

architecture arki of start_knapp is
type state_type is (idle, start);
signal state  : state_type;
signal next_state  : state_type;

begin
  
  process (clk, reset) is
    begin
    if (reset = '1') then   -- reset funktion
     state <= idle;
    elsif (rising_edge (clk)) then
    state <= next_state;
  end if;
case state is 
-------------------idle----------------------
when idle => start_auht <= '0';
  if start_knapp = '1' then 
    next_state <= start;
  end if;
-------------------start---------------------
when start => start_auht <= '1';
  next_state <= idle;
end case;
end process;
end arki;


