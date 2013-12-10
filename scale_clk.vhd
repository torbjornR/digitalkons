-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson
--Create Date:    13-12-10
--Project Name:   scale_clk
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity scale_clk is port(
clk             : in std_logic;                             -- startar konvertering vid NS = '0'
clk_300hz       : out std_logic;                            -- klockutgång
RST             : in  std_logic);                           -- reset signal in button 
end scale_clk;

architecture ark of scale_clk is
signal counter            : std_logic_vector(31 downto 0);  -- internal counter may have to be resised to match max count 
signal intern_300hz       : std_logic;       
begin

scaledown_clock : process(RST, clk)
    begin  
    if (RST = '1') then                 -- start if(1) that slows down clock "do an resett if true"
        intern_300hz <= '0';
        counter <=  (others => '0');    -- counter 
    elsif  rising_edge (clk) then       -- when rising edge and nott reset start counting
      counter <= counter + '1';
        if counter < 3 then          -- start if(2) duty cykel 50% then half of the max counte 166666666
          intern_300hz <=  '1';
        else
          intern_300hz <=  '0';
        end if;                         -- end if(2)
        if counter = 5 then          -- start if(3) restart counter when retch max 333333333
          counter <= (others => '0'); 
      end if;                           -- end if(3)
    end if;                             -- end if(1)
end process scaledown_clock; 
clk_300hz <= intern_300hz;
end ark;
