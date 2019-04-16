from model_manager import ModelManager

numEpochs = 2
modelPath = 'outputs/model'
maxDataSize = 200000
miniBatchSize = 256
mdlManager = ModelManager()

def train():
    logDir = mdlManager.createLogDir(modelPath)
    mdlManager.getData(maxDataSize)
    mdlManager.build(miniBatchSize)
    mdlManager.train(logDir, numEpochs)
    mdlManager.printNumberOfWeights()
    mdlManager.saveModel(logDir)


if __name__ == '__main__':
    train()