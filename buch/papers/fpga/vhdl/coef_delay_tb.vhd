library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library work;
use work.file_util.all;

entity coef_delay_tb is
end entity;

architecture rtl of coef_delay_tb is
	constant clk_period : time := 0.01 us;
	
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
	
	signal s_delayed_vector : ram_t;
	signal d0_delayed_vector : ram_t;
	signal d1_delayed_vector : ram_t;
	signal d2_delayed_vector : ram_t;
	signal d3_delayed_vector : ram_t;
	signal rdys_delayed_vector : ram_t;
	
	signal y_vector : ram_t;
	
	signal rdy_in : std_logic;
	
	signal x : signed(15 downto 0);
	signal ds : signed((16*4)-1 downto 0);
	signal s : signed(15 downto 0);
	signal rdys : signed(3 downto 0);
	
	signal rdys_switched : signed(3 downto 0);
	
	
	signal ds_delayed : signed((16*4)-1 downto 0);
    signal s_delayed : signed(15 downto 0);
    signal rdys_delayed : signed(3 downto 0);
	
	signal y : signed(15 downto 0);

    component branching is
        generic (
            n : integer;
            nBranch : integer
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            x : in signed(n-1 downto 0);
            rdy_in : in std_logic;
            
            s : out signed(n-1 downto 0);
            ds : out signed((nBranch*n)-1 downto 0);
            rdys_out : out signed(nBranch-1 downto 0)
        );
    end component;
    
    component coef_delay is
        generic (
            n : integer;
            nBranch : integer
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            
            s_in : in signed(n-1 downto 0);
            ds_in : in signed((nBranch*n)-1 downto 0);
            rdys_in : in signed(nBranch-1 downto 0);
            
            s_out : out signed(n-1 downto 0);
            ds_out : out signed((nBranch*n)-1 downto 0);
            rdys_out : out signed(nBranch-1 downto 0)
        );
    end component;
    
    component inv_branching is
        generic (
            n : integer;
            nBranch : integer
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            
            s : in signed(n-1 downto 0);
            ds : in signed((nBranch*n)-1 downto 0);
            
            rdys_in : in signed(nBranch-1 downto 0);
            
            y : out signed(n-1 downto 0)
        );
    end component;
	
begin
  
	dut1 : component branching
		generic map (
			n => 16,
			nBranch => 4
			)
		port map (
			clk => clk,
			rst => rst,
			x => x,
			rdy_in => rdy_in,
			s => s,
			ds => ds,
			rdys_out => rdys
		);
		
		
    rdys_switched <= rdys; --(4-1-1 downto 0) & rdy_in;

	dut2 : component coef_delay
        generic map(
            n => 16,
            nBranch => 4
            )
        port map (
            clk => clk,
            rst => rst,
            
            s_in => s,
            ds_in => ds,
            rdys_in => rdys_switched,
            
            s_out => s_delayed,
            ds_out => ds_delayed,
            rdys_out => rdys_delayed
        );
        
    dut3 : component inv_branching
        generic map(
            n => 16,
            nBranch => 4
            )
        port map (
            clk => clk,
            rst => rst,
                    
            s => s_delayed,
            ds => ds_delayed,
            
            rdys_in => rdys_delayed,
            
            y => y
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
	    rdy_in <= '0';
	   
	    wait for clk_period*20;
	   
	    rdy_in <= '1';
	   
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
			
			
			s_delayed_vector(i) <= std_logic_vector(s_delayed);
			d0_delayed_vector(i) <= std_logic_vector(ds_delayed((16*1)-1 downto (16*0)));
			d1_delayed_vector(i) <= std_logic_vector(ds_delayed((16*2)-1 downto (16*1)));
			d2_delayed_vector(i) <= std_logic_vector(ds_delayed((16*3)-1 downto (16*2)));
			d3_delayed_vector(i) <= std_logic_vector(ds_delayed((16*4)-1 downto (16*3)));
			rdys_delayed_vector(i) <= (("000000000000") & std_logic_vector(rdys_delayed));
			
			y_vector(i) <= std_logic_vector(y);
			
			wait for clk_period/2;
		end loop;
		report "test finished";
		
		test_ok <= writeToFile(s_vector, "D:/Temp/sVector.hex");
        test_ok <= writeToFile(d0_vector, "D:/Temp/d0Vector.hex");
        test_ok <= writeToFile(d1_vector, "D:/Temp/d1Vector.hex");
        test_ok <= writeToFile(d2_vector, "D:/Temp/d2Vector.hex");
        test_ok <= writeToFile(d3_vector, "D:/Temp/d3Vector.hex");
        test_ok <= writeToFile(rdys_vector, "D:/Temp/rdysVector.hex");
		
		test_ok <= writeToFile(s_delayed_vector, "D:/Temp/s_delayedVector.hex");
		test_ok <= writeToFile(d0_delayed_vector, "D:/Temp/d0_delayedVector.hex");
		test_ok <= writeToFile(d1_delayed_vector, "D:/Temp/d1_delayedVector.hex");
		test_ok <= writeToFile(d2_delayed_vector, "D:/Temp/d2_delayedVector.hex");
		test_ok <= writeToFile(d3_delayed_vector, "D:/Temp/d3_delayedVector.hex");
		test_ok <= writeToFile(rdys_delayed_vector, "D:/Temp/rdys_delayedVector.hex");
		
		test_ok <= writeToFile(y_vector, "D:/Temp/yVector.hex");
		
		report "output files generated";
		wait;
	end process;
  
end rtl;