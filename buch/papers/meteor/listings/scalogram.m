wscalogram('image',tmp2,'xdata',ts);
title('Continuous Transform, absolute coefficients');
set(gca,'YDir','reverse')
ax = gca;
ax.YLim = [60 140];
colormap jet;
