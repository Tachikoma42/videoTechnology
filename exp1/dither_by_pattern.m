function dimg=dither_by_pattern(img, pattern_size)
    %input: img orignal gray scale image ranging from [0, 255], coded with
    %8bits or color image with 3 channels;
    %pattern_size: the size of the pattern for dither, 8 indicates 8X8;
    %output: dimg, binary image
    [row, col, channel] = size(img);
    whiteDot = 255;
    blackDot = 0;
    %build dither template
    bayer = bayerGenerator(pattern_size);
    %dimg = dither(img,bayer);
    % if channel == 1
    %     dimg = subdither(img, pattern_size);
    % else
    %     for i = 1:3
    %         dimg(:,:,i) = subdither(img(:,:,i),pattern_size);
    %     end
    % end

    %if (img[y][x]>>2) >bayer[y&7][x&7] 
    %    white dot 
    %else  
    %    black dot

    for i = 1:row
        for j = 1:col
            for k = 1:channel
                if bitshift(img(i,j,k),(log2(pattern_size^2)-8)) > bayer(bitand(i,log2(pattern_size))+1, bitand(j, log2(pattern_size))+1)%matlab subscript starts from 1
                    dimg(i,j,k) = whiteDot;
                else
                    dimg(i,j,k) = blackDot;
            end
        end
    end
    
end