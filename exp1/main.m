%constant
reQuantization = 2;
templateSize = 8;
grayDbits = 3;
colorDbits = 6;


%read pic into matlab
grayPic = imread('gray.bmp');
colorPic = imread('color.jpg');

subplot(2,4,1);
imshow(grayPic);
title('input gray');

subplot(2,4,5);
imshow(colorPic);
title('input color');

% requantization gray picture;
reqGrayPic = quantize_image(grayPic, reQuantization);

subplot(2,4,2);
imshow(reqGrayPic);
grayPsnr = imgPSNR(grayPic, reqGrayPic);
title(['reQuantization Gray Pic with PSNR = ',num2str(grayPsnr)]);


% requantization color picture;
for i = 1:3
    reqColorPic(:,:,i) = quantize_image(colorPic(:,:,i),reQuantization);
end

subplot(2,4,6);
imshow(reqColorPic);
colorPsnr = 0;
for i = 1:3
    colorPsnr = colorPsnr + imgPSNR(colorPic(:,:,i),reqColorPic(:,:,i));
end
colorPsnr = colorPsnr/3;
title(['reQuantization Color Pic with PSNR = ',num2str(colorPsnr)]);

%dither process
ditherGrayPic = dither_by_pattern(grayPic, templateSize);
subplot(2,4,3);
imshow(ditherGrayPic);
title('dithered gray pic');

ditherColorPic = dither_by_pattern(colorPic, templateSize);
subplot(2,4,7);
imshow(ditherColorPic);
title('dithered color pic');

fsGrayPic = floyd_steinberg(grayPic, grayDbits);%dbits should fit the requirement
subplot(2,4,4);
imshow(fsGrayPic);
grayPsnr = imgPSNR(grayPic, fsGrayPic);
title(['floyd_steinberg gray pic with PSNR = ',num2str(grayPsnr)]);

fsColorPic = floyd_steinberg(colorPic, colorDbits);%dbits should fit the requirement
subplot(2,4,8);
imshow(fsColorPic);
colorPsnr = 0;
for i = 1:3
    colorPsnr = colorPsnr + imgPSNR(colorPic(:,:,i),fsColorPic(:,:,i));
end
colorPsnr = colorPsnr/3;
title(['floyd_steinberg color pic with PSNR = ',num2str(colorPsnr)]);





