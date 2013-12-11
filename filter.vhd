-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-12-11
--Project Name:   filter
-------------------------------------------------------
library ieee ;
use ieee . std_logic_1164 .all;
use ieee . std_logic_unsigned . all ;

entity filter is
 Port ( clk     : in std_logic ;    -- this clock neds to be 4 times faster then the manch clock
        reset   : in std_logic ;
        datain  : in std_logic ;    -- unfiltered data from atenna
        dataout : out std_logic );  -- filtered data
end filter ;

architecture arki of filter is
 signal skift   : std_logic_vector (3 downto 0);  -- skift register för filltrering
 signal sigout  : std_logic ;

begin
  
process (clk , reset , sigout )
begin
  dataout <= sigout ;
  if reset = '1' then
    skift <= "0000";
    sigout <= '0';
  elsif clk ' event and clk = '1' then
    skift <= skift (3 downto 0) & datain ; -- reads from the unfiltered data from antenna
  case skift is -- decides value on the filtered bit
 
  when "0000"|"0001"|"0010"|"0100"|"1000" =>
    sigout <= '0';

  when "0111"|"1011"|"1101"|"1110"|"1111" =>
    sigout <= '1';
  when others =>      -- in case of the event of equal number of 0 and 1, keepe previous value on the outport
    sigout <= sigout ;
  end case ;
 end if;
end process ;
end arki ;