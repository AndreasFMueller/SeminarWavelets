library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity haar is
    generic (
        n : integer
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        x : in signed(n-1 downto 0);
        rdy_in : in std_logic;
        
        d : out signed(n-1 downto 0);
        s : out signed(n-1 downto 0);
        rdy_out : out std_logic
    );
end entity;

architecture rtl of haar is
	signal x_z1 : signed(n-1 downto 0);
	signal d_int : signed(n-1 downto 0);
	signal d_int_next : signed(n-1 downto 0);
	signal s_int : signed(n-1 downto 0);
	signal s_int_next : signed(n-1 downto 0);
	signal rdy_out_int : std_logic;
	signal rdy_out_int_next : std_logic;
	
	signal state : std_logic;
	signal state_next : std_logic;
	
begin
  
  output : process(d_int, s_int, rdy_out_int) is
  begin
    d <= d_int;
    s <= s_int;
    rdy_out <= rdy_out_int;
  end process;
  
  calc: process(x, d_int, s_int, x_z1, d_int_next, rdy_in, state) is
    variable d_int_next_div2 : signed(n-1 downto 0);
  begin 
    d_int_next <= d_int;
    s_int_next <= s_int;
    state_next <= state;
    
    rdy_out_int_next <= '0';
    
    if rdy_in = '1' then
      state_next <= not(state);
    
      if state = '1' then
        d_int_next <= x - x_z1;
        d_int_next_div2 := (d_int_next(n-1) & d_int_next(n-1 downto 1));
        s_int_next <= x_z1 + d_int_next_div2;
        rdy_out_int_next <= '1';
      end if;
    end if;
  end process;
  
  registers: process(rst, clk) is
  begin
	if rst = '1' then
		x_z1 <= (others => '0');
		d_int <= (others => '0');
        s_int <= (others => '0');
		rdy_out_int <= '0';
		state <= '0';
	elsif rising_edge(clk) then
        d_int <= d_int_next;
        s_int <= s_int_next;
		x_z1 <= x;
		rdy_out_int <= rdy_out_int_next;
		state <= state_next;
	end if;
  end process;
end architecture rtl;