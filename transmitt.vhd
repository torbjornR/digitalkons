-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-12-04
--Project Name:   transmitt
--to do we ned an end of transmittion
--se if i can hawe smaler heddCounter  
-------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity transmitt is
    Port (  sclk    : in  STD_LOGIC;
          --  clk     : in  STD_LOGIC;  
            reset   : in  STD_LOGIC;
            datain  : in  STD_LOGIC_VECTOR (3 downto 0);  -- data to transmitt parralell
            sendin  : in  STD_LOGIC;    -- aktivate to send new data.
            sendut  : out STD_LOGIC;    -- indicates that new data to send is avalibull.
            dataut  : out STD_LOGIC);   -- outputt seriell.
            
end transmitt;

architecture arki of transmitt is
  type state_type is (idle, AutoG, send);
  signal state  : state_type;
  signal intdata : STD_LOGIC;   --
  signal tempdata : STD_LOGIC_VECTOR (3 downto 0); 
  signal clk : STD_LOGIC;
  
begin

  dataut <= intdata;
  scaledown_clock : process(sclk)
      variable clk_counter : STD_LOGIC_VECTOR (2 downto 0);
  begin
  if (reset = '1') then
    clk <= '0';
    clk_counter :=  (others => '0');
    elsif rising_edge (sclk) then
      clk_counter := clk_counter + '1';
      if (clk_counter < 2) then
        clk <= '0';
      else
        clk <= '1';
      end if;
      if (clk_counter = 3) then
        clk_counter := (others => '0'); 
      end if;
    end if; 
  end process scaledown_clock;
    
  process (clk, reset, sendin) is
    variable heddCounter  : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
begin
  if (reset = '1') then   -- reset funktion
    state <= idle;
    intdata <= '0';
else if (rising_edge (clk)) then

case state is 
-------------------idle----------------------
when idle =>
  if sendin = '1' then 
    state <= AutoG;
    tempdata <= datain;  -- red the datta buss
  end if;
-------------------AutoG---------------------
when AutoG =>
  intdata <= not intdata; -- inverts bitts every clk
  heddCounter := heddCounter + 1;
  if heddCounter = "00000010" then -- 50 synk bitts "110010"
    heddCounter := "00000000";
    state <= send;
  end if;
-------------------send----------------------
when send =>
  heddCounter := heddCounter + 1;
--start bits
  if heddCounter = "00000001" then 
    intdata <= '1';
  elsif heddCounter = "00000010" then 
    intdata <= '0';
  elsif heddCounter = "00000011" then
    intdata <= '0';
  elsif heddCounter = "00000100" then
    intdata <= '1';
-- data word 
  elsif heddCounter = "00000101" then
    intdata <= tempdata(3);
  elsif heddCounter = "00000110" then
    intdata <= tempdata(2);
  elsif heddCounter = "00000111" then
    intdata <= tempdata(1);
  elsif heddCounter = "00001000" then
    intdata <= tempdata(0);
-- end off mesage
  elsif heddCounter = "00001001" then
    state <= idle;
    heddCounter :=  "00000000";
    intdata <= '0';
    -- MABY AN END OF MESSAGE HERE.
  end if;
  
end case;
end if;
end if;
end process; 
  sendut <=   '1' when state = AutoG or state = send else
              '0';  
end arki;
