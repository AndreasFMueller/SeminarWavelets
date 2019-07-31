
% f = audioread('test.wav');
f = audioread('piano.mp3');


f = f(1:300000,1);
ff = f;


hp = [1 -1];
lp = [1  1];

N = 10;


%% forward transform

wavT = cell(1, N);
for i = 1:N
    a = conv(f, hp);
    wavT{i} = downsample(a,2);
    b = conv(f, lp);
    f = downsample(b,2);
end

%% plot

figure(1)

for i = 1:N
    a = wavT{i};
    factor =  2^(i-1)
    t = (1:length(a)) *factor;
    plot (t, a + (i*10)); hold on;
end
hold off;



%% backward transform

g = zeros(length(wavT{end}), 1);
for i = N:-1:1
    g = repelem(g,2);
    a = wavT{i};
    b = conv(upsample(a,2), hp);
    
    b = b / (2^i);
    
    len = min(length(g), length(b));
    g = g(1:len) + b(1:len);
end

%% Plot signals

figure(2)
plot(g); hold on;
plot(ff+0.1); hold off;

%%


% original = audioplayer(ff, 44100);
% play(original);
% 
% pause

altered = audioplayer(g, 44100);
play(altered);

