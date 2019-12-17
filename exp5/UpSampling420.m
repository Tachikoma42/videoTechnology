function ycbcr=UpSampling420(Y,Cb,Cr)
    %input Y: one channel image (h*w); Cb: one channel image {(h/2)*(w/2)};
    %Cr: one channel image with the same size as Cb
    %output ycbcr: 3 channel image (h*w*3) of 4:4:4
    [width, height] = size(Y); 

    U = zeros(width, height, 'uint8');
    V = zeros(width, height, 'uint8');

    U(1:2:width-1, 1:2:height-1) = Cb(:,:);
    U(1:2:width-1, 2:2:height)   = Cb(:,:); 
    U(2:2:width, 1:2:height-1)   = Cb(:,:); 
    U(2:2:width, 2:2:height)     = Cb(:,:);

    V(1:2:width-1, 1:2:height-1) = Cr(:,:);
    V(1:2:width-1, 2:2:height)   = Cr(:,:);
    V(2:2:width, 1:2:height-1)   = Cr(:,:);
    V(2:2:width, 2:2:height)     = Cr(:,:);
    ycbcr(:,:,1) = Y;
    ycbcr(:,:,2) = U;
    ycbcr(:,:,3) = V;
end
