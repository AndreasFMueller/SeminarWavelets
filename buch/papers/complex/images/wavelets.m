# (C) 2019 Roy Seitz
# Plot wavelets
clf; clear; format shortEng;

N = 500;
t = linspace(-4, 4, N)';
w = linspace(-6*pi, 6*pi, N)';

%% Gabor
sigma = 2 * pi;
psi_gab = pi^-0.25 * sqrt(2) * exp(-1/2*t.^2) .* cos(sigma * t);
psi_gab_hat = pi^(-1/4)/sqrt(2) * (exp(-(w-sigma).^2/2) + exp(-(-w-sigma).^2/2));

subplot(4,2,1); plot(t, psi_gab); grid on; title('Gabor (Time Domain)');
subplot(4,2,3); plot(w, psi_gab_hat); grid on; title('Gabor (Frequency Domain)');
xlim([min(w) max(w)]);

%% Morlet
sigma = 2 * pi;
psi_mor = pi^-0.25 * exp(-1/2*t.^2) .* exp(1i * sigma * t);
psi_mor_hat = pi^(-1/4) * exp(-(w-sigma).^2/2);

subplot(4,2,2); plot(t, [real(psi_mor), imag(psi_mor)]); grid on; title('Morlet (Time Domain)');
subplot(4,2,4); plot(w, psi_mor_hat); grid on; title('Morlet(Frequency Domain)');
xlim([min(w) max(w)]);

% Haar
psi_haa = zeros(size(t)) + (t > -0.5 & t <= 0) - (t > 0 & t <= 0.5);
psi_haa_hat = 1/(2*sqrt(pi)) * (1 - cos(w/2))./(w/2);

subplot(4,2,5); plot(t, psi_haa); grid on; title('Haar (Time Domain)');
subplot(4,2,7); plot(w, [nan(size(w)), psi_haa_hat]); grid on; title('Haar (Frequency Domain)');
xlim([min(w) max(w)]);

% Analytic Haar
psi_aha =  (psi_haa + 1i/pi * log(abs(t.^2-0.5^2)./t.^2)) / sqrt(2);
psi_aha_hat = 1/(sqrt(2*pi)) * (1 - cos(w/2))./(w/2) .* (w >= 0);
xlim([min(w) max(w)]);

subplot(4,2,6); plot(t, [real(psi_aha) imag(psi_aha)]); grid on; title('Haar (Time Domain)');
xlim([min(t) max(t)]); ylim([-1, 1]);
subplot(4,2,8); plot(w, psi_aha_hat); grid on; title('Haar (Frequency Domain)');
xlim([min(w) max(w)]);