function [ CLUT ] = construct_CLUT(r_val, g_val, b_val)
    %This function forms the CLUT.
    %r_val: input, code values that are available in the Red channel
    %g_val: input, code values that are available in teh grean channel
    %b_val: input, code values that are available in teh blue channel
    %CLUT: Output, color look up table.
    %you can construct the CLUT within 3 for loops. hopefully, it won't take u
    %much time.

    cap = length(r_val)*length(g_val)*length(b_val);
    CLUT = zeros(cap, 3);
    index =1;
    for i = 1:length(r_val)
        for j = 1:length(g_val)
            for k = 1:length(b_val)
                CLUT(index,:) = [r_val(i),g_val(j),b_val(k)];%use predefined rgb value to construct clut table
                index = index + 1;
            end
        end
    end
end




