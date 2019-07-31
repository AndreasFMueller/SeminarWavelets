function [ y ] = compareDelayed( x1, x2, delay)
%COMPAREDELAYED Summary of this function goes here
%   Detailed explanation goes here
    x1 = x1(1:end-delay);
    x2 = x2(1+delay:end);
    y = x1 - x2;
end

