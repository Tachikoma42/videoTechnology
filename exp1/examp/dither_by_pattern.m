function dimg=dither_by_pattern(img, pattern_size)
%input: img orignal gray scale image ranging from [0, 255], coded with
%8bits or color image with 3 channels;
%pattern_size: the size of the pattern for dither, 8 indicates 8X8;
%output: dimg, binary image
[d,r,m]=size(img);
dimg=zeros(d,r,m);
a=reshape( randperm(pattern_size^2)-1 , [pattern_size,pattern_size] );
%构建所需的抖动模板，行数和列数均为pattern_size，模板中每个整数仅出现一次，位置随机，每次运行所得的模板都不一样
shift_bits=2*log2(pattern_size)-8; %原图像色度值需要移位的位数，由式子2^(8-shift_bits)==pattern_size^2计算得出
for i=1:d
    for j=1:r
        for k=1:m
             if( bitshift( img(i,j,k),shift_bits ) > a( bitand(i,log2(pattern_size))+1  , bitand(j,log2(pattern_size))+1 ) );
% bitand位与函数；   位与后可能为0，为了满足下标为正整数，需+1               
                dimg(i,j,k)=255;
             else 
                dimg(i,j,k)=0;
             end
        end
    end
end
end