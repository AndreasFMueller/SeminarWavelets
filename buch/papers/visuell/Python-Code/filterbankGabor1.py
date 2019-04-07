# Import python library for this notebook
import numpy as np # fundamental package for scientific computing
import cv2
import matplotlib.pyplot as plt # package for plot function
    
def genGabor(sz, omega, theta, func=np.cos, K=np.pi):
    radius = (int(sz[0]/2.0), int(sz[1]/2.0))
    [x, y] = np.meshgrid(range(-radius[0], radius[0]+1), range(-radius[1], radius[1]+1))

    x1 = x * np.cos(theta) + y * np.sin(theta)
    y1 = -x * np.sin(theta) + y * np.cos(theta)
    
    gauss = omega**2 / (4*np.pi * K**2) * np.exp(- omega**2 / (8*K**2) * ( 4 * x1**2 + y1**2))
#     myimshow(gauss)
    sinusoid = func(omega * x1) * np.exp(K**2 / 2)
#     myimshow(sinusoid)
    gabor = gauss * sinusoid
    return gabor
  
def genFilterbank(params): 
    sinFilterBank = []
    cosFilterBank = []
    gaborParams = []
    print("start filterbank building")
    for (theta, omega) in params:
        gaborParam = {'omega':omega, 'theta':theta, 'sz':(128, 128)}
        sinGabor = genGabor(func=np.sin, **gaborParam)
        cosGabor = genGabor(func=np.cos, **gaborParam)
        sinFilterBank.append(sinGabor)
        cosFilterBank.append(cosGabor)
        gaborParams.append(gaborParam)
    return sinFilterBank, cosFilterBank, gaborParams
    
    
    
    
def plotFilterBank(filterBank, gaborParams):   
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.subplot(sqLen, sqLen,i+1)
        plt.title('t={:0.1f}, o={:0.1f}'.format(gaborParams[i]['theta'], gaborParams[i]['omega']))
        plt.axis('off'); 
        plt.imshow(filterBank[i], cmap='gray') # delete 'gray' to apply a colormap (looks nice)

def plotConvs(filterBank, img, gaborParams):
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.figure()
        plt.title('theta = {:0.2f}, omega = {:0.2f}'.format(gaborParams[i]['theta'], gaborParams[i]['omega']))
#        print('theta = ' + str(gaborParams[i]['theta']) + ' omega = ' + str(gaborParams[i]['omega']))
        plt.imshow(cv2.filter2D(img, -1, filterBank[i]), cmap='gray') # delete 'gray' to apply a colormap (looks nice)



theta = np.arange(0, np.pi, np.pi/4) # range of theta
omega = np.arange(0.1, 0.4, 0.1) # range of omega
params = [(t,o) for o in omega for t in theta]
sinFB, cosFB, gaborParams = genFilterbank(params)
print("start plotting sinFilterbank")
plotFilterBank(sinFB, gaborParams)
print("start plotting cosFilterbank")
plotFilterBank(cosFB, gaborParams)

img = cv2.imread('testpatterns/lines.png', cv2.IMREAD_GRAYSCALE )
rows, cols = img.shape
M = cv2.getRotationMatrix2D((cols/2,rows/2),45,1) # center, angle, scale
img = cv2.warpAffine(img, M , (cols, rows)) # rotate image

plt.figure()
plt.imshow(img, cmap='gray')

plotConvs(sinFB,img, gaborParams)
