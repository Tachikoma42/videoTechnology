function result=control_brightness(img, levels)
    % The function performs the brightness control like the figure 3.7 on page 37 in the textbook
    % input: img: the orignal gray scale image ranging from [0, 255], coded with 8bits
    %        levels: integer value. the parameter controls the brightness, ranging from [-255, 255]
    % output result: with the same size as input img, still ranging from [0,255], but the brightness is controled by the input levels
    [row, col] = size(img);
    for i = 1:row
        for j = 1:col
            result(i,j) = img(i,j)+ levels;
            if result(i,j)<0
                result(i,j) = 0;
            elseif  result(i,j) > 255
                result(i,j) = 255;
            end
        end
    end
end