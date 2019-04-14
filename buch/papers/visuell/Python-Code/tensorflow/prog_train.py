import time

import train

class ProgressTrain:
    
    def __init__(self, acc, epoch):
        self.acc = int(100*acc)
        self.epoch = epoch
        self.startTime = 0
    
    def start(self):
        self.startTime = time.time()
        self.trainArray = []
        
        self.trainArray.append(train.buildWagon("train acc: " + str(self.acc) + "%"))
        self.trainArray.append(train.buildWagon("epoch: " + str(self.epoch-1)))
        self.trainArray.append(train.getTrain())
    
    def progress(self, percentage):
        x = int(percentage/100 * train.length)
        
        print("\r" + train.buildTrain(self.trainArray, x), end='')
        self.prog = x
    
    def getTimeDif(self):
        return "{:2.2f}s".format(time.time() - self.startTime)
    
    def end(self):
        self.progress(100)
        print(' ')
        print("Training time for epoch" + str(self.epoch) + ": " + self.getTimeDif())
    
if __name__ == '__main__':

    train = ProgressTrain(0.354, 1)
    train.start()
    for i in range(0,100):
        time.sleep(0.1)
        train.progress((i+1))
    train.end()
