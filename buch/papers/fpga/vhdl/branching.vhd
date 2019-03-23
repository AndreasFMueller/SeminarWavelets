library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity branching is
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
end branching;

architecture rtl of branching is
	signal x_z1 : signed(n-1 downto 0);
	
	signal xs_int : signed((nBranch*n)-1 downto 0);
	signal ds_int : signed((nBranch*n)-1 downto 0);
	signal ss_int : signed((nBranch*n)-1 downto 0);
	signal rdys_int : signed(nBranch+1-1 downto 0);
	
	signal state : std_logic;
	signal state_next : std_logic;
	
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
  
  ds <= ds_int;
  s <= ss_int((nBranch*n) - 1 downto ((nBranch-1)*n));
  rdys_out <= rdys_int(nBranch+1-1 downto 1);
  
  xs_int <= (ss_int(((nBranch-1)*n)-1 downto 0) & x);
  rdys_int(0) <= '1';
  
  instances : for i in 0 to nBranch-1 generate
      haar_n : haar
      generic map (
          n => n
          )
      port map (
          clk => clk,
          rst => rst,
          x => xs_int((i*n) + n - 1 downto i*n),
          rdy_in => rdys_int(i),

          d => ds_int((i*n) + n - 1 downto i*n),
          s => ss_int((i*n) + n - 1 downto i*n),
          rdy_out => rdys_int(i+1)
      );
   end generate instances;

end architecture rtl;