function overlapRatio=bboxOverlapRatio(boxAVect,boxBVect)


A=size(boxAVect,1);
B=size(boxBVect,1);
overlapRatio=zeros(A,B);

for i=1:A
	boxA=boxAVect(i,:);
	for j=1:B
		boxB=boxBVect(j,:);



a1=boxA(1);
b1=boxA(2);
x1=boxA(3);
y1=boxA(4);

a2=boxB(1);
b2=boxB(2);
x2=boxB(3);
y2=boxB(4);



x=max(0,min(a1+x1,a2+x2)-max(a1,a2));
y=max(0,min(b1+y1,b2+y2)-max(b1,b2));


overlapArea=x*y;
AreaA=x1*y1;
AreaB=x2*y2;

overlapRatio(i,j)=overlapArea/(AreaA+AreaB-overlapArea);
end
end

end