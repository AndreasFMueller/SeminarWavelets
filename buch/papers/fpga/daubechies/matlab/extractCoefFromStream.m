function [ y ] = extractCoefFromStream( x, i, delay)
%EXTRACTCOEFFROMSTREAM Summary of this function goes here
%   Detailed explanation goes here

    x = x(1-delay: end);
    y = downsample(x, 2^i);

end

