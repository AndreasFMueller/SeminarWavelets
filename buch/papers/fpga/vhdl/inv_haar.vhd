library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity inv_haar is
    generic (
        n : integer
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        
        d : in signed(n-1 downto 0);
        s : in signed(n-1 downto 0);
        rdy_in : in std_logic;
        
        y : out signed(n-1 downto 0)
    );
end entity;

architecture rtl of inv_haar is
	signal y_int : signed(n-1 downto 0);
	signal y_int_next : signed(n-1 downto 0);
	
	signal state : std_logic;
	signal state_next : std_logic;
	
begin
  
  output : process(y_int) is
  begin
    y <= y_int;
  end process;
  
  calc: process(s, d, rdy_in, state, y_int) is
    variable d_div2 : signed(n-1 downto 0);
  begin 
    y_int_next <= y_int;
    state_next <= state;
    
    if rdy_in = '1' then
      state_next <= not(state);
    
      if state = '1' then
        d_div2 := (d(n-1) & d(n-1 downto 1));
        y_int_next <= s - d_div2;
      else
        y_int_next <= y_int + d;
      end if;
    end if;
  end process;
  
  registers: process(rst, clk) is
  begin
	if rst = '1' then
        y_int <= (others => '0');
		state <= '0';
	elsif rising_edge(clk) then
        y_int <= y_int_next;
		state <= state_next;
	end if;
  end process;
end architecture rtl;