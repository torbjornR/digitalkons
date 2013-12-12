-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-12-10
--Project Name:   resiver
-------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity resiver is
    Port (  clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            datain  : in  STD_LOGIC;    -- data to transmitt parralell
            eom     : out STD_LOGIC;
            dataut  : out STD_LOGIC_VECTOR);   -- outputt seriell.
            
end resiver;

architecture arki of resive is
  type state_type is (s00, s01, s10, s11, s20, s21, s30, s31, res);
  signal state        : state_type;
  signal next_state   : state_type;
  signal resiv        : STD_LOGIC_VECTOR (3 downto 0);
  signal temp         : STD_LOGIC_VECTOR (1 downto 0);
  signal manch_count  : STD_LOGIC_VECTOR (1 downto 0);
  signal mesage       : STD_LOGIC_VECTOR (3 downto 0); 
  

begin
  state_switch:process(clk, reset)
  begin
    if reset = '1' then
      state <= s00;
      eom <= '0';
      mesage  <= "0000"; 
    elsif (rising_edge (clk))then
      state <= next_state;
      temp <= temp (1 downto 0) & datain ;
    end if;
  end process;
  
  state_machine:process(state)
  --start bitt is 1001 and in manchester 10010110
    case state is
--------------------s00--------------------------
      when s00 =>
        if datain = '1';
          next_state <= s01;
        else
          next_state <= s00;
--------------------s01--------------------------
      when s01 =>
        if datain = '0';
          next_state <= s10;
        else
          next_state <= s01;
--------------------s10--------------------------
      when s10 =>
        if datain = '0';
          next_state <= s11;
        else
          next_state <= s01;
--------------------s11--------------------------
      when s11 =>
        if datain = '1';
          next_state <= s20;
        else
          next_state <= s00;
--------------------s20--------------------------
      when s20 =>
        if datain = '0';
          next_state <= s21;
        else
          next_state <= s01;
--------------------s21--------------------------
      when s21 =>
        if datain = '1';
          next_state <= s30;
        else
          next_state <= s00;
--------------------s30--------------------------
      when s30 =>
        if datain = '1';
          next_state <= s31;
        else
          next_state <= s10;
--------------------s31--------------------------
      when s31 =>
        if datain = 'res';
          next_state <= resiv; --till lagra bit
        else
          next_state <= s01;
--------------------resiv------------------------
      when resiv =>
        manch_count <= manch_count + '1';
        
        if manch_count = "10" then
      
          case temp(1 downto 0) is
          when "10" =>
            mesege <= mesege & '1';
            mesege_counter <= mesage_counter + '1';
          when "01" =>
            mesege <= metege & '0';
            mesege_counter <= mesage_counter + '1';
          when others =>
            mesege_counter <= mesage_counter + '1';
          end case;
        end if;
        if mesege_counter = "0100" then -- change to "1000" if we nede 8 bit.
          state <= meseg_complete;
          dataout <= mesage;
          eom <= '1';
        end if;
        
        when meseg_complete =>
          eom <= '0';
        end case;
end arki;

