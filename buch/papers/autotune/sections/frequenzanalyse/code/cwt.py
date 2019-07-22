"""
Created on Tue May  7 14:28:53 2019

@author: Cedric

Changed not working version to show cwt commands
"""

import numpy as np
import matplotlib.pyplot as plt
import pywt

# Signal Erstellen
samp = 4096*2
t = np.linspace(0, 1, samp)
sig = (-0.5*np.cos(6*np.pi*t)+0.5)*chirp(t, 0, 1, 400, 'linear')

# cwt Analyse mit der pywt cwt funktion
sampling_period = 1 / samp
coef, freqs = pywt.cwt(sig[0], np.arange(1, 254), 'cgau8',
                       sampling_period=sampling_period)

# Plotten der Ergebnisse
cs = plt.contourf(t[0], freqs, coef, 200, cmap=plt.cm.gnuplot2)
plt.ylim([20, 500])
cbar = plt.colorbar(cs)

