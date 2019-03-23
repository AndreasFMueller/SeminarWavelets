function [ vector ] = fromVhdlRecord( filename )

    f = fopen(filename, 'r');

    line = fgetl(f);
    
    vector = [];
    while ischar(line)
    
        line = strrep(line,'X','0');
        value = hex2dec(line);
        vector = [vector value];
        line = fgetl(f);
    end
    fclose(f);
    vector = uint16(vector);
    vector = typecast(vector, 'int16');
    
end