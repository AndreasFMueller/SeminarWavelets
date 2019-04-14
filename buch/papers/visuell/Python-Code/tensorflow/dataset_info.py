import tensorflow as tf

class DatasetInfo:
    
    def __init__(self, dataset):
        
        it = dataset.batch(1).make_one_shot_iterator()
        next_el = it.get_next()
        
        x = next_el['x']
        y = next_el['y']
        
        with tf.Session() as sess:
            x, y = sess.run([x, y])
        
        self.xShape = x.shape
        print(x.shape)
        self.yShape = y.shape
        print(y.shape)
        self._setShapes()
        
    
#    def __init__(self, x, y):
#        
#        self.xShape = x.shape.as_list()
#        self.yShape = y.shape.as_list()
#        
#        self._setShapes()
        
    def _setShapes(self):
        
#        self.batchSize = self.xShape[0]
#        self.frameCount = self.xShape[1]
#        self.rowCount = self.xShape[2]
#        self.colCount = self.xShape[3]
#        self.colorCount = self.xShape[4]
        self.rowCount = self.xShape[1]
        self.colCount = self.xShape[2]
        self.colorCount = self.xShape[3]
        
        
        self.transitionCount = self.yShape[1]
        self.classCount = self.yShape[2]
        
#        self.inputshape = (self.frameCount, self.rowCount, self.colCount, self.colorCount)    
        self.inputshape = [None, self.rowCount, self.colCount, self.colorCount]
    
    def printInfo(self):
        print ('\nData information')
#        print('Batch size: ', self.batchSize)
#        print('X Tensor : (frames: ', self.frameCount,' rows: ', self.rowCount, ' cols: ', self.colCount, ' colors: ', self.colorCount, ')')
        print('X Tensor : (rows: ', self.rowCount, ' cols: ', self.colCount, ' colors: ', self.colorCount, ')')
        print('Y Tensor : (transitions: ', self.transitionCount, ', classes ', self.classCount, ')')
