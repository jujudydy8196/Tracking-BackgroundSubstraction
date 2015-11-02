load('../data/sylvseq.mat');
load('../data/sylvbases.mat');

rect=[102, 62, 156, 108];
rectB=[102, 62, 156, 108];

rects = rectB;

figure;
hold on
imshow(frames(:,:,1));
rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
rectangle('position',[rectB(1) rectB(2) rectB(3)-rectB(1) rectB(4)-rectB(2)],'edgecolor','r');

for i=2:size(frames,3)
    It = frames(:,:,i-1);
    It1 = frames(:,:,i);
    if ( i==200 || i==300 || i==350 || i==400)
%     if ( i==400 || i==800 || i==1200 || i==1300)    
        figure;
        hold on
        imshow(It);
        rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
        rectangle('position',[rectB(1) rectB(2) rectB(3)-rectB(1) rectB(4)-rectB(2)],'edgecolor','r');
    end    
    [u,v]= LucasKanade(It, It1, rect);
    [uB,vB]=LucasKanadeBasis(It, It1, rectB, bases);
    
    rect = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    rectB = [rect(1)+uB rect(2)+vB rect(3)+uB rect(4)+vB];
    rects = [rects; rectB];

end
save('sylvseqrects.mat','rects');
% save('sylvseqextrects.mat','rects');