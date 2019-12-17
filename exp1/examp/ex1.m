clear;
%定义全局变量
pattern_size=8;%dither函数的参数
dbits_color=6;
dbits_gray=2;

image_old_color=imread('lena.jpg');
image_old_gray=imread('lena.bmp');

subplot(2,3,1);
imshow(image_old_color);
title('原彩色图像');

subplot(2,3,4);
imshow(image_old_gray);
title('原黑白图像');

image_d_color=dither_by_pattern(image_old_color, pattern_size); %dither函数可以直接处理彩色图像或黑白图像
subplot(2,3,2);
imshow(image_d_color);
title('dither函数处理彩色图像');

image_d_gray=dither_by_pattern(image_old_gray, pattern_size); %dither函数可以直接处理彩色图像或黑白图像
subplot(2,3,5);
imshow(image_d_gray);
title('dither函数处理黑白图像');

image_f_color=floyd_steinberg(image_old_color, dbits_color);
subplot(2,3,3);
imshow( image_f_color );%floyd函数可以直接处理彩色图像或黑白图像
title('floyd函数处理彩色图像');

image_f_gray=floyd_steinberg(image_old_gray, dbits_gray);
subplot(2,3,6);
imshow( image_f_gray );%floyd函数可以直接处理彩色图像或黑白图像
title('floyd函数处理黑白图像');

psnr_color=PSNR(image_old_color,image_f_color)
psnr_gray=PSNR(image_old_gray,image_f_gray)
