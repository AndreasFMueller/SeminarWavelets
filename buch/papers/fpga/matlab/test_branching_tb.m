t = 1:3000;
x = sin(2*pi*t/128);% + 1.2*cos(2*pi*t/40); %500

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
d0Vhdl = fromVhdlRecord('D:/Temp/d0Vector.hex');
d1Vhdl = fromVhdlRecord('D:/Temp/d1Vector.hex');
d2Vhdl = fromVhdlRecord('D:/Temp/d2Vector.hex');
d3Vhdl = fromVhdlRecord('D:/Temp/d3Vector.hex');
rdysVhdl = fromVhdlRecord('D:/Temp/rdysVector.hex');


figure(1)
plot(t, x); hold on;
plot(t, d0Vhdl, 'o');
plot(t, d1Vhdl, 'o');
plot(t, d2Vhdl, 'o');
plot(t, d3Vhdl, 'o');
plot(t, sVhdl, 'o'); hold off;
%plot(t, rdysVhdl, 'o');
legend({'x', 'd0', 'd1', 'd2', 'd3', 's','rdys'})
    
sDif = compareDelayed(repelem(s, 2), sVhdl, 2);
dDif = compareDelayed(repelem(d, 2), dVhdl, 2);



