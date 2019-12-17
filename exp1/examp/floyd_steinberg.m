function result_img = floyd_steinberg(image, dbits)
% input : image is the original image that you need to give. here you need
%         to consider both the color image and the gray one. In color image, each
%         of its channel ranges from 0-255(24 bits); in gray image, there is only
%         one channel ranging from 0-255(8 bits)
% input: dbits is the final total bits that you want to specify in the
%        result image. In gray image, it can be any integer value less than
%        8. In color image, it should be an interger value less than 24.
%        And it can also be divided by 3 (using the same bits count in the r'g'b' channel)
% output: result_image is the output image with the same dimensions as the
%         input.
% requirements: try to use your previous function "quantize_image". In this function, call that
% "quantize_image" first, then add the weighted error values to the later pixels. you should also
% write a main function to call "floyd_steinberg". and finally, you compute the psnr value in the main function. 
 
[d,r,m]=size(image);
if( m>1  && dbits/3~=fix(dbits/3) ) 
    error('输入参数“dbits”无效');
end
if(m==1 && dbits>=8 )
    error('输入参数“dbits”无效');
end
if (m==3)%若为彩色图像
    dbits=dbits/3;
end
result_img =quantize_image(image, dbits);%调用quantize_image函数，进行重新量化
quant_error=image-result_img ;     %求出量化误差矩阵
for i=2:d-1 %边界不做处理
    for j=1:r-1 %边界不做处理
            for k=1:m
                result_img(i+1,j,k)=result_img(i+1,j,k)+quant_error(i,j,k)*7/16;
                result_img(i-1,j+1,k)=result_img(i-1,j+1,k)+quant_error(i,j,k)*3/16;
                result_img(i,j+1,k)=result_img(i,j+1,k)+quant_error(i,j,k)*5/16;
                result_img(i+1,j+1,k)=result_img(i+1,j+1,k)+quant_error(i,j,k)*1/16;
            end
     end

end
end
