function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% load('../data/sylvextbases.mat');

it = im2double(It);
it1= im2double(It1);
basenum = size(bases,3);
width = size(bases,2);
height = size(bases,1);

[cinterp,rinterp]=meshgrid(rect(1):rect(3),rect(2):rect(4));
[corig,rorig]=meshgrid(1:size(it,2),1:size(it,1));
T = interp2(corig,rorig,it,cinterp,rinterp);
T = imresize(T,[height width]);

p = [0; 0];
[gradItX, gradItY] = imgradientxy(T);
j = eye(2);

sdx = gradItX - sum(repmat(sum(sum(bases.*repmat(gradItX,[1 1 basenum]))),[height width 1]).*bases,3);
sdy = gradItY - sum(repmat(sum(sum(bases.*repmat(gradItY,[1 1 basenum]))),[height width 1]).*bases,3);


H = [sum(sum(sdx.*sdx)) sum(sum(sdx.*sdy)); sum(sum(sdy.*sdx)) sum(sum(sdy.*sdy))];


for i=1:1000
%     rect1= [rect(1)+p(1) rect(2)+p(2) rect(3)+p(1) rect(4)+p(2)];
%     [cinterp1,rinterp1]=meshgrid(rect1(1):rect1(3),rect1(2):rect1(4));
    cinterp1=cinterp+p(1);
    rinterp1=rinterp+p(2);
%     [corig1,rorig1]=meshgrid(1:size(it1,2),1:size(it1,1));
    T1 = interp2(corig,rorig,it1,cinterp1,rinterp1); 
    T1 = imresize(T1,size(T));
%     diff = it1(rect1(2):rect1(4),rect1(1):rect1(3))-T;
    diff = T1-T;
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

end

