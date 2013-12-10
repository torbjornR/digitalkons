-------------------------------------------------------
--Engineer:       Torbjorn Rasmusson 
--Create Date:    13-11-27
--Project Name:   manch
-------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity manch2 is
    Port (  clk     : in  STD_LOGIC;  
            reset   : in  STD_LOGIC;  
            v       : in  STD_LOGIC;  -- valid data. indicates if ther is data to send.
            d       : in  STD_LOGIC;  -- data to send.
            y       : out STD_LOGIC); -- outputt.
end manch2;

architecture state_machine of manch2 is
  type state_type is (idle, s0a, s0b, s1a, s1b);
  signal state_reg, state_next    :state_type;
begin

  process(clk, reset)
  begin 
    if (reset= '1') then 
      state_reg <= idle;
    elsif (rising_edge (clk))then
      state_reg <= state_next;
    end if;
  end process;
    process(state_reg, v, d)
    begin
      case state_reg is 
      when idle =>
        if v ='0' then            -- if ther is no data to send go to idle
          state_next <= idle;
        else                      -- if ther is data to send then do
          if d= '0' then          -- if data 0 then go to s0a
            state_next <= s0a;    
          else                    -- if data not 0 then go to s1a
            state_next <= s1a;
          end if;
        end if;
      when s0a => 
        state_next <= s0b;
      when s1a => 
        state_next <= s1b;
      when s0b => 
        if v= '0' then 
          state_next <= idle;
        else
          if d= '0' then 
            state_next <= s0a;
          else 
            state_next <= s1a;
          end if;
        end if;
      when s1b => 
        if v= '0' then 
          state_next <= idle;
        else 
          if d= '0' then 
            state_next <= s0a;
          else
            state_next <= s1a;
          end if;
        end if;
      end case;
    end process;
    
    y <=  '1' when state_reg = s1a or state_reg = s0b else
          '0';
  end state_machine;