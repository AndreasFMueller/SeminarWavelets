# -*- coding: utf-8 -*-
"""
Created on Fri Mar 29 11:33:29 2019

@author: runterer
"""
import time
import sys
length = 110
height = 4

def buildTrain(wagons, pos):
    
    height = len(wagons[0])
    
    lines = []
    for i in range(0,height):
        line = ""
        for j in range(len(wagons)):
            line += wagons[j][i]
        lines.append(line)
    
    
    ret = ""
    for i in range(0,height):
        trainlen = len(lines[i])
        retLine = "|" + " "*min(max(pos-(trainlen-1), 0), length)
        retLine += lines[i][max(0, trainlen-1-pos):max(min(length-pos+trainlen-1, trainlen-1), 0)]
        retLine += " "*min(max(length-pos, 0), length) +" "
        ret += retLine
    return ret

def buildWagon(name):
    i = len(name)
    if i % 2:
        x = 0
    else:
        x = 1
    line0 = " _" + "_"*(i+x) + "_  "
    line1 = "| " + " "*(i+x) + " |="
    line2 = "| " + name + " "*x + " | "
    line3 = "\@-" + "@-"*(i//2) + "@/ "
    
    return [line0, line1, line2, line3]

def getTrain():
    train = []
    train.append("____       ")
    train.append("|DD|____T_ ")
    train.append("|_ |_____|<")
    train.append("  @-@-@-oo\\")
    return train
           
if __name__== "__main__":
    for i in range(-10,150):
        space=['','','','']
        for j in range(0,height):
            space[j]=(i*" ")
        trainArray = [buildWagon("Epoch 1"), buildWagon("Accuracy: 34%"), getTrain()]
        print("\r" + buildTrain(trainArray, i), end='')
        time.sleep(0.1)
        sys.stdout.flush()
        
