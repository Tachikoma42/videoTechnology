function [ pseudo_indx ] = calculate_pseudo_indx( true_clr_img, CLUT )
    % ThIS function calculates the index value for each pixel 
    % in the true color image.
    % input: true_clr_img, 24bits for each pixel, (w*h*3). 
    % input: CLUT, color look-up-table, consisting of the 
    % browser safe pseudo color table (216*3)
    % output: pseudo_indx, pseudo index matrix. Each value 
    % ranging from 0-215
    [row, col, ~] = size(true_clr_img);%use ~ to ignore
    pseudo_indx = zeros(row, col);
    for i = 1:row
        for j = 1:col
            color = true_clr_img(i,j,:);
            color = reshape(color,[1, 3]);%[r,j,b];
            dif = sum(abs(double(CLUT)-double(color)),2);%return a col vector containing the sum of each row
            %then use min to get the index of the minimum number
            [~, n] = min(dif); 
            pseudo_indx(i,j) = n;

        end
    end
end


