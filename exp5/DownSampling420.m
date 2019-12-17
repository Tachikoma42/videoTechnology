function [Y,Cb,Cr]=DownSampling420(ycbcr)
    %input ycbcr: 3 channel image (h*w*3) of 4:4:4
    %output Y: one channel image (h*w); 
    %Cb: one channel image {(h/2)*(w/2)};
    %Cr: one channel image with the same size as Cb��
    % the subsampling mode follows the way named "4:2:0 MPEG-2 Frame picture(progressive)"
    % pay attention to the coefficient in the filter.
    Y = ycbcr(:,:,1);     
    U = ycbcr(:,:,2);     
    V = ycbcr(:,:,3);
    Cb = U(1:2:size(U,1),1:2:size(U,2));
    Cr = V(2:2:size(V,1),1:2:size(V,2));

end