function psnr = PSNR(img,img_new)
% PSNR函数：计算尺寸相同的两幅图像之间的峰值信噪比。
% Input
% img : 原始图像
% img_new : 处理后的图像
% Ouput
% psnr : 两幅图像之间的PSNR
[d1,r1,m1]=size(img);%若输入为灰度图像，则将灰度图像视为第三维元素0全为0的三维数组
[d2,r2,m2]=size(img_new);
if(d1~=d2||r1~=r2||m1~=m2)  Error('尺寸不匹配');  end

fenmu=zeros(1,3);
psnr_d3=zeros(1,3);
for i=1:d1
    for j=1:r1
        for k=1:m1
            fenmu(k)=fenmu(k)+(  double(img(i,j,k)) - double(img_new(i,j,k))  )^2;%计算公式的分母
        end
    end
end

for k=1:m1
    psnr_d3(k)=10*log10(d2*r2*255*255/fenmu(k));%psnr计算公式
    psnr=sum(psnr_d3)/m1;%若是彩色图像，其psnr等于RGB三个通道的psnr之和再除以3
end
end