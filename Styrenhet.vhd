
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Styrenhet is
    Port (  clk, reset 					  : IN STD_LOGIC;
				alert							  : IN STD_LOGIC;
				timeOut						  : IN STD_LOGIC; 
				compValue, readCompNow    : IN STD_LOGIC;
				ackAlarm						  : IN STD_LOGIC;
				count_full					  : IN STD_LOGIC;
				
				triggProcess				     : OUT STD_LOGIC;
				st, rt						  	  : OUT STD_LOGIC; -- Start and reset timer
				res_count, inc_count		 	  : OUT STD_LOGIC; -- Reset and increase counter
        notifyAlarm         			  : OUT STD_LOGIC;
				
        IDBus                    	  : IN STD_LOGIC_VECTOR(3 downto 0);
        memoryBus, collectorBus      : INOUT STD_LOGIC_VECTOR(3 downto 0));
end Styrenhet;

architecture Behavioral of Styrenhet is

	type stateType is (idle, hold, analysis, alarm);
	signal state 		            : stateType;
	signal next_state          : stateType;
	
	signal okID								        : STD_LOGIC; -- 1 if ok, 0 otherwise	
	
	signal identBusy	          : STD_LOGIC;
	signal processFailed	      : STD_LOGIC;
	
	component Identifyer is
		Port( clk, reset	  : IN STD_LOGIC;
				  IDok         : OUT STD_LOGIC;
				  busy			      : OUT STD_LOGIC;
				  memoryBus  	 : INOUT STD_LOGIC_VECTOR(3 downto 0);
				  ID           : IN STD_LOGIC_VECTOR(3 downto 0));
			
	end component;

begin
	ident : 	Identifyer	port map(clk, reset, okID, identBusy, memoryBus, IDBus);

	process(clk, reset)
	  begin
		if reset = '1' then
  		  triggProcess	<= '0';
			st <= '0';
			rt <= '0';
			res_count <= '0';
			inc_count <= '0';
      notifyAlarm <= '0';
      processFailed <= '0';
			state <= idle;
      memoryBus <= "0000";
      collectorBus <= "0000";
		elsif rising_edge(clk) then
		  state <= next_state;
		end if;
		end process;
		state_mahine:process(state)
		begin
			case state is
		------------------------------IDLE-------------------------
				when idle =>
					if alert = '1' then
					  res_count <= '1';
					  rt <= '1';
					  st <= '1';
						
						triggProcess <= '1';
						
						next_state <= hold;
					end if;
		------------------------------HOLD-------------------------
				when hold =>
				  rt <= '0';
					st <= '0';
					inc_count <= '0';
					res_count <= '0';
					
				  
					if	readCompNow = '1' and compValue = '1' then
						processFailed <= '0';
						
						next_state <= analysis;
					elsif readCompNow = '1' and compValue = '0' then
						processFailed <= '1';
						
						next_state <= analysis;
					elsif timeOut = '1' then
						processFailed <= '1';
						
						next_state <= analysis;
					end if;
					
					st <= '0';
					triggProcess <='0';
		------------------------------ANALYSIS---------------------
				when analysis =>
					if processFailed = '1' and count_full = '1' then
						res_count <= '1';
					
						next_state <= alarm;
					elsif processFailed = '1' then
						triggProcess <= '1';
						rt <= '1';
						st <= '1';
						
						inc_count <= '1';
						
						next_state <= hold;
					elsif processFailed = '0' then
						next_state <= idle;
					end if;
					
					processFailed <= '0';
		------------------------------ALARM-------------------------
				when alarm =>
					notifyAlarm <= '1';
					
					if ackAlarm = '1' then
						notifyAlarm <= '0';
						next_state <= idle;
					end if;
				when others =>
					--What now?
			end case;

    end process;

end Behavioral;