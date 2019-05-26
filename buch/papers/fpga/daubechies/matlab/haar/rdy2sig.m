function [ out ] = rdy2sig( rdy , N)
%RDY2SIG Summary of this function goes here
%   Detailed explanation goes here

    out = ones(N, length(rdy));
    for i = 1:N
        out(i,:) = (bitand(rdy, 2^(i-1)) > 0)*i;
    end
    
    out(out == 0) = NaN;
    out = out -1;
end

