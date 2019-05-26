from model_manager import ModelManager
from termcolor import colored

numEpochs = 5

maxDataSize = 200000
miniBatchSize = 256
mdlManager = ModelManager()

features1 = 64
filterSize1 = 9

def train(gaborInput, modelPath):
    logDir = mdlManager.createLogDir(modelPath)
    mdlManager.getData(maxDataSize, gaborInput, features1, filterSize1)
    mdlManager.build(miniBatchSize)
    mdlManager.train(logDir, numEpochs)
    mdlManager.printNumberOfWeights()
    mdlManager.saveModel(logDir)
    mdlManager.reset()
    
def printLogo():
    logo = """
      __  __       _   _      _____                  ___   ___  __  ___  
     |  \/  |     | | | |    / ____|                |__ \ / _ \/_ |/ _ \ 
     | \  / | __ _| |_| |__ | (___   ___ _ __ ___      ) | | | || | (_) |
     | |\/| |/ _` | __| '_ \ \___ \ / _ \ '_ ` _ \    / /| | | || |\__, |
     | |  | | (_| | |_| | | |____) |  __/ | | | | |  / /_| |_| || |  / / 
     |_|  |_|\__,_|\__|_| |_|_____/ \___|_| |_| |_| |____|\___/ |_| /_/  
     \ \        / /            | |    | |                                
      \ \  /\  / /_ ___   _____| | ___| |_ ___                           
       \ \/  \/ / _` \ \ / / _ \ |/ _ \ __/ __|                          
        \  /\  / (_| |\ V /  __/ |  __/ |_\__ \                          
         \/  \/ \__,_| \_/ \___|_|\___|\__|___/                          
                                                                         
      """                                                                   
    print(colored(logo, 'green'))
    
    
def printFinish():
    logo = """
      ______ _       _     _              _   _______        _       _               _   _ 
     |  ____(_)     (_)   | |            | | |__   __|      (_)     (_)             | | | |
     | |__   _ _ __  _ ___| |__   ___  __| |    | |_ __ __ _ _ _ __  _ _ __   __ _  | | | |
     |  __| | | '_ \| / __| '_ \ / _ \/ _` |    | | '__/ _` | | '_ \| | '_ \ / _` | | | | |
     | |    | | | | | \__ \ | | |  __/ (_| |    | | | | (_| | | | | | | | | | (_| | |_| |_|
     |_|    |_|_| |_|_|___/_| |_|\___|\__,_|    |_|_|  \__,_|_|_| |_|_|_| |_|\__, | (_) (_)
                                                                              __/ |        
                                                                             |___/                                                                            
      """                                                                   
    print(colored(logo, 'green'))


if __name__ == '__main__':
    gaborInput = True
    modelPath = 'outputs/model_gabor'
    for i in range(1):
        printLogo()
        train(gaborInput, modelPath)
        printFinish()
    gaborInput = False
    modelPath = 'outputs/model_native'
    for i in range(1):
        printLogo()
        train(gaborInput, modelPath)
        printFinish()