rgb=(imread('lena.jpg'));
subplot(1,2,1);
imshow(rgb);
title("Original");
ycbcr = RGB2YCBCR(rgb);
[Y,Cb,Cr] = DownSampling420(ycbcr);
ycbcr = UpSampling420(Y, Cb, Cr);
% recRGB = ycbcr2rgb(ycbcr);
recRGB = YCBCR2RGB(ycbcr);
PSNR(rgb, recRGB)
subplot(1,2,2);
imshow(recRGB);
rePSNR = calculate_PSNR(rgb, recRGB);
title(["Reconstructed image with a PSNR of ", num2str(rePSNR)]);
