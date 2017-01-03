function hr_img = sr_color(lr_img,model)
%UNTITLED2 此处显示有关此函数的摘要
%   lr_img is the low resolution color image of ycbcr space
lr_img = single(lr_img)/255;

hr_img = zeros(size(lr_img,1),size(lr_img,2),3);
for i =1:3
   img_split = lr_img(:,:,i);
   img_split_sr = SRCNN(model,img_split);
   hr_img(:,:,i) = img_split_sr;
 
end
hr_img = uint8(hr_img*255);

end

