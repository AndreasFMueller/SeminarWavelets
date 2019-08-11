L = 3000;
N = 4;


x_lim = 300;

%% Define input signal
t = 1:L;

x = zeros(1, L);


x(1:64) = sin(2*pi*[0:64-1]/64);% + 1.2*cos(2*pi*t/40); %500

x(90:140) = [1:51] / 50;
x(140:190) = [50:-1:0]/50;
x(230:261) = [1];

% x = x+(t/1000);

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
    dsExtended{i} = delayRep( ds{i} , 2^i, -1 + (2^i)+i, L);
    dsVhdlShort{i} = extractCoefFromStream( dsVhdl{i}, i, -((2^i) +i) );
end
sExtended = delayRep( s , 2^i, -1 + (2^i)+i, L);
sVhdlShort = extractCoefFromStream( sVhdl, i, -((2^i) +i) );

yExtended = delayRep( y , 1, 25, L);

%% Plot coefficients short
figure(10)


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
% figure(1);
ax1 =  subplot(2,1,1);

plot(t, x, 'k-'); hold on;

plot(t, dsVhdl{1}, 'g.', 'MarkerSize',10);
plot(t, dsExtended{1}, 'g-', 'MarkerSize',10);

plot(t, dsVhdl{2}, 'b.', 'MarkerSize',10);
plot(t, dsExtended{2}, 'b-', 'MarkerSize',10);

plot(t, dsVhdl{3}, 'r.', 'MarkerSize',10);
plot(t, dsExtended{3}, 'r-', 'MarkerSize',10);

plot(t, dsVhdl{4}, 'c.', 'MarkerSize',10);
plot(t, dsExtended{4}, 'c-', 'MarkerSize',10);

plot(t, sVhdl, 'm.', 'MarkerSize',10);
plot(t, sExtended, 'm-', 'MarkerSize',10); hold off;

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
saveFig(fig, "coefs")

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


%% Delay chain

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
% figure(3);
ax1 = subplot(2,1,1);

plot(t, x, 'k-'); hold on;

plot(t, dsVhdlDelayed{1}, 'g.', 'MarkerSize',10);
plot(t, dsExtended{1}, 'g-', 'MarkerSize',10);

plot(t, dsVhdlDelayed{2}, 'b.', 'MarkerSize',10);
plot(t, dsExtended{2}, 'b-', 'MarkerSize',10);

plot(t, dsVhdlDelayed{3}, 'r.', 'MarkerSize',10);
plot(t, dsExtended{3}, 'r-', 'MarkerSize',10);

plot(t, dsVhdlDelayed{4}, 'c.', 'MarkerSize',10);
plot(t, dsExtended{4}, 'c-', 'MarkerSize',10);

plot(t, sVhdlDelayed, 'm.', 'MarkerSize',10);
plot(t, sExtended, 'm-', 'MarkerSize',10); hold off;

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

saveFig(fig, "coefs_delayed")

%% Plot 
fig = figure(4);
% figure(4);

plot(t, x, 'k-', 'MarkerSize',10); hold on;

plot(t, yVhdl, 'm.', 'MarkerSize',10);
plot(t, yExtended, 'm-', 'MarkerSize',10); hold off;

legend({'x',  'yVhdl', 'y'})
xlim([0 x_lim])
grid

saveFig(fig, "output")
