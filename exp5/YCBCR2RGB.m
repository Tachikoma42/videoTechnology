function rgb= YCBCR2RGB(ycbcr)
    %input ycbcr: 3 channel image (h*w*3)
    %output rgb: 3 channel image (h*w*3)
    [h, w, z]=size(ycbcr);
    rgb=zeros(h,w,z);
    TR=[298.082, 0, 408.583; 298.082, -100.291, -208.120; 298.082, 516.411, 0];
    offset=[16;128;128];

    ycbcr=double(ycbcr);
    %ycbcr=ycbcr./255.0;
    for i=1:h
        for j=1:w
            rgb(i,j,:)=TR*[ycbcr(i,j,1)-16;ycbcr(i,j,2)-128;ycbcr(i,j,3)-128]/255.0;
        end
    end
    rgb = uint8(rgb);
end