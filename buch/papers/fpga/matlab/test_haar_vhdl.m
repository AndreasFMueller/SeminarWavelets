L = 3000;


%% Define input signal
t = 1:L;
x = sin(2*pi*t/500);% + 1.2*cos(2*pi*t/40);



x = int16(floor(x*2^15*0.1)); %quantize x

% x(1:2000) = zeros(1,2000);
% x(501+348:1000+348) = [(1:250) (250:-1:1)]/250;

%% Save for vhdl simulation
toVhdlRecord(x, 'D:/Temp/xVector.hex')

%% Forward single wavelet transform int16
len = ceil(length(x)/2);
s = int16(zeros(1, len)); % lp
d = int16(zeros(1, len)); % hp
for i = 1:len
    s(i) = x(2*(i-1)+1);
    d(i) = x(2*(i-1)+2);
    d(i) = d(i) - s(i);
    s(i) = s(i) + idivide(d(i),2, 'floor');
end

%% Backward single wavelet transform int16
len = length(ss);
yy = int16(zeros(1, len*2)); % lp
dd = d;
ss = s;
for i = 1:len
    ss(i) = ss(i) - idivide(dd(i),2, 'floor');
    dd(i) = dd(i) + ss(i);
    yy(2*(i-1)+2) = dd(i);
    yy(2*(i-1)+1) = ss(i);
end
y = yy;

%% get data from vhdl simulaton
sVhdl = fromVhdlRecord('D:/Temp/sVector.hex');
dVhdl = fromVhdlRecord('D:/Temp/dVector.hex');
yVhdl = fromVhdlRecord('D:/Temp/yVector.hex');

%% adapt calculated data to fit vhdl data
dExtended = delayRep( d , 2^1, -2 + (2^1)+1, L);
dVhdlShort = extractCoefFromStream( dVhdl, 1, -((2^1) +1) );
sExtended = delayRep( s , 2^1, -2 + (2^1)+1, L);
sVhdlShort = extractCoefFromStream( sVhdl, 1, -((2^1) +1) );

yExtended = delayRep( y , 1, (2^1)+1, L);

%% Plot coefficients short
figure(1)
plot(t, x, 'k-'); hold on;

plot(t, dVhdl, 'go');
plot(t, dExtended, 'g-');

plot(t, sVhdl, 'bo');
plot(t, sExtended, 'b-');

plot(t, yVhdl, 'ko');
plot(t, yExtended, 'kx'); hold off;

legend({'x', 'dVhdl', 'd', 'sVhdl', 's', 'yVhdl', 'y'})

%% calc difference

d_diff = dVhdl - dExtended;
s_diff = sVhdl - sExtended;
y_diff = yVhdl - yExtended;

%% Plot diffs

figure(2)
title('Differences')
plot(d_diff); hold on;
plot(s_diff);
plot(y_diff); hold off;

assert(all(d_diff == 0), 'd is wrong');
assert(all(s_diff == 0), 's is wrong');
assert(all(y_diff == 0), 's is wrong');

