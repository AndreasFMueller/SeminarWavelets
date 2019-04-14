import numpy as np
import matplotlib.pyplot as plt 

def plotDataSet(x, y, predict=np.empty(0), correct=None, display="matrix"):
    
    plt.figure(figsize=(16,10))
    
    frameCount = x.shape[0]
    ysize = y.shape[0]
    
    offset =(ysize - frameCount) //2
    
    frameCount = x.shape[0]
    if  display == "matrix":
        plotDim = [4, int(np.max(frameCount/4))]
    elif display == "flat":
        plotDim = [1, frameCount]
    
    for i in range(frameCount):
        image = x[i,:,:,:]
        plt.subplot(plotDim[0],plotDim[1],i+1)
        plt.xticks([])
        plt.yticks([])
        plt.grid(False)
        plt.imshow(image, cmap='gray')
        
        if ((offset + i) >= 0) and ((offset + i) < ysize):
            str = 'y:{}'.format(y[offset + i])
            if predict.size != 0:
                str += ' p:{:0.2f}'.format(predict[offset + i])
            plt.xlabel(str)
        else:
            plt.xlabel('')
            
    if correct != None:
        plt.title('correct :{}'.format(correct))
    
    plt.show()

def plotDataSet2D(x, y):
    
    plt.figure(figsize=(16,10))
    
    plt.imshow(x/255)
    plt.title('label :{}'.format(y[0]))
    


def hist(x, nbins = 10):
    
    # the histogram of the data
    n, bins, patches = plt.hist(x, nbins, density=True, facecolor='blue', alpha=0.75)
    
    plt.xlabel('Data')
    plt.ylabel('Probability')
    plt.title('Histogram')
#    plt.axis([40, 160, 0, 0.03])
    plt.grid(True)
    
    plt.show()
    
def calcConfusionMatrix(py, correct):
    true_positive = 0;
    false_positive = 0;
    false_negative = 0;
    true_negative = 0;
    for i in range(len(py)):
        if py[i].any():
            if correct[i]:
                true_positive += 1
            else:
                false_positive += 1
        else:
            if correct[i]:
                false_negative += 1
            else:
                true_negative += 1
                
    confusionmatrix = np.array(((true_positive, false_positive),(false_negative, true_negative)))
    return confusionmatrix




def printConfusionMatrix(m , normalize = True ):
    
    if normalize:
        m = m/np.sum(m)*100
    
    for i in range(m.shape[0]):
        s = '|'
        for j in range(m.shape[1]):
            if normalize:
                s += " {:4.1f}% |".format(m[i,j])
            else:
                s += " {:3d} |".format(m[i,j])
                
        print(s)
    


if __name__ == '__main__':
    c = np.array(((0.01,2,2),(3,4,0.0005)))
    print(c)
    printConfusionMatrix(c)
    
    
