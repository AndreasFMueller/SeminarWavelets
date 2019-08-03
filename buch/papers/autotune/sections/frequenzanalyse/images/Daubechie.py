# -*- coding: utf-8 -*-
"""
Created on Tue May  7 14:28:53 2019

@author: Cedric
"""

"""Plot the  set of 1D demo signals available in `pywt.data.demo_signal`."""

import numpy as np
import matplotlib.pyplot as plt

import pywt


#db_wavelets = pywt.wavelist('db')[:8]
db_wavelets = ['db1', 'db4', 'db8', 'db16']
print(db_wavelets)

fig, axarr = plt.subplots(ncols=4, nrows=4, figsize=(20,16))
#fig.suptitle('Daubechies Wavelet Familie', fontsize=24)
for col_no, waveletname in enumerate(db_wavelets):
    wavelet = pywt.Wavelet(waveletname)
    no_moments = wavelet.vanishing_moments_psi
    family_name = wavelet.family_name
    for row_no, level in enumerate(range(1,5)):
        wavelet_function, scaling_function, x_values = wavelet.wavefun(level = level)
        axarr[row_no, col_no].set_title("{} - level {}\n{} vanishing moments\n{} samples".format(
            waveletname, level, no_moments, len(x_values)), loc='left',fontsize=18)
        axarr[row_no, col_no].plot(x_values, wavelet_function, '-')
        axarr[row_no, col_no].plot(x_values, scaling_function, '-')
        axarr[row_no, col_no].set_yticks([])
        axarr[row_no, col_no].set_yticklabels([])
plt.tight_layout()
plt.subplots_adjust(top=0.9)
plt.savefig('DaubechiesFamilie.pdf')
plt.savefig('DaubechiesFamilie.png',dpi=800)
plt.savefig('DaubechiesFamilie.jpg',dpi=800)
