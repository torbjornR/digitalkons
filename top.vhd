-------------------------------------------------------
--Engineer:       
--Create Date:    13-12-10
--Project Name:   top
--do we ned an end of transmittion
--se if i can hawe smaler heddCounter  
-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity vhdltop is
Port ( clk : in STD_LOGIC;
resin : in STD_LOGIC;
din : in STD_LOGIC_VECTOR (2 downto 0);
dav : in STD_LOGIC;
borrnere : in STD_LOGIC;
borruppe : in STD_LOGIC;
refpos : in STD_LOGIC;
oe : out STD_LOGIC;
steg : out STD_LOGIC;
framback : out STD_LOGIC;
borrmotor : out STD_LOGIC;
solenoid : out STD_LOGIC;
larm : out STD_LOGIC;
d1,d2,d3: OUT STD_LOGIC);
end vhdltop;

architecture Behavioral of vhdltop is
 --------------------------- 
component sync is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
levin : in STD_LOGIC;
sync : out STD_LOGIC);
end component;
----------------------------
component lev2puls is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
levin : in STD_LOGIC;
pulson : out STD_LOGIC);
end component;
signal levin,puls,reset: std_logic;
signal dut: std_LOGIC_VECTOR(7 downto 0);
begin
reset <= not resin;
-----

x1: sync port map (clk,reset, dav, levin);
x2: lev2puls port map(clk,reset,levin,puls);
x3: decoder38e port map(din,puls,dut);
x4: puls2lev port map(clk,reset,dut(0),dut(1),borrmotor);
x5: puls2lev port map(clk,reset,dut(2),dut(3),solenoid);
end Behavioral;