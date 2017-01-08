# coding:utf-8
import os
import numpy as np
import cv2
import caffe
import matplotlib.pyplot as plt

prototxt = r"F:/fandy/hack/SRCNN/examples/SRCNN/SRCNN_deploynet.prototxt"
caffemodel = r"F:/fandy/hack/SRCNN/examples/SRCNN/snapshot/SRCNN_iter_15000000.caffemodel"

if not os.path.isfile(caffemodel):
    print ("caffemodel not found!")
caffe.set_mode_cpu()
net = caffe.Net(prototxt,caffemodel,caffe.TEST)
print("blobs {}\nparams {}".format(net.blobs.keys(), net.params.keys()))

input = cv2.imread("butterfly_GT.bmp",0)

up_scale = 4

input_down = cv2.resize(input,(input.shape[0]/up_scale,input.shape[1]/up_scale),interpolation=cv2.INTER_CUBIC)
input_up = cv2.resize(input_down,(input.shape[0],input.shape[1]),interpolation=cv2.INTER_CUBIC)

img_blobinp = input_up[np.newaxis, np.newaxis, :, :]/255.0
net.blobs['data'].reshape(*img_blobinp.shape)
net.blobs['data'].data[...] = img_blobinp
#transformer.set_channel_swap('data', (2,1,0))

out = net.forward()
o = 255.0*net.blobs['conv3'].data[0,0]
i = 255.0*net.blobs['data'].data[0,0]

otmp = np.zeros((input.shape[0],input.shape[1]),dtype=np.uint8)
otmp[6:o.shape[0]+6,6:o.shape[1]+6] = o[:,:]

plt.subplot(1,3,1)
plt.title('src ')
plt.imshow(input,cmap='gray')

plt.subplot(1,3,2)
plt.title('low-resolution ')
plt.imshow(i,cmap='gray')

plt.subplot(1,3,3)
plt.title('reconstrcut ')
plt.imshow(otmp,cmap='gray')
#plt.show()
plt.savefig("src_lr_re.jpg")
