function B=bayerGenerator(N)
    % generate the bayer matrix
    N=N+rem(N,2);

    A=[0 2; 3 1];

    while(size(A,1)<N)
        B=zeros(size(A,1)*2, size(A,2)*2);

        delta=length(A(:));
        for l=0:delta-1
            [m,n]=find(A==l);
            B(2*m-1:2*m,2*n-1:2*n)=[0 2; 3 1]*delta+l;
        end
        A=B;
    end

    return;


    C=zeros(3*size(B,1),size(B,2));
    C(1:3:end,:)=B;
    C(2:3:end,:)=B+256;
    C(3:3:end,:)=B+512;
    C=double(C)/max(max(C));

    for m=1:size(C,2)
        C(:,m)=histeq(C(:,m));
    end

end

