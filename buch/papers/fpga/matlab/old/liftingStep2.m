%% Lifting Step algorithmus with haar wavelet using double precision calculations

%% Create x vector
t = 1:3000;
x = sin(2*pi*t/500);% + 1.2*cos(2*pi*t/40);

x = int16(x*2^15*0.1); %quantize x

% x(1:2000) = zeros(1,2000);
% x(501+348:1000+348) = [(1:250) (250:-1:1)]/250;

% Plot x vector
figure(1)
subplot(3,1,1)
plot(t, x);
legend({'x', 'sVhdl', 'dVhdl'})

%% Set number of coefficients
N = 7;


%% Forward transform
ds = cell(1, N);
for n = 1:N
    len = ceil(length(x)/2)-1;
    s = zeros(1, len); % lp
    d = zeros(1, len); % hp
    for i = 2:len-1
        s(i) = x(2*i);
        d(i) = x(2*i+1);
        d(i) = d(i) - s(i);
        s(i) = s(i) + 1/2*d(i);
    end
    ds{n} = [d];
    x = s(1:len);
end

%% Plot coefficients
subplot(3,1,2)
plot(s); hold on;
for i = 1:N
    plot(ds{i});
end
hold off;

%% Plot coefficients as image
im2 = wavlet2img(ds, {});
im = imresize(im2,[N*30 size(im2,2)]);
subplot(3,1,3)
imshow(im(:, 200:end-200), [])

%% Backward transform
for n = N:-1:1
    len = length(s);
    y = zeros(1, len*2 + 1); % lp
    d = ds{n};
    for i = 2:len
        s(i) = s(i) - 1/2*d(i);
        d(i) = d(i) + s(i);
        y(2*i+1) = d(i);
        y(2*i) = s(i);
    end
    s = y;
end

%% Plot result
subplot(3,1,1)
hold on;
plot(y, 'x'); hold off;
