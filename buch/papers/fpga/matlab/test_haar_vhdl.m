t = 1:3000;
x = sin(2*pi*t/500);% + 1.2*cos(2*pi*t/40);

x = int16(floor(x*2^15*0.1)); %quantize x

% x(1:2000) = zeros(1,2000);
% x(501+348:1000+348) = [(1:250) (250:-1:1)]/250;

toVhdlRecord(x, 'D:/Temp/xVector.hex')

%%

len = ceil(length(x)/2);
s = int16(zeros(1, len)); % lp
d = int16(zeros(1, len)); % hp
for i = 1:len
    s(i) = x(2*(i-1)+1);
    d(i) = x(2*(i-1)+2);
    d(i) = d(i) - s(i);
    s(i) = s(i) + idivide(d(i),2, 'floor');
end


%% compare with vhdl
sVhdl = fromVhdlRecord('D:/Temp/sVector.hex');
dVhdl = fromVhdlRecord('D:/Temp/dVector.hex');

figure(1)
plot(t, x); hold on;
plot(t, repelem(s, 2));
plot(t, repelem(d, 2));
plot(t, sVhdl, 'o');
plot(t, dVhdl, 'o'); hold off;
legend({'x', 's' 'd','sVhdl', 'dVhdl'})
    
sDif = compareDelayed(repelem(s, 2), sVhdl, 2);
dDif = compareDelayed(repelem(d, 2), dVhdl, 2);

%%

figure(2)
title('Differences')
plot(sDif); hold on;
plot(dDif); hold off;

assert(all(dDif == 0), 'd is wrong');
assert(all(sDif == 0), 's is wrong');

