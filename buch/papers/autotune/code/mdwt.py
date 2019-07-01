import numpy as np
import matplotlib.pyplot as plt
import pywt
from scipy.signal import chirp
from scipy.interpolate import interp1d

t = []
sig = []
wlen = []
coff = []
coff2 = []
coffap = []
nr = 24
fs = []

for x in range(nr):
    fs.append(4096*np.power(np.power(2, 1/24), x))
    t.append(np.linspace(0, 1, fs[x]))
    #Testsignale
    sig.append((-0.5*np.cos(6*np.pi*t[x])+0.5)*chirp(t[x], 100, 2, 400, 'linear'))
    plt.plot(t[x], sig[x])

    wlen.append(pywt.dwt_max_level(len(sig[x]), 'db8'))
    coff.append(pywt.wavedec(sig[x], 'db8', level=min(wlen)))
plt.figure()

sampling_period = 1 / fs[0]
coef, freqs = pywt.cwt(sig[0], np.arange(1, 254), 'cgau8',
                       sampling_period=sampling_period)
plt.contourf(t[0], freqs, coef, 100, cmap=plt.cm.hot)
plt.ylim([0, 1000])
plt.figure()
print(min(wlen))

for r in range(len(coff)):
    coff2.append([])
    tp = np.linspace(0, 1, len(coff[r][-1]))
    for k in range(len(coff[r])-1):
        tp = np.linspace(0, 1, len(coff[r][k]))
        co = interp1d(tp, coff[r][k], kind='next')
        coff2[r].append(co(t[-1]))
        
arr = np.asarray(coff2)
print(arr.shape)
for k in range(min(wlen)):
    for r in range(len(coff2)):
        coffap.append(coff2[r][k])
plt.figure()
plt.pcolor(coffap)


