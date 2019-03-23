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
        
        d : out signed(n-1 downto 0);
        s : out signed(n-1 downto 0);
        rdy : out std_logic
    );
end entity;

architecture rtl of haar is
	signal x_z1 : signed(n-1 downto 0);
	signal d_int : signed(n-1 downto 0);
	signal d_int_next : signed(n-1 downto 0);
	signal s_int : signed(n-1 downto 0);
	signal s_int_next : signed(n-1 downto 0);
	signal rdy_int : std_logic;
begin
  
  output : process(d_int, rdy_int) is
  begin
    d <= d_int;
    s <= s_int;
    rdy <= rdy_int;
  end process;
  
  calc: process(x, rdy_int, d_int, x_z1) is
  begin 
    d_int_next <= d_int;
    s_int_next <= s_int;
    
	if rdy_int = '0' then
      d_int_next <= x - x_z1;
      s_int_next <= x_z1 + (x(n-1) & x(n-1 downto 1));
	end if;
  end process;
  
  registers: process(rst, clk) is
  begin
	if rst = '1' then
		x_z1 <= (others => '0');
		rdy_int <= '1';
	elsif rising_edge(clk) then
        d_int <= d_int_next;
        s_int <= s_int_next;
		x_z1 <= x;
		rdy_int <= not(rdy_int);
	end if;
  end process;
end architecture rtl;