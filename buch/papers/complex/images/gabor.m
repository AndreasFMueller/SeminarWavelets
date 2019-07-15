# (C) 2019 Roy Seitz
# Generate data points for a Gabor-Wavelet

N = 500;
t = linspace(-4, 4, N)';

env = exp(-1/2*t.^2);
h = env .* cos(2 * pi * t);
env = env / sqrt((sum(h'*h)*mean(diff(t)))); % Normalize to ||psi|| = 1
h = h ./ sqrt((sum(h'*h)*mean(diff(t)))); % Normalize to ||psi|| = 1

plot(t, [h, env, -env]); grid on;

fp = fopen('./gabor.data', 'w');
fprintf(fp, 't h envp envn\n');
for i = 1:N
  fprintf(fp, '%6.5f %6.5f %6.5f %6.5f\n', t(i), h(i), env(i), -env(i));
end
fclose(fp);
