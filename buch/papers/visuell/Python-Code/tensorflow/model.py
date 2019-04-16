#from __future__ import absolute_import, division, print_function

import numpy as np
import tensorflow as tf

varianceEpsilon = 1e-3  # small float to prevent division by 0 in batch_norm
learningRate = 1e-3
stdDev = 1e-1 # standard deviation of all initializations

class Model:
    
    def __init__(self, datasetInfo):
        self.model = None
        self.datasetInfo = datasetInfo
        
        

    def build(self, x, y):
        
        self.x = x
        
        self.y = tf.reshape(y, [-1, self.datasetInfo.classCount])
        
#        self.isTraining = tf.placeholder(tf.bool)
        

        # Convolutional Layer 1
        with tf.name_scope('conv1'):   
            features1 = 64
            # define kernel -> default values normally distributed
            self.kernel1 = tf.Variable(tf.truncated_normal([3, 3, 3, features1], 
                                    dtype=tf.float32, stddev=stdDev), name='weights1')
            stride = [1,1,1,1] # stride 1 for all directions
            conv = tf.nn.conv2d(self.x, self.kernel1, stride, padding='SAME')
            self.biases1 = tf.Variable(tf.constant(0.0, shape=[features1], dtype=tf.float32),
                                 trainable=True, name='biases1')
            out = tf.nn.bias_add(conv, self.biases1)
