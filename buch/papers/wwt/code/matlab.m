[wt, F] = cwt(Daten2018(1:50000, 1), 'VoicesPerOctave', 48, 'amor', fs)
contourf(date_2018(34428:51933,1), F, abs(wt), 15,'LineColor','none');
datetick('x','dd-mm-yy','keepticks','keeplimits')
set(gca, 'YScale', 'log')
axis tight;
ylabel('Frequency (Hz)');
title('CWT Mai Juni 2018 Temperatur')
