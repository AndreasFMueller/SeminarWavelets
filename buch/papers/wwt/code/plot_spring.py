#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 26 10:08:49 2019

@author: nunigan
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import matplotlib.dates as mdates
import datetime as dt
import matplotlib


matplotlib.rcParams['font.family'] = 'STIXGeneral'

date = np.loadtxt('date.txt', delimiter=',', dtype  = str)
date_2018 = []

for i in range(104164):
    date_2018.append(dt.datetime.strptime(date[i], "%d.%m.%Y %H:%M"))


x = np.linspace(0, 2000, 2001)
wt = np.loadtxt('wt_mai_june.txt', delimiter=',')
F = np.loadtxt('f.txt', delimiter=',')
X, Y = np.meshgrid(x, F)
raw = np.loadtxt('raw.txt', delimiter=',')


fig, [[ax1, ax11], [ax2, ax22]] = plt.subplots(2, 2, num=1, clear=True, gridspec_kw={'height_ratios': [2, 1], 'width_ratios': [50, 1]}, sharex = 'col', figsize= (11, 4))
fig.subplots_adjust(hspace = 0.1, bottom = 0.1, wspace=0.05, left = 0.07, right = 0.975)
cs = ax1.contourf(date_2018[42428:44429], F, wt, 30,linestyles = None, cmap=plt.cm.plasma)
fig.colorbar(cs, ax=ax1, shrink=1, cax = ax11)

ax22.axis('off')


ax1.set_yscale("log")
ax1.set_ylabel('Frequency (Hz)', fontsize = 15)
ax1.set_title('cwt spring 2018', fontsize = 15)
ax1.tick_params(labelsize=12)
ax1.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
ax1.xaxis.set_major_locator(mdates.DayLocator())


for tick in ax1.get_xticklabels():
    tick.set_rotation(15)

for c in cs.collections:
    c.set_edgecolor("face")
    c.set_linewidth(0.000000000001)



cs2 = ax2.plot(date_2018[42428:44428], raw[8000:10000,0])
ax2.set_ylabel(r'Temperature ($^\circ$C)', fontsize = 15)
ax2.tick_params(labelsize=12)
ax2.grid(True)
ax2.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
ax2.xaxis.set_major_locator(mdates.DayLocator())
ax2.set_xlim(date_2018[42428], date_2018[44428])


for tick in ax2.get_xticklabels():
    tick.set_rotation(15)

#plt.subplots_adjust(hspace = 0.1, bottom = 0.1)
plt.show()



