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
    [row, col, channel] = size(image);
    %dbits should fit the requirement
    if (channel == 3)
        dbits = dbits/3;
    end
    result_img = quantize_image(image, dbits);
    quant_error = image - result_img;
    
    for x = 2:row-1%ignore border
        for y = 2:col-1
            for k = 1:channel
                result_img(x+1,y,k)=result_img(x+1,y,k)+quant_error(x,y,k)*7/16;
                result_img(x-1,y+1,k)=result_img(x-1,y+1,k)+quant_error(x,y,k)*3/16;
                result_img(x,y+1,k)=result_img(x,y+1,k)+quant_error(x,y,k)*5/16;
                result_img(x+1,y+1,k)=result_img(x+1,y+1,k)+quant_error(x,y,k)*1/16;
            end
        end
    end

end 