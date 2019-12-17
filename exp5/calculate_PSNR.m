function [ psnr ] = calculate_PSNR( before, after )
    % This function calculates PSNR.
    % Input: original image in org_img, and reconstruction image in rec_img.
    % Ouput: a single PSNR value
    psnr = 0;
    for i = 1:3
        psnr = psnr + imgPSNR(before(:,:,i),after(:,:,i));%imgPSNR is the old code from exp1
    end
    psnr = psnr/3;
end