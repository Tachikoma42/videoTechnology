function result=control_contrast(img, levels)
    % input: img: the orignal gray scale image ranging from [0, 255], coded with 8bits
    %        levels: integer value. the parameter controls the brightness, ranging from [-100, 100]
    % output result: with the same size as input img, still ranging from [0,255], but the brightness is controled by the input levels
    [row, col] = size(img);
    for i = 1:row
        for j = 1:col
            
            if levels <0
                degree = levels/(-100)*45;
                gain = tan(degree/360*2*pi);
            else
                degree = levels/100*45+45;
                gain = tan(degree/360*2*pi);
            end
            temp = gain*(img(i,j)-127.5);
            temp = temp+127.5;
            if temp<0
                temp = 0;
            elseif  temp > 255
                temp = 255;
            end
            result(i,j) = temp;
        end
    end