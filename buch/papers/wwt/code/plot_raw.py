#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue May 28 14:18:52 2019

@author: nunigan
"""

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime as dt
import matplotlib


matplotlib.rcParams['font.family'] = 'STIXGeneral'



raw_2018 = np.loadtxt('raw_2018.txt', delimiter=',')

date = np.loadtxt('date.txt', delimiter=',', dtype  = str)
date_2018 = []

for i in range(len(date)):
    date_2018.append(dt.datetime.strptime(date[i], "%d.%m.%Y %H:%M"))



fig, [ax1, ax2, ax3, ax4] = plt.subplots(4, 1, num=1, clear=True, sharex = 'col', figsize= (11, 7))
fig.subplots_adjust(hspace = 0.1, bottom = 0.1, wspace=0.05, left = 0.06, right = 0.99)

fig.gca().xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
fig.gca().xaxis.set_major_locator(mdates.MonthLocator())




cs1 = ax1.plot(date_2018[0::5], raw_2018[0::5,0], linewidth = .4)
ax1.set_ylabel(r'Temperature ($^\circ$C)',fontname="cmr10", fontsize = 10, )
ax1.tick_params(axis='y',labelsize=10)
ax1.tick_params(axis='x',labelbottom=False)
ax1.set_title('Rohdaten 2018', fontname="cmr10", fontsize = 15)
ax1.grid(True)
ax1.set_xlim(date_2018[0], date_2018[-1])


cs2 = ax2.plot(date_2018[0::5], raw_2018[0::5,1], linewidth =.4)
ax2.set_ylabel('Airpressure (hpa)',fontname="cmr10", fontsize = 10)
ax2.tick_params(axis='y',labelsize=10)
ax2.grid(True)
ax2.set_xlim(date_2018[0], date_2018[-1])
ax2.tick_params(axis='x',labelbottom=False)



cs3 = ax3.plot(date_2018[0::5], raw_2018[0::5,2], linewidth = .1)
ax3.set_ylabel('Wind (km/h)',fontname="cmr10", fontsize = 10)
ax3.tick_params(axis='y', labelsize=10)
ax3.grid(True)
ax3.set_xlim(date_2018[0], date_2018[-1])
ax3.set_ylim(-2, 40)
ax3.tick_params(axis='x',labelbottom=False)



cs4 = ax4.plot(date_2018[0::5], raw_2018[0::5,3], linewidth = .8)
ax4.set_ylabel(r'rain (l/mm${^2}$)',fontname="cmr10", fontsize = 10)
ax4.tick_params(axis='y',labelsize=10)
ax4.set_xlim(date_2018[0], date_2018[-1])
ax4.grid(True)
ax4.xaxis.set_major_formatter(mdates.DateFormatter('%d.%m.%Y'))
ax4.xaxis.set_major_locator(mdates.MonthLocator())

for tick in ax4.get_xticklabels():
    tick.set_rotation(15)


plt.show()