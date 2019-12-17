function psnr = PSNR(img,img_new)
% PSNR����������ߴ���ͬ������ͼ��֮��ķ�ֵ����ȡ�
% Input
% img : ԭʼͼ��
% img_new : ������ͼ��
% Ouput
% psnr : ����ͼ��֮���PSNR
[d1,r1,m1]=size(img);%������Ϊ�Ҷ�ͼ���򽫻Ҷ�ͼ����Ϊ����άԪ��0ȫΪ0����ά����
[d2,r2,m2]=size(img_new);
if(d1~=d2||r1~=r2||m1~=m2)  Error('�ߴ粻ƥ��');  end

fenmu=zeros(1,3);
psnr_d3=zeros(1,3);
for i=1:d1
    for j=1:r1
        for k=1:m1
            fenmu(k)=fenmu(k)+(  double(img(i,j,k)) - double(img_new(i,j,k))  )^2;%���㹫ʽ�ķ�ĸ
        end
    end
end

for k=1:m1
    psnr_d3(k)=10*log10(d2*r2*255*255/fenmu(k));%psnr���㹫ʽ
    psnr=sum(psnr_d3)/m1;%���ǲ�ɫͼ����psnr����RGB����ͨ����psnr֮���ٳ���3
end
end