#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.dates as mdates
import matplotlib
import datetime as dt

matplotlib.rcParams['font.family'] = 'STIXGeneral' #change font
date = np.loadtxt('date.txt', delimiter=',', dtype=str) #load date
date_2018 = []

for i in range(16933): #configure date
    date_2018.append(dt.datetime.strptime(date[i], "%d.%m.%Y %H:%M"))

#load data
wt_airp = np.loadtxt('wt_airp_jan.txt', delimiter=',')
wt_temp = np.loadtxt('wt_temp_jan.txt', delimiter=',')
wt_wind = np.loadtxt('wt_wind_jan.txt', delimiter=',')
F_jan = np.loadtxt('F_jan.txt', delimiter=',')
raw_2018 = np.loadtxt('raw_2018.txt', delimiter=',')
wt_airp = np.loadtxt('wt_airp_jan.txt', delimiter=',')

#plot figures
fig, [[ax1, ax11], [ax2, ax22]] = plt.subplots(2, 2, num=1, clear=True, gridspec_kw={'height_ratios': [2, 1], 'width_ratios': [50, 1]}, sharex = 'col', figsize= (11, 4))
fig.subplots_adjust(hspace = 0.1, bottom = 0.1, wspace=0.05, left = 0.07, right = 0.975)
ax22.axis('off')

cs = ax1.contourf(date_2018[1::10], F_jan[1::10], wt_airp[1::10,1::10]*wt_wind[1::10,1::10], 30, cmap=plt.cm.plasma, orientation='vertical')
fig.colorbar(cs, ax=ax1, shrink=1, cax = ax11)
ax1.set_yscale("log")
ax1.set_ylabel('Frequency (Hz)', fontname="cmr10", fontsize=15)
ax1.set_title('cwt "air pressure * wind" 2018', fontsize=15)
ax1.tick_params(reset=False, labelsize=12)
ax1.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
#ax1.xaxis.set_major_locator(mdates.WeekdayLocator()) #weekday ticks for overview
ax1.xaxis.set_major_locator(mdates.DayLocator()) #day ticks for zoom

for c in cs.collections:
    c.set_edgecolor("face")
    c.set_linewidth(0.000000000001) #get rid of white lines in contourf plot

for tick in ax1.get_xticklabels():
    tick.set_rotation(15)

cs2 = ax2.plot(date_2018, raw_2018[0:16933, ], linewidth=1, color='blue')
ax2.set_ylabel('Air pressure (hPa)', fontsize = 15, color = 'blue')
ax2.tick_params(axis='y', labelcolor='blue')
ax2.xaxis.set_tick_params(rotation=15)
ax2.tick_params(labelsize=12)
ax2.grid(True)
ax2.set_ylim(990, 1040)
ax2.set_xlim(date_2018[0], date_2018[-1])
ax2.yaxis.set_major_locator(ticker.MultipleLocator(10))

ax3 = ax2.twinx()  # instantiate a second axes that shares the same x-axis
ax3.set_ylabel('Wind (km/h)', color='darkred', fontsize=15)
ax3.plot(date_2018, raw_2018[0:16933,2], 'darkred', alpha = 0.6, linewidth = 1)
ax3.tick_params(axis='y', labelcolor='darkred', labelsize=12)
ax2.xaxis.set_tick_params(rotation=15)

ax3.grid(True)
ax3.set_ylim(0, 60)
ax3.set_xlim(date_2018[0], date_2018[-1])
ax3.yaxis.set_major_locator(ticker.MultipleLocator(12))
ax3.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
#ax3.xaxis.set_major_locator(mdates.WeekdayLocator()) 
ax3.xaxis.set_major_locator(mdates.DayLocator())

fig.savefig('plot_burglind.pdf')

