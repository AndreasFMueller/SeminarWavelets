library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

use work.file_util.all;

entity haar_tb is
end entity;

architecture rtl of haar_tb is

	constant clk_period : time := 0.01 us;
	
	constant DEPTH : integer := 128;
	
	subtype sig_type is signed(16-1 downto 0);
    type    sig_array   is array(0 to DEPTH - 1) of sig_type;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	
	signal inputSigs : sig_array;
	signal s_exp : sig_array;
	signal d_exp : sig_array;
	
	signal x : sig_type;
	signal d : sig_type;
	signal s : sig_type;
	signal rdy : std_logic;

	component haar is
		generic (
			n : integer
		);
		port (
			clk : in std_logic;
			rst : in std_logic;
			x : in sig_type;
			
			d : out sig_type;
			s : out sig_type;
			rdy : out std_logic
		);
	end component;
	
begin
  
	dut : component haar
		generic map (
			n => 16
			)
		port map (
			clk => clk,
			rst => rst,
			x => x,

			d => d,
			s => s,
			rdy => rdy
		);

	clk <= not clk after clk_period/2;

	reset_stimuli : process
	begin
		rst <= '1';
		wait for clk_period*10;
		rst <= '0';
		wait;
	end process;

	test_stimuli: process
	begin
		for i in 0 to DEPTH-1 loop
			x <= inputSigs(i);
			wait for clk_period/2;
			assert (s = s_exp(i)) report "s is wrong" severity error;
			assert (d = d_exp(i)) report "d is wrong" severity error;
			wait for clk_period/2;
		end loop;
		report "test finished successfully"; 
	end process;
  
end rtl;