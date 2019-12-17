function [img_after]=gamma_adjust(img_before,table)
    %image_before is the function before adjestment
    %search table
    %img_before = uint8(img_before);
    img_after = table(img_before+1);%img_before range from 0-255 so add 1 to match table index

%     img_after = img_after.*255;
%     img_after = uint8(img_after);
end