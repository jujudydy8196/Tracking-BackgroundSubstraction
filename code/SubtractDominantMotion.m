function mask = SubtractDominantMotion(image1, image2)

    it = im2double(image1);
    it1= im2double(image2);
    [x,y]=meshgrid(1:size(it,2),1:size(it,1));

    M = LucasKanadeAffine(it, it1);

    idx = [x(:)' ; y(:)'; ones(1,size(x(:),1)) ];
    T1idx=zeros(3,size(idx,2));
    for j=1:size(idx,2)
        T1idx(:,j)=M*idx(:,j);
    end
    T1idx(1,(T1idx(1,:)<0))=0;
    T1idx(2,(T1idx(2,:)<0))=0;
    T1idx(1,(T1idx(1,:)>size(it1,2)))=size(it1,2);
    T1idx(2,(T1idx(2,:)>size(it1,1)))=size(it1,1);
    T1idx=T1idx(1:2,:);
    [cinterp,rinterp]=meshgrid(min(T1idx(1,:)):max(T1idx(1,:)),min(T1idx(2,:)):max(T1idx(2,:)));
    T1=interp2(x,y,it1,cinterp,rinterp);
    T1=imresize(T1,size(it1));
    diff = abs(T1-it);
    diff(isnan(diff))=0;
    mask=im2bw(diff,0.2);

    se = strel('disk',1);    
    m1=imdilate(mask,se);
    m1=bwfill(m1,'holes');
    m2=bwareaopen(m1,100);
    m4=bwareaopen(m1,400);
    m2=m2-m4;
    maks=m2;
    
    m3=zeros(240,320,3);
    m3(:,:,1)=m2;
    m3=double(m3);
    c=imfuse(image2,m3,'blend');
    figure; imshow(c)
    
%     figure; imshow(mask);
%     figure; imshow(m2);


end

