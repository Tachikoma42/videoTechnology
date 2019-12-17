function [ p_img ] = get_pseudo_image( pseudo_indx, CLUT )
    %this function returns the pseudo color image represented by the index and
    %the CLUT.
    %input: pseudo_indx, 2d matrix. each element represents the index value for CLUT 
    %input: CLUT, color look-up-table, consisting of the browser safe pseudo color table (216*3)
    %output: pseudo image.(w*h*3), each pixel value retrieves from the CLUT
    [row, col] = size(pseudo_indx);
    p_img = zeros(row, col, 3);%same as original pic
    for i = 1:row
        for j = 1:col
            index = pseudo_indx(i,j);%get clut index 
            p_img(i,j,:) = CLUT(index,:);%use clut data to assign  color to p_img
        end
    end
    p_img = uint8(p_img);
end



