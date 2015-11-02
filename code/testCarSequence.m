% load('../data/sylvseq.mat');
load('../data/carseq.mat');
% load('../data/sylvextseq.mat');
% rect=[102,62,156,108];
rect=[60 117 146 152];
% rect=[122, 59, 169, 104];
rects = rect;

figure;
hold on
imshow(frames(:,:,1));
rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
       
for i=2:size(frames,3)
    It = frames(:,:,i-1);
    It1 = frames(:,:,i);
    if ( i==100 || i==200 || i==300 || i==400)
%     if ( i==400 || i==800 || i==1200 || i==1300)    
        figure;
        hold on
        imshow(It);
        rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
    end    
    [u,v]= LucasKanade(It, It1, rect);
    rect = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    rects = [rects; rect];
end
% save('carseqrects.mat','rects');