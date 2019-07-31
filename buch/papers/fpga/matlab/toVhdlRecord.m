function [] = toVhdlRecord(vector, filename)
    assert(isa(vector,'int16'), 'input vector needs to be int16')
    f = fopen(filename, 'w');;
    fprintf(f,'%04x\n', typecast(vector, 'uint16'));
    fclose(f);
end