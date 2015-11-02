function [u, v] = LucasKanade(It, It1, rect)

it = im2double(It);
it1= im2double(It1);
% gradient It
% rect=round(rect);
% T = it(rect(2):rect(4),rect(1):rect(3));
[cinterp,rinterp]=meshgrid(rect(1):rect(3),rect(2):rect(4));
[corig,rorig]=meshgrid(1:size(it,2),1:size(it,1));
T = interp2(corig,rorig,it,cinterp,rinterp);

p = [0; 0];
[gradItX, gradItY] = imgradientxy(T);
% figure; imshowpair(gradItX, gradItY, 'montage'); axis off;
j = eye(2);
% steepDecent = 
H = [sum(sum(gradItX.*gradItX)) sum(sum(gradItX.*gradItY)); sum(sum(gradItY.*gradItX)) sum(sum(gradItY.*gradItY))];

for i=1:1000
%     rect1= [rect(1)+p(1) rect(2)+p(2) rect(3)+p(1) rect(4)+p(2)];
%     [cinterp1,rinterp1]=meshgrid(rect1(1):rect1(3),rect1(2):rect1(4));
    cinterp1=cinterp+p(1);
    rinterp1=rinterp+p(2);
    [corig1,rorig1]=meshgrid(1:size(it1,2),1:size(it1,1));
    T1 = interp2(corig1,rorig1,it1,cinterp1,rinterp1);    
%     diff = it1(rect1(2):rect1(4),rect1(1):rect1(3))-T;
%     size(T1);
%     size(T);
    diff = T1-T;
    diff(isnan(diff))=0;    
    sumdiff = [sum(sum(gradItX.*diff)) sum(sum(gradItY.*diff))] ;
    deltaP = H\sumdiff';
%     p=p+pinv(deltaP)';
    p=p-(deltaP);
    if (abs(deltaP) < 1e-5)
        break;
    end    
end

u=p(1);
v=p(2);

% figure; 
% imshow(it);
% rectangle('position',[rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],'edgecolor','y');
% figure;
% imshow(it1);
% rectangle('position',[rect1(1) rect1(2) rect1(3)-rect1(1) rect1(4)-rect1(2)],'edgecolor','y');

end

