function [] = toVhdlRecord(vector, filename)
    assert(isa(vector,'int16'), 'input vector needs to be int16')
    f = fopen(filename, 'w');
    fprintf(f,'%04x\n', uint16(vector));
    fclose(f);
end