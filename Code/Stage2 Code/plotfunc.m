

load('Cost-Lambda plot.mat');

traindata
X=traindata(:,1);
Y=traindata(:,2);


plot(X,Y);

hold on;
validdata
X=validdata(:,1);
Y=validdata(:,2);

plot(X,Y);