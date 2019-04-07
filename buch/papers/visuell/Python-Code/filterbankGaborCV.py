# Import python library for this notebook
import numpy as np # fundamental package for scientific computing
import cv2
import matplotlib.pyplot as plt # package for plot function
    
  
def genFilterbank(params, size, sigma, gamma): 
    filterBank = []
    gaborParams = []
    print("start filterbank building")
    for (theta, wavelength) in params:
        gaborParams.append({'wavelength': wavelength, 'theta':theta, 'sz':(size, size)})
        kernel = cv2.getGaborKernel((size,size), sigma, theta, wavelength, gamma, psi=0,ktype=cv2.CV_32F)
        print(kernel.sum())
        kernel /= 1.5*kernel.sum()
        filterBank.append(kernel)
    return filterBank, gaborParams, kernel
    
    
    
    
def plotFilterBank(filterBank, gaborParams):   
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.subplot(sqLen, sqLen,i+1)
        plt.title('t={:0.1f}, o={:0.1f}'.format(gaborParams[i]['theta'], gaborParams[i]['wavelength']))
        plt.axis('off'); 
        plt.imshow(filterBank[i], cmap='gray') # delete 'gray' to apply a colormap (looks nice)

def plotConvs(filterBank, img, gaborParams):
    plt.figure()
    n = len(filterBank)
    sqLen = np.sqrt(n)
    for i in range(n):
        plt.figure()
        plt.title('theta = {:0.2f}, omega = {:0.2f}'.format(gaborParams[i]['theta'], gaborParams[i]['wavelength']))
#        print('theta = ' + str(gaborParams[i]['theta']) + ' omega = ' + str(gaborParams[i]['omega']))
        plt.imshow(cv2.filter2D(img, cv2.CV_8UC3 , filterBank[i]), cmap='gray') # delete 'gray' to apply a colormap (looks nice)



if __name__ == '__main__':
    # Constants
    filterSize = 255
    sigma = 20  # stddeviation of kernels
    gamma = 0.5 # spatial aspect ration
    

    theta = np.arange(0, np.pi, np.pi/5) # changing orientation of kernels
    wavelength = np.arange(20,40,4) # wa
    params = [(t,w) for w in wavelength for t in theta]
    filterBank, gaborParams, k = genFilterbank(params, filterSize, sigma, gamma)
    print("start plotting sinFilterbank")
    plotFilterBank(filterBank, gaborParams)
    print("start plotting cosFilterbank")
    
    img = cv2.imread('testpatterns/serveimage.png', cv2.IMREAD_GRAYSCALE )
    rows, cols = img.shape
    M = cv2.getRotationMatrix2D((cols/2,rows/2),45,1) # center, angle, scale
    img = cv2.warpAffine(img, M , (cols, rows)) # rotate image
    
    plt.figure()
    plt.imshow(img, cmap='gray')
    
    plotConvs(filterBank,img, gaborParams)
