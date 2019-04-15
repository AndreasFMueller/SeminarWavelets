library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity inv_branching is
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
end inv_branching;

architecture rtl of inv_branching is

	signal rdys_int : signed(nBranch-1 downto 0);
	
	signal ds_int : signed((nBranch*n)-1 downto 0);
	signal ss_int : signed((nBranch*n)-1 downto 0);
	
	signal ys_int : signed((nBranch*n)-1 downto 0);
	
	component inv_haar is
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
    end component;
	
begin
  
  rdys_int <= (rdys_in(nBranch-1-1 downto 0) & "1");
  
  ds_int <= ds;
  ss_int <= s & ys_int((nBranch*n) - 1 downto n);
  
  y <= ys_int(n - 1 downto 0);
  
  instances : for i in 0 to nBranch-1 generate
      inv_haar_n : inv_haar
      generic map (
          n => n
          )
      port map (
          clk => clk,
          rst => rst,

          d => ds_int((i*n) + n - 1 downto i*n),
          s => ss_int((i*n) + n - 1 downto i*n),
          rdy_in => rdys_int(i),
          
          y => ys_int((i*n) + n - 1 downto i*n)
      );
      
   end generate instances;

end architecture rtl;