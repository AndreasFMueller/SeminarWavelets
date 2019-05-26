# Import python libraries
import numpy as np # fundamental package for scientific computing
from scipy.signal import convolve2d
import cv2
import matplotlib.pyplot as plt



class GaborLayer():
    def __init__(self):
        pass
#        self.filterBank, gaborParams = self.__genFilterBank(features)
#        self.__plotFilterBank(self.filterBank, gaborParams)
        
        
        
    def calcConvLayer(self, xData):
        conv = np.zeros(xData[:,:,1].shape + (len(self.filterBank[1,1]),))
        for i in range(len(self.filterBank[1,1])):
            tempConvs = np.zeros(xData[1,1].shape + conv[:,:,1].shape)
            for j in range(len(xData[1,1])): # for all input channels
                tempConvs[j] = convolve2d(xData[:,:,j], self.filterBank[:,:,i], mode = 'same') #TODO maybe preserve color information
            conv[:,:,i] = np.sum(tempConvs, axis=0)/len(xData[1,1]) # calculate sum over color channels
        return conv.astype('uint8')
    
    
    
    def genFilterBank(self, features, size=9, sigma=2, gamma=0.8): 
        assert (np.sqrt(features) % 1 == 0), "features must have a integer root"
        
        s = np.sqrt(features)
        theta = np.arange(0, np.pi, np.pi/s) # changing orientation of kernels
        wavelength = np.arange(3,8,5/s) 
        params = [(t,w) for w in wavelength for t in theta]
        
        filterBank = np.zeros((size, size, 1, features))
        gaborParams = []
        for i, (theta, wavelength) in enumerate(params):
            gaborParams.append({'wavelength': wavelength, 'theta':theta, 'sz':(size, size)})
            kernel = cv2.getGaborKernel((size,size), sigma, theta, wavelength, gamma, psi=0,ktype=cv2.CV_32F)
            norm = np.linalg.norm(kernel)
            if norm != 0: 
                kernel /= norm
            filterBank[:,:,0,i] = kernel

        return filterBank, gaborParams
    
    def __plotFilterBank(self, filterBank, gaborParams):   
        plt.figure()
        n = len(filterBank[1,1])
        sqLen = np.sqrt(n)
        for i in range(n):
            plt.subplot(sqLen, sqLen,i+1)
            plt.title('t={:0.1f}, o={:0.1f}'.format(gaborParams[i]['theta'], gaborParams[i]['wavelength']))
            plt.axis('off'); 
            plt.imshow(filterBank[:,:,i], cmap='gray') # delete 'gray' to apply a colormap (looks nice)
    

if __name__ == '__main__':
    import tensorflow as tf
    gl = GaborLayer(25)
    (xTrain, yTrain), (xTest, yTest) = tf.keras.datasets.cifar10.load_data()
#    img = cv2.imread('serveimage.png')
#    img = cv2.resize(img,(32,32))
    img = xTrain[2]
    
    x = gl.calcConvLayer(img)
    plt.figure()
    plt.imshow(img)
    for i in range(x.shape[2]):
        plt.figure()
        plt.imshow(x[:,:,i], cmap='gray')
    