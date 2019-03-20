library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.MATH_REAL.ALL;

library STD;
use STD.textio.all;

package fileUtil is

    --constant DATA_BITS : integer;
    constant DEPTH : integer;
    
    subtype word_t  is std_logic_vector(16 - 1 downto 0);
    type    ram_t   is array(0 to DEPTH - 1) of word_t;
    
    -- Read a *.hex file
    impure function ocram_ReadMemFile(FileName : STRING) return ram_t;

end fileUtil;

package body fileUtil is

    constant DATA_BITS : integer := 16;
    constant DEPTH : integer := 256;
    
    
    constant l : integer := integer(ceil( real(word_t'length)  /  4.0)) * 4;
    
    -- Read a *.hex file
    impure function ocram_ReadMemFile(FileName : STRING) return ram_t is
        file FileHandle       : TEXT open READ_MODE is FileName;
        variable CurrentLine  : LINE;
        variable TempWord     : STD_LOGIC_VECTOR(l - 1 downto 0);
        variable Result       : ram_t    := (others => (others => '0'));
    
    begin
        for i in 0 to DEPTH - 1 loop
            exit when endfile(FileHandle);
            readline(FileHandle, CurrentLine);
            hread(CurrentLine, TempWord);
            Result(i)    := resize(TempWord, word_t'length);
        end loop;
        
        return Result;
    end function;

end fileUtil;