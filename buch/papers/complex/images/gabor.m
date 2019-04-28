# (C) 2019 Roy Seitz
# Generate data points for a Gabor-Wavelet

N = 200;
t = linspace(-4, 4, N)';

h = exp(-1/2*t.^2) .* cos(2 * pi * t);
h = h ./ sqrt((sum(h'*h)*mean(diff(t)))); % Normalize to ||psi|| = 1

%plot(t, h); grid on;

fp = fopen('./gabor.data', 'w');
fprintf(fp, 't h\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f\n', t(i), h(i));
end
fclose(fp);
