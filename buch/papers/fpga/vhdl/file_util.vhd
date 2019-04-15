library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.MATH_REAL.ALL;

library STD;
use STD.textio.all;

package file_util is
    
    constant DEPTH : integer := 3000;
    constant DATA_BITS : integer := 16;

    subtype word_t  is std_logic_vector(DATA_BITS - 1 downto 0);
    type    ram_t   is array(0 to DEPTH - 1) of word_t;
    
    -- Read a *.hex file
    impure function readFromFile(FileName : STRING) return ram_t;
    impure function writeToFile(input : ram_t; FileName : STRING) return boolean;

end file_util;

package body file_util is
    
    --constant DEPTH : integer := 256;
    --constant DATA_BITS : integer := 16;
    
    constant len : integer := integer(ceil( real(word_t'length)  /  4.0)) * 4;
    
    -- Read a *.hex file
    impure function readFromFile(FileName : STRING) return ram_t is
        file FileHandle       : TEXT open READ_MODE is FileName;
        variable CurrentLine  : LINE;
        variable TempWord     : STD_LOGIC_VECTOR(len - 1 downto 0);
        variable Result       : ram_t    := (others => (others => '0'));
    
    begin
        for i in 0 to DEPTH - 1 loop
            exit when endfile(FileHandle);
            readline(FileHandle, CurrentLine);
            hread(CurrentLine, TempWord);
            Result(i)    := TempWord; --resize(TempWord, word_t'length);
        end loop;
        
        return Result;
    end function;
    
   impure function writeToFile(input : ram_t; FileName : STRING) return boolean is
        file FileHandle       : TEXT open WRITE_MODE is FileName;
        variable CurrentLine  : LINE;
        variable TempWord     : STD_LOGIC_VECTOR(len - 1 downto 0);    
    begin
        for i in 0 to DEPTH - 1 loop
            TempWord := input(i);
            hwrite(CurrentLine, TempWord);
            writeline(FileHandle ,CurrentLine);
        end loop;
        
        return true; --sadly, there are no impure procedures, so i need to return something 

    end function;

end file_util;