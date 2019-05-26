# Import python libraries
import numpy as np # fundamental package for scientific computing
import cv2
from scipy.signal import convolve2d
import matplotlib.pyplot as plt # package for plot function
    
  
def genFilterbank(params, size, sigma, gamma): 
    filterBank = []
    gaborParams = []
    print("start filterbank building")
    for (theta, wavelength) in params:
        gaborParams.append({'wavelength': wavelength, 'theta':theta, 'sz':(size, size)})
        kernel = cv2.getGaborKernel((size,size), sigma, theta, wavelength, gamma, psi=0,ktype=cv2.CV_32F)
        norm = np.linalg.norm(kernel)
        if norm != 0: 
            kernel /= norm
        filterBank.append(kernel)
    return filterBank, gaborParams, kernel
    
    
    
    
def plotFilterBank(filterBank, gaborParams):   
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.subplot(sqLen, sqLen,i+1)
        plt.title('theta={:0.1f}, lamda={:0.1f}'.format(gaborParams[i]['theta'], gaborParams[i]['wavelength']))
        plt.axis('off')
        plt.imshow(filterBank[i]) # delete 'gray' to apply a colormap (looks nice)

def plotConvs(filterBank, img, gaborParams):
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.subplot(sqLen, sqLen,i+1)
        plt.title('theta = {:0.1f}, lamda = {:0.1f}'.format(gaborParams[i]['theta'], gaborParams[i]['wavelength']))
        plt.axis('off')
        plt.imshow(convolve2d(img, filterBank[i], mode = 'same'), cmap='gray') # delete 'gray' to apply a colormap (looks nice)



if __name__ == '__main__':
    # Constants
    filterSize = 9
    sigma = 2  # stddeviation of kernels
    gamma = 0.5 # spatial aspect ration
    

    theta = np.arange(0, np.pi, np.pi/4) # changing orientation of kernels
    wavelength = np.arange(3,8,(8-3)/4) 
    params = [(t,w) for w in wavelength for t in theta]
    filterBank, gaborParams, k = genFilterbank(params, filterSize, sigma, gamma)
    print("start plotting sinFilterbank")
    plotFilterBank(filterBank, gaborParams)
    print("start plotting cosFilterbank")
    
    img = cv2.imread('testpatterns/serveimage.png', cv2.IMREAD_GRAYSCALE )
    img = cv2.resize(img,(32,32))
    rows, cols = img.shape
    plt.figure()
    plt.imshow(img, cmap='gray')
    
    plotConvs(filterBank,img, gaborParams)
