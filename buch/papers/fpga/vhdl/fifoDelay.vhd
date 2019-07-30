library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity fifoDelay is
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
end entity;

architecture rtl of fifoDelay is

    subtype word_t  is signed(n - 1 downto 0);
    type    ram_t   is array(0 to DELAY - 1 + 1) of word_t;

    signal rdy_ram : std_logic_vector(0 to DELAY - 1 + 1);
    signal sig_ram : ram_t;

    constant PTR_WITH : integer := 32;
    
    signal y_int : signed(n-1 downto 0);
    signal rdy_out_int : std_logic;

    signal in_ptr : integer range PTR_WITH-1 downto 0;
    signal out_ptr : integer range PTR_WITH-1 downto 0;
    
    signal in_ptr_next : integer range PTR_WITH-1 downto 0;
    signal out_ptr_next : integer range PTR_WITH-1 downto 0;

begin
  
    output : process(y_int, rdy_out_int) is
    begin
        y <= y_int;
        rdy_out <= rdy_out_int;
    end process;
  
    calc: process(in_ptr, out_ptr) is
    begin 
        in_ptr_next <= in_ptr;
        out_ptr_next <= out_ptr;
    
        if in_ptr = DELAY -1 + 1 then
            in_ptr_next <= 0;
        else
            in_ptr_next <= in_ptr + 1;
        end if;
        
        if out_ptr = DELAY -1 + 1 then
            out_ptr_next <= 0;
        else
            out_ptr_next <= out_ptr + 1;
        end if;
   
    end process;
  
    registers: process(rst, clk) is
    begin
        if rst = '1' then
            in_ptr <= 0;
            out_ptr <= 1;
        elsif rising_edge(clk) then
        
           sig_ram(in_ptr) <= x;
           rdy_ram(in_ptr) <= rdy_in;
           
            y_int <= sig_ram(out_ptr);
            rdy_out_int <= rdy_ram(out_ptr);
        
            in_ptr <= in_ptr_next;
            out_ptr <= out_ptr_next;
        end if;
    end process;
end architecture rtl;