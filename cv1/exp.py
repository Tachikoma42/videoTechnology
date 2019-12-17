import cv2
import numpy as np

img = cv2.imread('watch.jpg',cv2.IMREAD_COLOR)
px = img[55,55]
img[55,55] = [255,255,255]
px = img[55,55]
print(px)
px = img[100:150,100:150]
print(px)
cv2.imshow('image',img)
cv2.waitKey(0)
cv2.destroyAllWindows()