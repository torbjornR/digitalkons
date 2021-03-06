
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity manchester is
    Port ( data : in  STD_LOGIC;
           output : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end manchester;

architecture Behavioral of manchester is
signal current_state, next_state :std_logic_vector(2 downto 0);
begin
process (clk,reset,data)
begin 
if (reset= '1') then                   -- if(1) recet
next_state <="000";                     
elsif (current_state <="000" )  then    
if ( data ='0')  then                   
next_state<="001";
else                                     
next_state<="010";
end if ; 
elsif (current_state="001") then
output <='0';
next_state<="011";
elsif (current_state ="010") then 
output<='1';
next_state<="100";
elsif current_state="100" then 
output<='0';
next_state <="000";
elsif current_state="011" then
output<='1';
next_state<="000";
else 
output<= 'Z';     -- if notting is true tristat z. think this mens that itt is diskonekted
end if ;
end process;


process(clk, next_state)
begin 
--if (clk'event) then
if (clk'event and clk='0') then -- orginal
current_state <= next_state;
end if ;
end process; 
end Behavioral;
