
h0 = (1+sqrt(3))/(4*sqrt(2));
h1 = (3+sqrt(3))/(4*sqrt(2));
h2 = (3-sqrt(3))/(4*sqrt(2));
h3 = (1-sqrt(3))/(4*sqrt(2));

h = [h0 h1 h2 h3];
g = [-h3 h2 -h1 h0];

stem(h); hold on;
stem(g); hold off;

sum(g)

t = 1:201;
x = sin(2*pi*t/30) + 1.2*cos(2*pi*t/87);

figure(1)
subplot(2,1,1)
plot(t, x)

haar = true;

s = zeros(1, 101);
d = zeros(1, 101);
for i = 2:100
    if haar
%         s(i) = x(2*i);
%         d(i) = x(2*i+1);
%         d(i) = d(i) - s(i);
%         s(i) = s(i) + 1/2*d(i);

        s(i) = x(2*i);
        d(i) = x(2*i+1);
        d(i) = d(i) - s(i);
        s(i) = s(i) + 1/2*d(i);
    else
        d(i) = x(2*i+1) - sqrt(3)* x(2*i);
        s(i) = x(2*i) - sqrt(3)/4*d(i) + (sqrt(3)-2)/4 * d(i+1);
        d(i) = d(i) + s(i-1);
        s(i) = (sqrt(3) + 1)/sqrt(2) * s(i);
        d(i) = (sqrt(3) - 1)/sqrt(2) * d(i);
    end
end

subplot(2,1,2)
plot(s); hold on;
plot(d); hold off;

y = zeros(1, 201);

for i = 2:100
    if haar
%         s(i) = s(i) - 1/2*d(i);
%         d(i) = d(i) + s(i);
%         y(2*i+1) = d(i);
%         y(2*i) = s(i);
        s(i) = s(i) - 1/2*d(i);
        d(i) = d(i) + s(i);
        y(2*i+1) = d(i);
        y(2*i) = s(i);
    else
        d(i) = (sqrt(3) + 1)/sqrt(2) * d(i);
        s(i) = (sqrt(3) - 1)/sqrt(2) * s(i);
        d(i) = d(i) - s(i-1);
        y(2*i) = s(i) - sqrt(3)/4*d(i) - (sqrt(3)-2)/4 * d(i+1);
        y(2*i+1) = d(i) + sqrt(3)* x(2*i);
    end
end

subplot(2,1,1)
hold on;
plot(t, y, 'x'); hold off;
