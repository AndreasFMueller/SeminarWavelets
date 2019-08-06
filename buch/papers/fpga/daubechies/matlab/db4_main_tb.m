%% setup
clear;
clc;
close all;

L = 3000; % #samples
N = 4; % depth

x_lim = 250;

%% define input signal
t = 1:L;

x = zeros(1, L);

x(1:64) = sin(2*pi*[0:64-1]/64);

x(100:150) = [1:51] / 50;
x(150:200) =[50:-1:0] / 50;

x = int16(floor(x*2^15*0.1)); %quantize x

%% set coefficients Ex: db4

h = [0.6830127, 1.1830127, 0.3169873, -0.1830127];
lenw = length(h);
g = zeros(1, lenw);
for i= 1:lenw
    g(i) = h(lenw-i+1);
end
for i = 1:floor(lenw/2)
    g(i*2) = -1*g(i*2);
end


%% Save for VHDL simulation
toVhdlRecord(x, 'D:/Temp/xVector.hex')

%% Forward DB4 transform int16

ds = cell(1, N);
xx = x;
for n = 1:N
    len = floor(length(xx)/2);
    s = int16(zeros(1, len)); %lp
    d = int16(zeros(1, len)); %hp
    for i = 2:len-1
        d(i) = xx(2*(i-1)+2) - sqrt(3)*xx(2*(i-1)+1);
        s(i) = xx(2*(i-1)+1) + sqrt(3)/4*d(i) + (sqrt(3)-2)/4*d(i+1);
        d(i) = d(i) + s(i-1);
        s(i) = (sqrt(3)+1)/sqrt(2)*s(i);
        d(i) = (sqrt(3)-1)/sqrt(2)*d(i);
    end
    ds{n} = d;
    xx = s(1:len);
end

%% Backward DB4 transform int16
ss = s;
for n = N:-1:1
    len = length(ss);
    yy = int16(zeros(1, len*2)); %lp
    dd = ds{n};
    for i = 2:len-1
       dd(i) = (sqrt(3)+1)/sqrt(2)*dd(i);
       ss(i) = (sqrt(3)-1)/sqrt(2)*ss(i);
       dd(i) = dd(i) - ss(i-1);
       yy(2*(i-1)+1) = ss(i) - sqrt(3)/4*dd(i) - (sqrt(3)-2)/4*dd(i+1);
       yy(2*(i-1)+2) = dd(i) + sqrt(3)*yy(2*(i-1)+1);
    end
    ss = yy;
end
y = yy;
 %get data from VHDL simulation
 
 %% get data from Vhdl simulation
 
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
    dsExtended{i} = delayRep( ds{i} , 2^i, -1 + (2^i)+i, L);
    dsVhdlShort{i} = extractCoefFromStream( dsVhdl{i}, i, -((2^i) +i) );
end
sExtended = delayRep( s , 2^i, -1 + (2^i)+i, L);
sVhdlShort = extractCoefFromStream( sVhdl, i, -((2^i) +i) );

yExtended = delayRep( y , 1, 25, L);

%% Plot coefficients short

figure(10)
hold on;
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

xlim([1 x_lim])

%% Plot
fig = figure(1);

ax1 =  subplot(2,1,1);

plot(t, x, 'k-'); hold on;

plot(t, dsVhdl{1}, 'g.');
plot(t, dsExtended{1}, 'g-');

plot(t, dsVhdl{2}, 'b.');
plot(t, dsExtended{2}, 'b-');

plot(t, dsVhdl{3}, 'r.');
plot(t, dsExtended{3}, 'r-');

plot(t, dsVhdl{4}, 'c.');
plot(t, dsExtended{4}, 'c-');

plot(t, sVhdl, 'm.');
plot(t, sExtended, 'm-'); hold off;

legend({'x', 'd0 Vhdl', 'd0', 'd1Vhdl', 'd1', 'd2Vhdl', 'd2', 'd3Vhdl', 'd3', 's', 'sVhdl'})
title('Coefficients')

xlim([0 x_lim])
grid

ax2 = subplot(2,1,2);
rdy_sigs = rdy2sig(rdysVhdl,4);
plot(t, rdy_sigs(1,:), 'go'); hold on;
plot(t, rdy_sigs(2,:), 'bo');
plot(t, rdy_sigs(3,:), 'ro');
plot(t, rdy_sigs(4,:), 'co'); hold off;

