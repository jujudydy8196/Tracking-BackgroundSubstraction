load('../data/carseq.mat');
rect=[60 117 146 152];

rects = rect;
I1=frames(:,:,1);
I1 = im2double(I1);
[cinterp,rinterp]=meshgrid(rect(1):rect(3),rect(2):rect(4));
[x,y]=meshgrid(1:size(I1,2),1:size(I1,1));
r1 = interp2(x,y,I1,cinterp,rinterp);

figure;
hold on
imshow(I1);
rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
It=I1;
for i=2:size(frames,3)
    It1 = frames(:,:,i);
    It1 = im2double(It1);
    if ( i==100 || i==200 || i==300 || i==400)
%     if ( i==400 || i==800 || i==1200 || i==1300)    
        figure;
        hold on
        imshow(It);
        rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
    end
    
    [u,v]= LucasKanade(It, It1, rect);
%     rect1 = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
%     I1_1=I1(v:end,u:end);
%     [u1,v1]=LucasKanade(I1, It1, rects(1,:));
% norm([u1-u v1-v])
    rect=[rect(1)+u rect(2)+v rect(3)+u rect(4)+v];

%     norm(rt1-r1)    
%     if (norm(rt1-r1)<=1)
%         rect= [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
%     end
    rects = [rects; rect];   
    It = frames(:,:,i);
%     [cinterp1,rinterp1]=meshgrid(rect(1):rect(3),rect(2):rect(4));
%     [x,y]=meshgrid(1:size(I1,2),1:size(I1,1));
%     rt1 = interp2(x,y,It,cinterp1,rinterp1);
%     rt1 = imresize(rt1,size(r1));     
    It(round(rect(2)):round(rect(2))+size(r1,1)-1,round(rect(1)):round(rect(1))+size(r1,2)-1)=r1;
end
save('carseqrects-wcrt.mat','rects');