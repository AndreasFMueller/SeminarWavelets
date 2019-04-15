library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity coef_delay is
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
end coef_delay;

architecture rtl of coef_delay is
	
	component fifoDelay is
        generic (
            n : integer;
            DELAY : integer
        );
        port (
            clk : in std_logic;
            rst : in std_logic;
            
            x : in signed(n-1 downto 0);
            rdy_in : in std_logic;
            
            y : out signed(n-1 downto 0);
            rdy_out : out std_logic
        );
    end component;
    
    -- Precalc delays
    type delays_type is array(0 to nBranch - 1) of integer;
    
    function delays_init return delays_type is
        variable temp : delays_type;
    begin
        forLoop: for i in 0 to nBranch - 1 loop
            temp(i) := ((2**nBranch)+nBranch-1) - ((2**(i+1))+((i*2))) + nBranch;
        end loop;
        return temp;
    end function delays_init;
    
	constant delays : delays_type := delays_init;
	
begin
  
  instances : for i in 0 to nBranch-1 generate
      fifoDelay_n : fifoDelay
      generic map (
          n => n,
          DELAY => delays(i)
          )
      port map (
          clk => clk,
          rst => rst,
          x => ds_in((i*n) + n - 1 downto i*n),
          rdy_in => rdys_in(i),

          y => ds_out((i*n) + n - 1 downto i*n),
          rdy_out => rdys_out(i)
      );
   end generate instances;
   
   fifoDelay_s : fifoDelay
     generic map (
         n => n,
         DELAY => delays(nBranch-1)
         )
     port map (
         clk => clk,
         rst => rst,
         x => s_in,
         rdy_in => rdys_in(nBranch-1),

         y => s_out,
         rdy_out => open
     );

end architecture rtl;