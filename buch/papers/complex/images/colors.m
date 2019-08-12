## Copyright (C) 2019 Roy Seitz
## 
## Author: Roy Seitz 
## Created: 2019-08-10

# width   width in pixel
# height  height in pixel
function colors(width=1920, height=1080, file_name=0, create_plot=0)

x = linspace(-1, 1, width);
y = linspace(-1, 1, height);

[xx, yy] = meshgrid(x, y);

z = -1i * xx + yy;

r = 1.01;
idx = find(abs(z) > r);
z(idx) = r;

z = (exp( 2.5 * abs(z)) - 1) .* exp(1i * angle(z)); % Adapt to eye
z = round(z / max(abs(z(:))) * 255);


%% Plot
if create_plot
  hf = figure(123); clf(hf);
  set(hf, 'Position', [1920, 0, 1920, 1080]);
  h = pcolor(xx, yy, abs(z)); 
  set(h, 'EdgeColor', 'none'); set(gca, 'YScale', 'lin');
end

if file_name ~= 0
  data = [width height; round(abs(z(:))) angle(z(:))];
  save('-ascii', file_name, 'data')
end