t = 1:2201;
x = sin(2*pi*t/40) + 1.2*cos(2*pi*t/500);

figure(1)
subplot(3,1,1)
plot(t, x)

N = 7

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
    ds{n } = d;
    x = s(1:len);
end

subplot(3,1,2)
plot(s); hold on;
for i = 1:N
    plot(ds{i});
end
hold off;

im2 = wavlet2img(ds, {});
im = imresize(im2,[N*30 size(im2,2)]);
subplot(3,1,3)
imshow(im(:, 200:end-200), [])

legend({'s (lp)', 'd (hp)'});

%%

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

subplot(3,1,1)
hold on;
plot(y, 'x'); hold off;
