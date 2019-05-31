#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 28 14:13:15 2019

@author: nunigan
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.dates as mdates
import datetime as dt


date = np.loadtxt('date.txt', delimiter=',', dtype=str)
date_2018 = []

for i in range(16933):
    date_2018.append(dt.datetime.strptime(date[i], "%d.%m.%Y %H:%M"))

# wt_airp = np.loadtxt('wt_airp_jan.txt', delimiter=',')
# wt_temp = np.loadtxt('wt_temp_jan.txt', delimiter=',')
# wt_wind = np.loadtxt('wt_wind_jan.txt', delimiter=',')
# F_jan = np.loadtxt('F_jan.txt', delimiter=',')
# raw_2018 = np.loadtxt('raw_2018.txt', delimiter=',')
# wt_airp = np.loadtxt('wt_airp_jan.txt', delimiter=',')


fig, [ax1, ax2] = plt.subplots(2, 1, num=1, clear=True, gridspec_kw={'height_ratios': [1, 1]}, sharex=True)
plt.subplots_adjust(wspace=0.00001)


#cs = ax1.contourf(date_2018[1::10], F_jan[1::10], wt_temp[1::10,1::10]*wt_wind[1::10,1::10], 30,cmap=plt.cm.plasma)
cs = ax1.contourf(date_2018[1::10], F_jan[1::10], wt_airp[1::10,1::10]*wt_wind[1::10,1::10], 30, cmap=plt.cm.plasma)
#fig.colorbar(cs, ax=ax1, shrink=1)
ax1.set_yscale("log")
ax1.set_ylabel('Frequency (Hz)', fontname="cmr10", fontsize=15)
#ax1.set_title('cwt "temperature * wind" strom saison 2018', fontname="cmr10", fontsize=15)
ax1.set_title('cwt "air pressure * wind" strom saison 2018', fontname="cmr10", fontsize=15)
ax1.tick_params(reset=False, labelsize=12)
ax1.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
ax1.xaxis.set_major_locator(mdates.DayLocator())


for c in cs.collections:
    c.set_edgecolor("face")
    c.set_linewidth(0.000000000001)

for tick in ax1.get_xticklabels():
    tick.set_rotation(15)

#cs2 = ax2.plot(date_2018, raw_2018[0:16933, 0], linewidth=0.5, color='blue')
cs2 = ax2.plot(date_2018, raw_2018[0:16933, ], linewidth=1, color='blue')
ax2.set_ylabel('air pressure (hPa)',fontname="cmr10", fontsize = 15, color = 'blue')
#ax2.set_ylabel(r'Temperature ($^\circ$C)',fontname="cmr10", fontsize = 15, color = 'blue')
ax2.tick_params(axis='y', labelcolor='blue',labelsize=15)
ax2.tick_params(labelsize=12)
ax2.grid(True)
#ax2.set_ylim(-12, 18)
ax2.set_ylim(990, 1040)
ax2.set_xlim(date_2018[0], date_2018[-1])
ax2.yaxis.set_major_locator(ticker.MultipleLocator(10))


ax3 = ax2.twinx()  # instantiate a second axes that shares the same x-axis
ax3.set_ylabel('Wind (km/h)', color='orange', fontname="cmr10", fontsize=15)  # we already handled the x-label with ax1
ax3.plot(date_2018, raw_2018[0:16933,2], 'orange', alpha = 0.6, linewidth = 1)
ax3.tick_params(axis='y', labelcolor='orange', labelsize=12)
ax3.grid(True)
ax3.set_ylim(0, 60)
ax3.set_xlim(date_2018[0], date_2018[-1])
ax3.yaxis.set_major_locator(ticker.MultipleLocator(12))
ax3.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
ax3.xaxis.set_major_locator(mdates.DayLocator())

for tick in ax2.get_xticklabels():
    tick.set_rotation(15)

plt.subplots_adjust(hspace = 0.1, bottom = 0.1)

plt.tight_layout()

plt.show()
