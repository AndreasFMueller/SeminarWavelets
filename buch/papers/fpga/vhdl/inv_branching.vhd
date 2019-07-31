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
	
	
	signal d0 : signed(n-1 downto 0);
	signal d1 : signed(n-1 downto 0);
	signal d2 : signed(n-1 downto 0);
	signal d3 : signed(n-1 downto 0);
	
	signal s0 : signed(n-1 downto 0);
	signal s1 : signed(n-1 downto 0);
	signal s2 : signed(n-1 downto 0);
	signal s3 : signed(n-1 downto 0);
	
	signal y0 : signed(n-1 downto 0);
	signal y1 : signed(n-1 downto 0);
	signal y2 : signed(n-1 downto 0);
	signal y3 : signed(n-1 downto 0);
	
	
	
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
  
  rdys_int <= rdys_in;
  
  ds_int <= ds;
  ss_int <= s & ys_int((nBranch*n) - 1 downto n); -- replace 0 with s
  
  y <= ys_int(n - 1 downto 0);
  
  d0 <= ds_int((0*n) + n - 1 downto 0*n);
  d1 <= ds_int((1*n) + n - 1 downto 1*n);
  d2 <= ds_int((2*n) + n - 1 downto 2*n);
  d3 <= ds_int((3*n) + n - 1 downto 3*n);
  
  s0 <= ss_int((0*n) + n - 1 downto 0*n);
  s1 <= ss_int((1*n) + n - 1 downto 1*n);
  s2 <= ss_int((2*n) + n - 1 downto 2*n);
  s3 <= ss_int((3*n) + n - 1 downto 3*n);
  
  y0 <= ys_int((0*n) + n - 1 downto 0*n);
  y1 <= ys_int((1*n) + n - 1 downto 1*n);
  y2 <= ys_int((2*n) + n - 1 downto 2*n);
  y3 <= ys_int((3*n) + n - 1 downto 3*n);
  
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