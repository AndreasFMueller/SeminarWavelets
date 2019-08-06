function [ y ] = delayRep( x , rep, delay, padTo)
%DELAYREP Summary of this function goes here
%   Detailed explanation goes here

    y = repelem(x, rep);
    
    if delay >= 0
        y = [zeros(1, delay) y];
    else
        y = y(1-delay:end);
    end
    
    len = length(y);
    if len < padTo
       y = [y zeros(1, padTo - len)];
    else
        y = y(1:padTo);
    end

end

