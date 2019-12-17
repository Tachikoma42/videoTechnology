gamm = 1.9;
img=imread('lena.bmp');
subplot(1,2,1);
imshow(img);

luma_table=set_table(gamm);

tic
adjustedimg=gamma_adjust(img,luma_table);
%toc
adjustedimg=adjustedimg.*255.00;
adjustedimg=uint8(adjustedimg);
toc

subplot(1,2,2);
imshow(adjustedimg);
title(['running time: ',num2str(toc),' with gamma factor =',num2str(gamm)]);
