function db=PSNR(A,B)
[m n]=size(A);
[h w]=size(B);
if m~=h&&n~=w
    error('��ͼ���С����ͬ')
end
if A == B
   error('��ͼ����ͬ')
end
imga=double(A);
imgb=double(B);
MES=sum(sum((imga-imgb).^2))/(m*n);
db=20*log10(255/sqrt(MES));
end

