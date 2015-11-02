load('../data/aerialseq.mat');
i1 = frames(:,:,1);
i2 = frames(:,:,2);
[diff1 mask1] = SubtractDominantMotion_t(i1, i2);
i29 = frames(:,:,29);
i30 = frames(:,:,30);
[diff2 mask2] = SubtractDominantMotion_t(i29, i30);
    mask=im2bw(diff,0.2);

    se = strel('disk',1);    
    m1=imdilate(mask,se);
    m1=bwfill(m1,'holes');
    m2=bwareaopen(m1,100);
    m4=bwareaopen(m1,400);
    m2=m2-m4;
i59 = frames(:,:,59);
i60 = frames(:,:,60);
[diff3 mask3] = SubtractDominantMotion_t(i59, i60);
mask3=im2bw(diff3,0.1);
se = strel('disk',2);
m1=imdilate(mask,se);
m1=bwfill(m1,'holes');
m2=bwareaopen(m1,200);

m3=zeros(240,320,3);
m3(:,:,1)=m2;
m3=double(m3);
c=imfuse(image2,m3,'blend');
figure; imshow(c)


i89 = frames(:,:,89);
i90 = frames(:,:,90);
[diff4 mask4] = SubtractDominantMotion_t(i89, i90);

i119 = frames(:,:,119);
i120 = frames(:,:,120);
[diff5 mask5] = SubtractDominantMotion_t(i119, i120);


for i=[2 30 60 90 120] %2:size(frames,3)
    It = frames(:,:,i-1);
    It1 = frames(:,:,i);
    mask = SubtractDominantMotion(It, It1);
%     if (i==30 || i==60 || i==90 || i==120)
%         se = strel('disk',2);
%         m1=imdilate(mask,se);
%         m2=bwareaopen(m1,200);
%         m3=zeros(240,320,3);
%         m3(:,:,1)=m2;
%         m3=double(m3);
%         c=imfuse(image2,m3,'blend');
%         figure; imshow(c)
%     end
end
    