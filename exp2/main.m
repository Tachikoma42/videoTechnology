img = imread('gray.bmp');
brightness = 50;
contrast = -50;

conImg = control_contrast(img, contrast);
brightImg = control_brightness(img, brightness);

conPSNR = imgPSNR(img, conImg);
brightPSNR = imgPSNR(img, brightImg);

subplot(1,3,1);
imshow(img);
title('original');

subplot(1,3,2);
imshow(conImg);
title(['contrast changed pic with PSNR = ',num2str(conPSNR)]);

subplot(1,3,3);
imshow(brightImg);
title(['brightness changed pic with PSNR = ',num2str(brightPSNR)]);