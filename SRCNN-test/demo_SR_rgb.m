%demo£ºcolor image reconstruction

close all;clear all;

%read color ground image
% im = imread('low-resolution/11-1.jpg');
% im = imread('low-resolution/22-11.jpg');
im = imread('Set14/face.bmp');
% im = imread('low-resolution/18-4.jpg');
% im = imread('low-resolution/23-172.jpg');
% im = imread('low-resolution/19-1.jpg');

% im = rgb2ycbcr(im);
if(size(im,3)>1)
    im = rgb2ycbcr(im);
end
model = 'model/9-5-5(ImageNet)/x3.mat';

im_no = imnoise(im,'gaussian',0,0.001);
im_sr = sr_color(im_no,model);

% compute PSNR
psnr_srcnn = compute_psnr(im,im_sr);

% show results
fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);

% conbineimg = [im_gnd im_upscale im_r_sr];
conbineimg = [im im_no im_sr];
conbineimg = ycbcr2rgb(conbineimg);
figure,imshow(conbineimg);
title('src image                                           with gaussi nosie                                         denoising image');



