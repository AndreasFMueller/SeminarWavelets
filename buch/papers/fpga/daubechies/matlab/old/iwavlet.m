function [ f ] = iwavlet( wa, wb, N, hp, lp )
%IWAVLET Summary of this function goes here
%   Detailed explanation goes here

f = zeros(1,size(wa{N},2));
% figure(2)
for i = 1:N
    f = repelem(f,2);
    a = wa{N-i+1};
    a = conv(upsample(a, 2), -hp);
    b = wb{N-i+1};
    b = conv(upsample(b, 2), -lp);
    c = a + b;
    f = f + c(1:end-1);
%     plot(f)
end
f = f/2;
end

