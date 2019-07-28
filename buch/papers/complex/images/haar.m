% (C) 2019 Roy Seitz
% Generate data points for a Haar-Wavelet and its hilbert transform

n = 200; N = 6 * n;
t = linspace(-1.5, 1.5, N)';

h = 1 / 2 * [zeros(2*n, 1); ones(n,1); -ones(n, 1); zeros(2*n, 1)];

hh = 1 / (sqrt(2) * pi) * log( abs((t .^2 - 0.25 ) ./ t.^2));

f = h + 1i * hh;
% plot(t, [h, hh, abs(f)]); xlim([-1.5, 1.5]); ylim([-1.5, 1.5]);

fp = fopen('./haar.data', 'w');
fprintf(fp, 't im envp envn\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f %6.5f %6.5f\n', t(i), hh(i), abs(f(i)), -abs(f(i)));
end
fclose(fp);
