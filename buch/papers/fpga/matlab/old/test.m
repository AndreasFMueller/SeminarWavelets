
%https://en.wikipedia.org/wiki/Lifting_scheme
%http://wavelets.org/schemes-lifting.php
%https://www.dsprelated.com/freebooks/sasp/Polyphase_Decomposition.html





%% create signal



M = 2048;
N = log2(M);

t = 0:M-1;
s = sin(2*pi*t* 1/32) +   sin(2*pi*t* 1/1024);% + sin(2*pi*t* 1/32);


aud = audioread('piano.mp3');
s = aud(1:2^16, 1)';

M = length(s);
N = log2(M);


t = 0:M-1;

%% Plot signal
figure(1)
subplot(3,1,1)
plot(t, s)
xlim([0, M-1])
grid;

%% Define Mother and Vater Wavlet 
lp = [1 1];
hp = [-1 1];

%% Forward transform
[wa, wb] = wavlet(s, N, hp, lp);

%% Show
im2 = wavlet2img(wa, wb);
size(im2)
im = imresize(im2,[N*200 size(im2,2)]);
figure(1)
subplot(3,1,2)
imshow(im(:, :), [])

%% Backward transform

f = iwavlet(wa, wb, N, hp, lp);


figure(1)
subplot(3,1,3)
plot(f)   
xlim([0, M-1])
grid;

