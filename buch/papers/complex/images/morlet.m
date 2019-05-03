# (C) 2019 Roy Seitz
# Generate data points for a Morlet-Wavelet

N = 200;
t = linspace(-4, 4, N)';

h = exp(-1/2*t.^2) .* exp(2i * pi * t);
h = h ./ sqrt((sum(h'*h)*mean(diff(t)))); % Normalize to ||psi|| = 1

%plot(t, [real(h), imag(h)]); grid on;

fp = fopen('./morlet.data', 'w');
fprintf(fp, 't re im envp envn\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f %6.5f %6.5f %6.5f\n', t(i), real(h(i)), imag(h(i)), abs(h(i)), -abs(h(i)));
end
fclose(fp);
