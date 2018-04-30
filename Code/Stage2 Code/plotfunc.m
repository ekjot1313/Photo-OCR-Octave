
while l<=1

	
	
end;
ffffffffffffff











load('Cost-Hid plot.mat');


X=traindata(:,1);
Y=traindata(:,2);

X=[X;500];
Y=[Y;0];
plot(X,Y);

hold on;

X=validdata(:,1);
Y=validdata(:,2);

plot(X,Y);

hold on;

load('Cost-Hid plot2.mat');


X=traindata(:,1);
Y=traindata(:,2);

plot(X,Y);

hold on;

X=validdata(:,1);
Y=validdata(:,2);

plot(X,Y);