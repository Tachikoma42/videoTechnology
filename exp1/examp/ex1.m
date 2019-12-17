clear;
%����ȫ�ֱ���
pattern_size=8;%dither�����Ĳ���
dbits_color=6;
dbits_gray=2;

image_old_color=imread('lena.jpg');
image_old_gray=imread('lena.bmp');

subplot(2,3,1);
imshow(image_old_color);
title('ԭ��ɫͼ��');

subplot(2,3,4);
imshow(image_old_gray);
title('ԭ�ڰ�ͼ��');

image_d_color=dither_by_pattern(image_old_color, pattern_size); %dither��������ֱ�Ӵ����ɫͼ���ڰ�ͼ��
subplot(2,3,2);
imshow(image_d_color);
title('dither���������ɫͼ��');

image_d_gray=dither_by_pattern(image_old_gray, pattern_size); %dither��������ֱ�Ӵ����ɫͼ���ڰ�ͼ��
subplot(2,3,5);
imshow(image_d_gray);
title('dither��������ڰ�ͼ��');

image_f_color=floyd_steinberg(image_old_color, dbits_color);
subplot(2,3,3);
imshow( image_f_color );%floyd��������ֱ�Ӵ����ɫͼ���ڰ�ͼ��
title('floyd���������ɫͼ��');

image_f_gray=floyd_steinberg(image_old_gray, dbits_gray);
subplot(2,3,6);
imshow( image_f_gray );%floyd��������ֱ�Ӵ����ɫͼ���ڰ�ͼ��
title('floyd��������ڰ�ͼ��');

psnr_color=PSNR(image_old_color,image_f_color)
psnr_gray=PSNR(image_old_gray,image_f_gray)