yticks(0:3)
yticklabels({'rdy_0' 'rdy_1' 'rdy_2' 'rdy_3'})

xlim([0 x_lim])
ylim([-0.5 3.5])
title('Ready signals')
grid

linkaxes([ax1, ax2], 'x')
subplotRatios(ax1, ax2)

%% calc difference
diffs = cell(1, N+2);
meanDiffs = zeros(1, N+2);
for i = 1:N
   diffs{i} = dsVhdl{i} - dsExtended{i};
   meanDiffs(i) = mean(abs(diffs{i}));
end
diffs{i+1} = sVhdl - sExtended;
meanDiffs(i+1) = mean(abs(diffs{i+1}));
diffs{i+2} = yVhdl - yExtended;
meanDiffs(i+2) = mean(abs(diffs{i+2}));



%% Plot diffs
% figure(2)
% title('Differences')
% for i = 1:N+2
%    plot(diffs{i}); hold on;
% end
% hold off;

% assert(meanDiffs(1) == 0, 'd0 is wrong');
% assert(meanDiffs(2) == 0, 'd1 is wrong');
% assert(meanDiffs(3) == 0, 'd2 is wrong');
% assert(meanDiffs(4) == 0, 'd3 is wrong');
% assert(meanDiffs(5) == 0, 's is wrong');
% assert(meanDiffs(6) == 0, 'y is wrong');

%% get data from vhdl simulaton
sVhdlDelayed = fromVhdlRecord('D:/Temp/s_delayedVector.hex');
dsVhdlDelayed = cell(1, N);
dsVhdlDelayed{1} = fromVhdlRecord('D:/Temp/d0_delayedVector.hex');
dsVhdlDelayed{2} = fromVhdlRecord('D:/Temp/d1_delayedVector.hex');
dsVhdlDelayed{3} = fromVhdlRecord('D:/Temp/d2_delayedVector.hex');
dsVhdlDelayed{4} = fromVhdlRecord('D:/Temp/d3_delayedVector.hex');

rdysVhdlDelayed = fromVhdlRecord('D:/Temp/rdys_delayedVector.hex');

%% adapt calculated data to fit vhdl data
for i = 1:N
    dsExtended{i} = delayRep( ds{i} , 2^i, 9+(2^4)-i, L);
end
sExtended = delayRep( s , 2^i, 9+(2^4)-i, L);

%% Plot 
fig = figure(3);
ax1 = subplot(2,1,1);

plot(t, x, 'k-'); hold on;

plot(t, dsVhdlDelayed{1}, 'g.');
plot(t, dsExtended{1}, 'g-');

plot(t, dsVhdlDelayed{2}, 'b.');
plot(t, dsExtended{2}, 'b-');

plot(t, dsVhdlDelayed{3}, 'r.');
plot(t, dsExtended{3}, 'r-');

plot(t, dsVhdlDelayed{4}, 'c.');
plot(t, dsExtended{4}, 'c-');

plot(t, sVhdlDelayed, 'm.');
plot(t, sExtended, 'm-'); hold off;

legend({'x' 'd0 Vhdl', 'd0', 'd1Vhdl', 'd1', 'd2Vhdl', 'd2', 'd3Vhdl', 'd3', 's', 'sVhdl'})
title('Coefficients delayed')
xlim([0 x_lim])
grid

ax2 = subplot(2,1,2);
rdy_sigs = rdy2sig(rdysVhdlDelayed,4);
plot(t, rdy_sigs(1,:), 'go'); hold on;
plot(t, rdy_sigs(2,:), 'bo');
plot(t, rdy_sigs(3,:), 'ro');
plot(t, rdy_sigs(4,:), 'co'); hold off;
xlim([0 x_lim])
ylim([-0.5 3.5])
yticks(0:3)
yticklabels({'rdy_0' 'rdy_1' 'rdy_2' 'rdy_3'})
grid
linkaxes([ax1, ax2], 'x')
title('Ready signals delayed')
subplotRatios(ax1, ax2)

%% Plot 
fig = figure(4);

plot(t, x, 'k-'); hold on;

 plot(t, yVhdl, 'm.');
plot(t, yExtended, 'm-'); hold off;

legend({'x',  'yVhdl', 'y'})
xlim([0 x_lim])
grid
savefig(fig, 'db4')

