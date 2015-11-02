load('../data/aerialseq.mat');
for i=[30 60 90 120] %2:size(frames,3)
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
    