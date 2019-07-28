## Copyright (C) 2019 Roy Seitz
## 
## Author: Roy Seitz 
## Created: 2019-07-28

# width   width in pixel
# height  height in pixel
# sig     0: chirp, 1: f-square
# WL      0: Morlet, 1: Haar, 2: analytic Haar, 3: gabor
# pad     0: None, 1: Standard, 2: Zero-padding, 3: Matlab
function im(width=1920, height=1080, sig=0, WL=0, pad=1, create_plot=1, create_file=0)
# Create data for image

tend = 4; 
t = linspace(0, tend, width)';    

% Frequency vector
P = 1.5; % Periods of frequency variation
% f = logspace(0, 2, N)';
% f = 5 + 3 * cos(2*pi*P/tend * t);        % Sine
if sig == 0
  f = linspace(2, 8, width)';                  % Chirp
else
  f = 5 + 3 * sign(cos(2*pi*P/tend * t)); % Square
end
  

dt = t(2) - t(1);           % Time increment
phi = 2 * pi * cumsum(f)*dt; % Phase vector

x = cos(phi);               % Real wave
% x = exp(1i * phi);          % Complex wave
% x = exp(2i * pi * t);       % Constand frequency complex wave
% x = sign(cos(phi)); % Square wave

% Noise
% x = x + 0.25 * (randn(size(x)) + 1i * randn(size(x)));

[yab, a] = myCWT(x, dt, height, pad, WL);

yab = yab / max(abs(yab(:))) * 254;

[~, idx] = max(abs(yab), [], 2);
for i = 1:width
  if yab(i, idx(i)) >= 255*2/3
    yab(i, idx(i)) = 255;
  end
end

%% Plot
if create_plot
  hf = figure(123); clf(hf);
  set(hf, 'Position', [1920, 0, 1920, 1080]);
  scale = 3 * floor(log10(mean(a)) / 3);
  a = a * 10 ^ -scale;
  
  [x1, y1] = meshgrid(t, a);
  h = pcolor(x1, y1, abs(yab.')); 
  set(h, 'EdgeColor', 'none'); set(gca, 'YScale', 'lin');
  hold on; plot(t, 1./([1:2:length(t), length(t):-2:1] * 2 * dt * 10 ^ -scale), 'w--'); hold off;
  % title('CWT eines logarithmischen Chirp-Signals');
  xlabel('Zeit [sec]'); 
  ma = min(a); Ma = max(a); ylim([ma Ma]);
%  yticks = 2.^(floor(log2(ma)):ceil(log2(Ma)))';
%  set(gca, 'YTick', yticks); set(gca, 'yticklabel', num2str(yticks))
  switch scale
    case 3; ylabel('Frequenz [kHz]');
    case 6; ylabel('Frequenz [MHz]');
      otherwise; ylabel('a');
  end
end

if create_file
  fname = 'im.dat';
  data = [width height; round(abs(yab(:))) angle(yab(:))];
  save -ascii 'im.dat' data
end