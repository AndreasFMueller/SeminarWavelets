library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library work;
use work.file_util.all;

entity branching_tb is
end entity;

architecture rtl of branching_tb is
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
	signal d0_vector : ram_t;
	signal d1_vector : ram_t;
	signal d2_vector : ram_t;
	signal d3_vector : ram_t;
	signal rdys_vector : ram_t;
	
	signal x : signed(15 downto 0);
	signal ds : signed((16*4)-1 downto 0);
	signal s : signed(15 downto 0);
	signal rdys : signed(3 downto 0);

    component branching is
        generic (
            n : integer;
            nBranch : integer
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            x : in signed(n-1 downto 0);
            
            s : out signed(n-1 downto 0);
            ds : out signed((nBranch*n)-1 downto 0);
            rdys_out : out signed(nBranch-1 downto 0)
        );
    end component;
	
begin
  
	dut : component branching
		generic map (
			n => 16,
			nBranch => 4
			)
		port map (
			clk => clk,
			rst => rst,
			x => x,
			s => s,
			ds => ds,
			rdys_out => rdys
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
			d0_vector(i) <= std_logic_vector(ds((16*1)-1 downto (16*0)));
			d1_vector(i) <= std_logic_vector(ds((16*2)-1 downto (16*1)));
			d2_vector(i) <= std_logic_vector(ds((16*3)-1 downto (16*2)));
			d3_vector(i) <= std_logic_vector(ds((16*4)-1 downto (16*3)));
			
			rdys_vector(i) <= (("000000000000") & std_logic_vector(rdys));
			wait for clk_period/2;
		end loop;
		report "test finished";
		test_ok <= writeToFile(s_vector, "D:/Temp/sVector.hex");
		test_ok <= writeToFile(d0_vector, "D:/Temp/d0Vector.hex");
		test_ok <= writeToFile(d1_vector, "D:/Temp/d1Vector.hex");
		test_ok <= writeToFile(d2_vector, "D:/Temp/d2Vector.hex");
		test_ok <= writeToFile(d3_vector, "D:/Temp/d3Vector.hex");
		test_ok <= writeToFile(rdys_vector, "D:/Temp/rdysVector.hex");
		report "output files generated";
		wait;
	end process;
  
end rtl;