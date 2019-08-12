## Copyright (C) 2019 Roy Seitz
## 
## Author: Roy Seitz 
## Created: 2019-07-28

# width   width in pixel
# height  height in pixel
# sig     0: chirp, 1: f-square
#         Wave form: +0: Real, +2: Complex, +4 Square, +6: Complex square
#         noise: +8
# WL      0: Morlet, 1: Haar, 2: analytic Haar, 3: gabor
# pad     0: None, 1: Standard, 2: Zero-padding, 3: Matlab
function im(width=1920, height=1080, sig=0, WL=0, file_name=0, pad=1, show_max=1, a_max=16, create_plot=0)
# Create data for image

tend = 4; 
t = linspace(0, tend, width)';    
dt = t(2) - t(1);           % Time increment

% Frequency vector
P = 2; % Periods of frequency variation
% f = logspace(0, 2, N)';
% f = 5 + 3 * cos(2*pi*P/tend * t);        % Sine
switch mod(sig, 2)
  case 0; f = linspace(2, 8, width)';             % Chirp
  case 1; f = 6 + 2 * sign(sin(2*pi*P/tend * t)); % Square
end

phi = 2 * pi * cumsum(f)*dt; % Phase vector

switch mod(floor(sig/2), 4)
  case 0; x = cos(phi);       % Real wave
  case 1; x = exp(1i * phi);  % Complex wave
  case 2; x = sign(cos(phi)); % Square wave (1, -1)
  case 3; x = exp(0.5i*pi*(floor(2*phi/pi))); % Complex square wave (1, i, -1, -i)
end

% Noise
if sig >= 8
  if mod(floor(sig/2), 2) == 1
    x = x + sum([1, 1i] .* randn(length(x), 2), 2);
  else
    x = x + randn(length(x), 1);
  end
end

[yab, a] = myCWT(x, dt, height, pad, WL, a_max);

yab = yab / max(abs(yab(:))); % Scale to +- 1
yab = (exp( 2.5 * abs(yab)) - 1) .* exp(1i * angle(yab)); % Adapt to eye

yab = yab / max(abs(yab(:))) * 254;
if show_max
  [~, idx] = max(abs(yab), [], 2);
  for i = 1:width
    if abs(yab(i, idx(i))) >= 255*0.25
      yab(i, idx(i)) = 255;
    end
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

if file_name ~= 0
  data = [width height; round(abs(yab(:))) angle(yab(:))];
  save('-ascii', file_name, 'data')
end