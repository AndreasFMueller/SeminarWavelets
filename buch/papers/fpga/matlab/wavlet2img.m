function [ im ] = wavlet2img( wa, wb)
%WAVLET2IMG Summary of this function goes here
%   Detailed explanation goes here

M = size(wa{1}, 2) * 2;
N = size(wa, 2);

im = ones(N, M);
for i = 1:N
%     c = sqrt(wa{i}.^2 + wb{i}.^2);
    c = wa{i};
%     x = interp(c,2^(i+0)); 
    x = repelem(c, 2^(i+0));
    x = x /(2^i);
    im(i,:) = x;
end

end

