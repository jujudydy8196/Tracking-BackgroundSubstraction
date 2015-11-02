function M = LucasKanadeAffine(It, It1)
it = im2double(It);
it1= im2double(It1);
T=it;
[x,y]=meshgrid(1:size(it,2),1:size(it,1));

p=[0; 0; 0; 0; 0; 0];
% w=[1+p(1) p(2) p(3); p(4) 1+p(5) p(6); 0 0 1];
w=[1+p(1) p(3) p(5); p(2) 1+p(4) p(6); 0 0 1];

[gradItX, gradItY] = imgradientxy(it);

jx = [x(:) zeros(size(x(:))) y(:) zeros(size(x(:))) ones(size(x(:))) zeros(size(x(:)))];
jy = [zeros(size(x(:))) x(:) zeros(size(x(:))) y(:) zeros(size(x(:))) ones(size(x(:)))];


SD=zeros(length(x(:)),6);
for i=1:size(x(:))
    J=[jx(i,:); jy(i,:)];
%     [yy,xx]=ind2sub(size(it),i);
    G=[gradItX(i) gradItY(i)];
    SD(i,1:6)=G*J;
end
sdt=SD';
H=zeros(6,6);
for i=1:size(x(:))
    H=H+SD(i,:)'*SD(i,:);
end

% H = [sum(sum(gradItX.*gradItX)) sum(sum(gradItX.*gradItY)) 0; sum(sum(gradItY.*gradItX)) sum(sum(gradItY.*gradItY)) 0; 0 0 0];

for i=1:100
%     cinterp1=cinterp+p(3);
%     rinterp1=rinterp+p(6);
%     T1 = interp2(corig1,rorig1,it1,cinterp1,rinterp1);
    
    idx = [x(:)' ; y(:)'; ones(1,size(x(:),1)) ];
    T1idx=zeros(3,size(idx,2));
    for j=1:size(idx,2)
        T1idx(:,j)=w*idx(:,j);
    end
    T1idx(1,(T1idx(1,:)<0))=1;
    T1idx(2,(T1idx(2,:)<0))=1;
    T1idx(1,(T1idx(1,:)>size(it1,2)))=1;%size(it1,2);
    T1idx(2,(T1idx(2,:)>size(it1,1)))=1;%size(it1,1);
    T1idx=T1idx(1:2,:);
    [cinterp,rinterp]=meshgrid(min(T1idx(1,:)):max(T1idx(1,:)),min(T1idx(2,:)):max(T1idx(2,:)));
    T1=interp2(x,y,it,cinterp,rinterp);
%     for j=1:size(idx,2)
%         T1(j)=interp2(x,y,it1,T1idx(2,j),T1idx(1,j));
%     end
    T1=imresize(T1,size(it1));
    diff = it1-T1;%T1-T;
    sumdiff=zeros(1,6);
    for j=1:6
        sumdiff(j)=nansum(sdt(j,:).*diff(:)');
    end
%     sumdiff = [sum(sum(gradItX.*diff)) sum(sum(gradItY.*diff)) 0] ;
    deltaP = H\sumdiff';
%     norm(deltaP);
%     p=p+pinv(deltaP)';
%     p
%     deltaP;
    
    p=p-0.5*(deltaP);
    w=[1+p(1) p(3) p(5); p(2) 1+p(4) p(6); 0 0 1];
%     w=[1+p(1) p(2) p(3); p(4) 1+p(5) p(6); 0 0 1];
    if (norm(deltaP) < 1e-5)
        break;
    end    
end
% M=[1+p(1) p(2) p(3); p(4) 1+p(5) p(6); 0 0 1];
M=[1+p(1) p(3) p(5); p(2) 1+p(4) p(6); 0 0 1];
end

