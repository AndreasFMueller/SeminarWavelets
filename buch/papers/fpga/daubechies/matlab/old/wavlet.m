function [ wa, wb ] = wavlet( s, N, hp, lp )
%WAVELET Summary of this function goes here
%   Detailed explanation goes here

wa = cell(1, N);
wb = cell(1, N);
figure(2)
for i = 1:N
    a = conv(s, hp);
    a = downsample([0, a], 2);
    wa{i} = a(2:end);
    
    b = conv(s, lp);
    b = downsample([0, b], 2);
    wb{i} = b(2:end);
    
    plot(repelem(wa{i}, 2^i))
    hold on;
    
    
    
    s = b(2:end);
end
hold off

end

