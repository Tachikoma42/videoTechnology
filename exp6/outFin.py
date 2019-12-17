import glob as gb
import cv2
import numpy as np



def meanFilter(imgBatch, batchSize):
    output = np.mean(imgBatch, axis=0).astype(np.uint8)
    return output

def medianFilter(imgBatch, batchSize):
    output = np.median(imgBatch, axis=0).astype(dtype=np.uint8)
    return output   

def momentumFilter(imgBatch, momentum,batchSize):
    output = np.zeros((240,320,3), np.uint8)
    output = output.astype(np.float32)
    for i in range (batchSize):
        output = momentum*output + (1-momentum)*imgBatch[i]
    output = output.astype(np.uint8)
    return output

def backgroundGet(imgBatch,batchSize, mode):
    if mode == 0:
        background = meanFilter(imgBatch, batchSize)
    elif mode == 1:
        background = medianFilter(imgBatch, batchSize)
    else:
        background = momentumFilter(imgBatch, momentum, batchSize)

    return background

def IoUGet(background,imgBatch,resultButch,thValue):
    for th in thValue:
        IoU = 0
        for i in range(batchSize):
            diff = abs(imgBatch[i]-background)
            aboveTh = (diff>th)*255
            cmpres=abs(aboveTh-resultButch[i])
            totalDiff = cmpres > 0
            fpfn=sum(sum(sum(totalDiff*1,3)))
            tp=240*320-fpfn
            IoU=IoU + tp / (240*320)
        IoU=IoU / batchSize
        print("when th = " + str(th) + " IoU = " + str(IoU) )

def mergedProcess(inputPath, groundPath, batchSize, start, momentum, thValue):
    for i in range(3):
        if i == 0:
            modeName = 'mean'
        elif i == 1:
            modeName = 'median'
        else:
            modeName = 'momentum'
        print("in mode "+modeName+" BatchSize = 500: ",end="\n")
        imgBatch= []
        resultButch = []
        for j in range(batchSize):
            img = cv2.imread(inputPath[start+j])
            img = img.astype(np.float32)
            imgBatch.append(img)
        background = backgroundGet(imgBatch, batchSize, i)

        for j in range(batchSize):
            img = cv2.imread(groundPath[start+j])
            img = img.astype(np.float32)
            resultButch.append(img)
        IoUGet(background,imgBatch,resultButch,thValue)



if __name__ == '__main__':
    inputPath = gb.glob("highway\\input\\*.jpg")
    groundPath = gb.glob("highway\\groundtruth\\*.png")
    batchSize = 500
    start = 500

    momentum = 0.9
    thValue = [20,50,100]
    mergedProcess(inputPath, groundPath, batchSize, start, momentum, thValue)
    
        
