梳理论文 [ Image Super-Resolution Using Deep Convolutional Networks ](http://mmlab.ie.cuhk.edu.hk/projects/SRCNN.html)中的图像重建方案，并进行模型训练和测试。

### 流程

系统的 pipeline 如下图所示：

![pipe][pipeline]
[pipeline]:img/pipeline.png

学习任务可描述为：学习由Y(低清图像)到X(高清图像)映射f(Y)=X。

#### patch 提取与表达

从低清图像中有重合地提取图像patch,提取每个patch的高维特征。这些特征组成了一个featrue map集合  size(patchs) = size(map set)。

#### 非线性映射

将每个高维特征非线性地映射到其他的高维特征，映射的特征概念上是高清图块的特征表达。

#### 重建

使用上述映射得到的高维特征（拟合的高清图块的表达）组合起来，生成重建的高清图像，期望重建的图像与X相似。

### model training

训练此模型的步骤如下,大部分源码由作者公开在[这里](http://mmlab.ie.cuhk.edu.hk/projects/SRCNN.html)：

* 使用 ```Train/``` 目录下的91张图片进行训练，使用 ```generate_*.m``` 脚本生成训练数据和测试数据。
* 将生成的h5 文件和相应的网络模型配置文件放置到合适的路径，基于caffe DL 框架进行训练。
* 将训练过程中的 loss 等信息记录下来，便于进行训练过程分析和检测。

实际训练中，监测曲线如下图：

![train_test][tt]
[tt]:img/SRCNN_train_test_curve.jpg

可取checkpoint为400万次iterate，模型在```examples/SRCNN/snapshot/ ```中给出，网络已经收敛。

### model 部署

#### matlab test 

 ```SRCNN-test/``` 中给出了多种模型参数配置（网络层数、filter size、训练集等）下的模型文件。可进行对比实验。下面使用imageNet 9-3-5 模型测试得到。

![sr][sr]
[sr]:img/super-resolution.jpg

#### python test with caffe 

使用```demo/demo.py```进行测试，先将原图进行下采样和上采样，获得低分辨率图像，再进行重建。
下面使用91Train 9-1-5 模型测试得到。效果比使用```imageNet```训练的略差。
![re][re]
[re]:demo/src_lr_re.jpg

### 应用点

* 图像重建：获取高分辨率的图像，利于模式识别等任务中获得较高的识别率。

* 图像去噪：去除图像中的噪声，保留图像本身具备的结构特征。

### dataset

#### train 

Set5: refer M. Bevilacqua, A. Roumy, C. Guillemot, and M. L. A. Morel,
“Low-complexity single-image super-resolution based on nonnegative
neighbor embedding,” in Proc. Brit. Mach. Vis. Conf.,
2012, pp. 1–10.

Set14: refer R. Zeyde, M. Elad, and M. Protter, “On single image scale-up
using sparse-representations,” in Proc. 7th Int. Conf. Curves Surfaces,
2012, pp. 711–730.

#### test

BSD200：refer D. Martin, C. Fowlkes, D. Tal, and J. Malik, “A database of human
segmented natural images and its application to evaluating segmentation
algorithms and measuring ecological statistics,” in
Proc. IEEE Int. Conf. Comput. Vis., 2001, vol. 2, pp. 416–423.

含有200张图片.