#            outNorm = tf.layers.batch_normalization(out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(out, [0])
            outNorm = tf.nn.batch_normalization(out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            conv1 = tf.nn.relu(outNorm)
    
        # Pooling 1
        with tf.name_scope('pool1'):
            pool1 = tf.nn.max_pool(conv1,
                                     ksize=[1, 2, 2, 1],
                                     strides=[1, 2, 2, 1],
                                     padding='SAME',
                                     name='pool1')

        # Convolutional Layer2
        with tf.name_scope('conv2'):
            features2 = 128
            # define kernel -> default values normally distributed
            self.kernel2 = tf.Variable(tf.truncated_normal([3, 3, features1, features2], 
                                    dtype=tf.float32, stddev=stdDev), name='weights2')
            stride = [1,1,1,1]
            conv = tf.nn.conv2d(pool1, self.kernel2, stride, padding='SAME')
            self.biases2 = tf.Variable(tf.constant(0.0, shape=[features2], dtype=tf.float32),
                                 trainable=True, name='biases2')
            out = tf.nn.bias_add(conv, self.biases2)
#            outNorm = tf.layers.batch_normalization(out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(out, [0])
            outNorm = tf.nn.batch_normalization(out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            conv2 = tf.nn.relu(outNorm)
    
        # Pooling 2
        with tf.name_scope('pool2'):
            pool2 = tf.nn.max_pool(conv2,
                                     ksize=[1, 2, 2, 1],
                                     strides=[1, 2, 2, 1],
                                     padding='SAME',
                                     name='pool2')
    
        # Convolutional Layer 3
        with tf.name_scope('conv3'):
            features3 = 256
            # define kernel -> default values normally distributed
            self.kernel3 = tf.Variable(tf.truncated_normal([3, 3, features2, features3], 
                                    dtype=tf.float32, stddev=stdDev), name='weights3')
            stride = [1,1,1,1]
            conv = tf.nn.conv2d(pool2, self.kernel3, stride, padding='SAME')
            self.biases3 = tf.Variable(tf.constant(0.0, shape=[features3], dtype=tf.float32),
                                 trainable=True, name='biases3')
            out = tf.nn.bias_add(conv, self.biases3)
#            outNorm = tf.layers.batch_normalization(out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(out, [0])
            outNorm = tf.nn.batch_normalization(out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            conv3 = tf.nn.relu(outNorm)
    
        # Pooling 3
        with tf.name_scope('pool3'):
            pool3 = tf.nn.max_pool(conv3,
                                     ksize=[1, 2, 2, 1],
                                     strides=[1, 2, 2, 1],
                                     padding='SAME',
                                     name='pool3')
        # Convolutional Layer 4
        with tf.name_scope('conv4'):
            features4 = 512
            # define kernel -> default values normally distributed
            self.kernel4 = tf.Variable(tf.truncated_normal([3, 3, features3, features4], 
                                    dtype=tf.float32, stddev=stdDev), name='weights4')
            stride = [1,1,1,1]
            conv = tf.nn.conv2d(pool3, self.kernel4, stride, padding='SAME')
            self.biases4 = tf.Variable(tf.constant(0.0, shape=[features4], dtype=tf.float32),
                                 trainable=True, name='biases3')
            out = tf.nn.bias_add(conv, self.biases4)
#            outNorm = tf.layers.batch_normalization(out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(out, [0])
            outNorm = tf.nn.batch_normalization(out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            conv3 = tf.nn.relu(outNorm)
    
        # Pooling 3
        with tf.name_scope('pool4'):
            pool4 = tf.nn.max_pool(conv3,
                                     ksize=[1, 2, 2, 1],
                                     strides=[1, 2, 2, 1],
                                     padding='SAME',
                                     name='pool4')
            

        # Flatten and Fully Connected 1
        with tf.name_scope('fc1'):
            nodesFc1 = 128
            # calculate the shape of the flatten layer (using np.prod)
            shape = int(np.prod(pool4.get_shape()[1:]))
            flatten = tf.reshape(pool4, [-1, shape])
            self.fc1Weights = tf.Variable(tf.truncated_normal([shape, nodesFc1], dtype = tf.float32, 
                                                         stddev = stdDev), name = 'weightsFc1')
            self.fc1Biases = tf.Variable(tf.constant(1.0, shape=[nodesFc1], dtype=tf.float32),
                                    trainable = True, name = 'biasesFc1')
            fc1Out = tf.nn.bias_add(tf.matmul(flatten, self.fc1Weights), self.fc1Biases)
#            fc1Norm = tf.layers.batch_normalization(fc1Out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(fc1Out, [0])
            fc1Norm = tf.nn.batch_normalization(fc1Out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            
        # Fully Connected 2
        with tf.name_scope('fc2'):
            nodesFc2 = 256
            self.fc2Weights = tf.Variable(tf.truncated_normal([nodesFc1, nodesFc2], dtype = tf.float32, 
                                                         stddev = stdDev), name = 'weightsFc2')
            self.fc2Biases = tf.Variable(tf.constant(1.0, shape=[nodesFc2], dtype=tf.float32),
                                    trainable = True, name = 'biasesFc2')
            fc2Out = tf.nn.bias_add(tf.matmul(fc1Norm, self.fc2Weights), self.fc2Biases)
#            fc2Norm = tf.layers.batch_normalization(fc2Out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(fc2Out, [0])
            fc2Norm = tf.nn.batch_normalization(fc2Out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            
        # Fully Connected 2
        with tf.name_scope('fc3'):
            nodesFc3 = 512
            self.fc3Weights = tf.Variable(tf.truncated_normal([nodesFc2, nodesFc3], dtype = tf.float32, 
                                                         stddev = stdDev), name = 'weightsFc3')
            self.fc3Biases = tf.Variable(tf.constant(1.0, shape=[nodesFc3], dtype=tf.float32),
                                    trainable = True, name = 'biasesFc3')
            fc3Out = tf.nn.bias_add(tf.matmul(fc2Norm, self.fc3Weights), self.fc3Biases)
#            fc3Norm = tf.layers.batch_normalization(fc3Out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(fc3Out, [0])
            fc3Norm = tf.nn.batch_normalization(fc3Out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)
            
        # Fully Connected 2
        with tf.name_scope('fc4'):
            nodesFc4 = 1024
            self.fc4Weights = tf.Variable(tf.truncated_normal([nodesFc3, nodesFc4], dtype = tf.float32, 
                                                         stddev = stdDev), name = 'weightsFc4')
            self.fc4Biases = tf.Variable(tf.constant(1.0, shape=[nodesFc4], dtype=tf.float32),
                                    trainable = True, name = 'biasesFc4')
            fc4Out = tf.nn.bias_add(tf.matmul(fc3Norm, self.fc4Weights), self.fc4Biases)
#            fc4Norm = tf.layers.batch_normalization(fc4Out, training=self.isTraining)
            mean1, var1 = tf.nn.moments(fc4Out, [0])
            fc4Norm = tf.nn.batch_normalization(fc4Out, mean1, var1, None, None, variance_epsilon = varianceEpsilon)

        # Fully Connected 3 and Sigmoid Output
        with tf.name_scope('fc5'):
            self.fc5Weights = tf.Variable(tf.truncated_normal([nodesFc4, self.datasetInfo.classCount], dtype = tf.float32,
                                                         stddev = stdDev), name = 'weightsFc5')
            self.fc5Biases = tf.Variable(tf.constant(1.0, shape = [self.datasetInfo.classCount], dtype = tf.float32),
                                    trainable = True, name = 'biasesFc5')
            yLogits = tf.nn.bias_add(tf.matmul(fc4Norm, self.fc5Weights), self.fc5Biases)
            
            yOut = tf.nn.softmax(yLogits)
            
        


        # Loss
        with tf.name_scope('cross_entropy'):
            crossEntropy = tf.nn.softmax_cross_entropy_with_logits_v2(logits = yLogits, labels = self.y)
            self.loss = tf.reduce_mean(crossEntropy)

        # Train
        with tf.name_scope('train'):
            ## Updates Moving Averages for batchNorm
            update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
            with tf.control_dependencies(update_ops):
                self.trainStep = tf.train.AdamOptimizer(learning_rate = learningRate).minimize(self.loss)
            
        # Prediction
        with tf.name_scope('predict'):
            
            self.probabillities = tf.reshape(yOut, [-1, 1, self.datasetInfo.classCount])
            self.prediction = tf.argmax(self.probabillities, axis=2)
        
                # Accuracy
        with tf.name_scope('accuracy'):
            correctPrediction = tf.equal(tf.argmax(yOut, axis=1), tf.argmax(self.y, axis=1))
            
            self.accuracy = tf.reduce_mean(tf.cast(correctPrediction, tf.float32))
        
        # Confusion Matrix
        with tf.name_scope('confusion_matrix'):
            lab = tf.argmax(self.y, axis=1)
            self.confusionMatrix = tf.confusion_matrix( labels=tf.reshape(lab, [-1]), predictions=tf.reshape(self.prediction, [-1]), 
                                                       num_classes = self.datasetInfo.classCount)