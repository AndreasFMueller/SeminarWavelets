# (C) 2019 Roy Seitz
# Generate data points for a Haar-Wavelet and its hilbert transform

n = 200; N = 6 * n;
t = linspace(-1, 2, N)';

h = 1 / sqrt(2) * [zeros(2*n, 1); ones(n,1); -ones(n, 1); zeros(2*n, 1)];

hh = 1 / (sqrt(2) * pi) * log( abs((t .* (t - 1) ) ./ (t - 1/2).^2));

f = h + 1i * hh;
% plot(t, [h, hh]); xlim([-1, 2]); ylim([-2, 2]);

fp = fopen('./haar.data', 'w');
fprintf(fp, 't im envp envn\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f %6.5f %6.5f\n', t(i), hh(i), abs(f(i)), -abs(f(i)));
end
fclose(fp);
