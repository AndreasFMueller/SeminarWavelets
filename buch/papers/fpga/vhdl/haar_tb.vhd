library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library work;
use work.file_util.all;

entity haar_tb is
end entity;

architecture rtl of haar_tb is
	constant clk_period : time := 0.01 us;
	
	--constant DEPTH : integer := 128;
	
	--subtype sig_type is signed(16-1 downto 0);
    --type    sig_array   is array(0 to DEPTH - 1) of sig_type;

    signal test_ok : boolean := false;

    signal t : integer := 0;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	
	signal x_vector : ram_t;
	signal s_vector : ram_t;
	signal d_vector : ram_t;
	
	signal x : signed(15 downto 0);
	signal d : signed(15 downto 0);
	signal s : signed(15 downto 0);
	signal rdy : std_logic;

	component haar is
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
			rdy_in => '1',

			d => d,
			s => s,
			rdy_out => rdy
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
	   
	    report "Loading file";
	    x_vector <= readFromFile("D:/Temp/xVector.hex");
	   
	    x <= (others => '0');
	   
	    wait for clk_period*20;
	   
		for i in 0 to DEPTH-1 loop
		    t <= i;
			x <= signed(x_vector(i));
			wait for clk_period/2;
			s_vector(i) <= std_logic_vector(s);
			d_vector(i) <= std_logic_vector(d);
			wait for clk_period/2;
		end loop;
		report "test finished";
		test_ok <= writeToFile(s_vector, "D:/Temp/sVector.hex");
		test_ok <= writeToFile(d_vector, "D:/Temp/dVector.hex");
		report "output files generated";
		wait;
	end process;
  
end rtl;