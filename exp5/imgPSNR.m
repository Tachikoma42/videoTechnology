function psnr = imgPSNR(before, after)
    [row, col] = size(before);
    MSE = sum(sum((double(before)-double(after)).^2))/(row*col);
    psnr = 10*log10(255^2/MSE);
end