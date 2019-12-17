function qimg=quantize_image(img, bits)
% input: img: the orignal gray scale image ranging from [0, 255], coded with 8bits
%        bits: number of the bits that we want to use for the result image, less than (or equal) 8bits but larger than 0 
% output qimg: with the same size as input img, still ranging from [0,255], but coded with less bits (less graylevels)
    Max = 255;
    Min = 0;
    delv = (Max - Min)/2^bits;
    [row, col] = size(img);
    for i = 1 :2^bits + 1
        table(i) = Min + delv*(i - 1);
    end
    qimg = img;
    for i = 1 : row*col
        for j = 1:2^bits
            if qimg(i) >= table(j) && qimg(i) <= table(j+1)
                qimg(i) = (table(j) + table(j+1))/2;
                break
            end
        end
    end
    
end