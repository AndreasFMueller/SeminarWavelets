L = 3000;
N = 4;

%% Define input signal
t = 1:L;
x = sin(2*pi*t/128);% + 1.2*cos(2*pi*t/40); %500

x = x+(t/1000);

x = int16(floor(x*2^15*0.1)); %quantize x

% x(1:2000) = zeros(1,2000);
% x(501+348:1000+348) = [(1:250) (250:-1:1)]/250;

%% Save for vhdl simulation
toVhdlRecord(x, 'D:/Temp/xVector.hex')

%% Forward wavelet transform int16
ds = cell(1, N);
xx = x;
for n = 1:N
    len = floor(length(xx)/2);
    s = int16(zeros(1, len)); % lp
    d = int16(zeros(1, len)); % hp
    for i = 1:len
        s(i) = xx(2*(i-1)+1);
        d(i) = xx(2*(i-1)+2);
        d(i) = d(i) - s(i);
        s(i) = s(i) + idivide(d(i),2, 'floor');
    end
    ds{n} = d;
    xx = s(1:len);
end

%% Backward wavelet transform int16
ss = s;
for n = N:-1:1
    len = length(ss);
    yy = int16(zeros(1, len*2)); % lp;
    dd = ds{n};
    for i = 1:len
        ss(i) = ss(i) - idivide(dd(i),2, 'floor');
        dd(i) = dd(i) + ss(i);
        yy(2*(i-1)+2) = dd(i);
        yy(2*(i-1)+1) = ss(i);
    end
    ss = yy;
end
y = yy;

%% get data from vhdl simulaton
sVhdl = fromVhdlRecord('D:/Temp/sVector.hex');
dsVhdl = cell(1, N);
dsVhdl{1} = fromVhdlRecord('D:/Temp/d0Vector.hex');
dsVhdl{2} = fromVhdlRecord('D:/Temp/d1Vector.hex');
dsVhdl{3} = fromVhdlRecord('D:/Temp/d2Vector.hex');
dsVhdl{4} = fromVhdlRecord('D:/Temp/d3Vector.hex');

yVhdl = fromVhdlRecord('D:/Temp/yVector.hex');

rdysVhdl = fromVhdlRecord('D:/Temp/rdysVector.hex');

%% adapt calculated data to fit vhdl data
dsExtended = cell(1, N);
dsVhdlShort = cell(1, N);
for i = 1:N
    dsExtended{i} = delayRep( ds{i} , 2^i, -2 + (2^i)+i, L);
    dsVhdlShort{i} = extractCoefFromStream( dsVhdl{i}, i, -((2^i) +i) );
end
sExtended = delayRep( s , 2^i, -2 + (2^i)+i, L);
sVhdlShort = extractCoefFromStream( sVhdl, i, -((2^i) +i) );

yExtended = delayRep( y , 1, (2^1)+1, L);

%% Plot coefficients short
figure(1)
subplot(2,1,1)

plot(dsVhdlShort{1}, 'o'); hold on;
plot(ds{1});
plot(dsVhdlShort{2}, 'o');
plot(ds{2});
plot(dsVhdlShort{3}, 'o');
plot(ds{3});
plot(dsVhdlShort{4}, 'o');
plot(ds{4});
plot(sVhdlShort, 'o');
plot(s); hold off;

legend({'d0 vhdl', 'd0', 'd1vhdl', 'd1', 'd2vhdl', 'd2', 'd3vhdl', 'd3', 's', 'svhdl'})
title('coefficients short')

% xlim([1 100])

%% Plot 
figure(1)
subplot(2,1,2)

plot(t, x, 'k-'); hold on;

plot(t, dsVhdl{1}, 'go');
plot(t, dsExtended{1}, 'g-');

plot(t, dsVhdl{2}, 'bo');
plot(t, dsExtended{2}, 'b-');

plot(t, dsVhdl{3}, 'ro');
plot(t, dsExtended{3}, 'r-');

plot(t, dsVhdl{4}, 'co');
plot(t, dsExtended{4}, 'c-');

plot(t, sVhdl, 'mo');
plot(t, sExtended, 'm-');

plot(t, sVhdl, 'ro');
plot(t, sExtended, 'r-'); hold off;

legend({'x', 'd0 Vhdl', 'd0', 'd1Vhdl', 'd1', 'd2Vhdl', 'd2', 'd3Vhdl', 'd3', 's', 'sVhdl', 'y', 'yVhdl'})
title('coefficients extended')

% xlim([0 100])

%% calc difference
diffs = cell(1, N+1);
for i = 1:N
   diffs{i} = dsVhdl{i} - dsExtended{i};
end
diffs{i+1} = sVhdl - sExtended;
diffs{i+2} = yVhdl - yExtended;

%% Plot diffs
figure(2)
title('Differences')
for i = 1:N+2
   plot(diffs{i}); hold on;
end
hold off;
