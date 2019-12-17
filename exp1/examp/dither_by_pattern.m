function dimg=dither_by_pattern(img, pattern_size)
%input: img orignal gray scale image ranging from [0, 255], coded with
%8bits or color image with 3 channels;
%pattern_size: the size of the pattern for dither, 8 indicates 8X8;
%output: dimg, binary image
[d,r,m]=size(img);
dimg=zeros(d,r,m);
a=reshape( randperm(pattern_size^2)-1 , [pattern_size,pattern_size] );
%��������Ķ���ģ�壬������������Ϊpattern_size��ģ����ÿ������������һ�Σ�λ�������ÿ���������õ�ģ�嶼��һ��
shift_bits=2*log2(pattern_size)-8; %ԭͼ��ɫ��ֵ��Ҫ��λ��λ������ʽ��2^(8-shift_bits)==pattern_size^2����ó�
for i=1:d
    for j=1:r
        for k=1:m
             if( bitshift( img(i,j,k),shift_bits ) > a( bitand(i,log2(pattern_size))+1  , bitand(j,log2(pattern_size))+1 ) );
% bitandλ�뺯����   λ������Ϊ0��Ϊ�������±�Ϊ����������+1               
                dimg(i,j,k)=255;
             else 
                dimg(i,j,k)=0;
             end
        end
    end
end
end