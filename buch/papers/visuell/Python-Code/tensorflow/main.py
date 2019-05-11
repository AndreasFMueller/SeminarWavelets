from model_manager import ModelManager

numEpochs = 5
modelPath = 'outputs/model'
maxDataSize = 200000
miniBatchSize = 256
mdlManager = ModelManager()
gaborInput = False
features1 = 64

def train():
    logDir = mdlManager.createLogDir(modelPath)
    mdlManager.getData(maxDataSize, gaborInput, features1)
    mdlManager.build(miniBatchSize)
    mdlManager.train(logDir, numEpochs)
    mdlManager.printNumberOfWeights()
    mdlManager.saveModel(logDir)


if __name__ == '__main__':
    train()