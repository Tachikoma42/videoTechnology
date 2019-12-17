function db=PSNR(A,B)
[m n]=size(A);
[h w]=size(B);
if m~=h&&n~=w
    error('两图像大小不相同')
end
if A == B
   error('两图像相同')
end
imga=double(A);
imgb=double(B);
MES=sum(sum((imga-imgb).^2))/(m*n);
db=20*log10(255/sqrt(MES));
end

