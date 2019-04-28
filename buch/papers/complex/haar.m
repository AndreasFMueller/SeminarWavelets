# (C) 2019 Roy Seitz
# Generate data points for a Haar-Wavelet and its hilbert transform

n = 50; N = 6 * n;
t = linspace(-1, 2, N)';

h = [zeros(2*n, 1); ones(n,1); -ones(n, 1); zeros(2*n, 1)];

hh = 1/pi * log( abs((t .* (t - 1) ) ./ (2 * (t - 1/2).^2)));

% plot(t, [h, hh]); xlim([-1, 2]); ylim([-2, 2]);

fp = fopen('./haar.data', 'w');
fprintf(fp, 't h hh\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f %6.5f\n', t(i), h(i), hh(i));
end
fclose(fp);
