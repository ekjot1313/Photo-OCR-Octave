lambda=0;
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=100;
num_labels=62;
MaxIter=50;
trainsetPercentage=10;




load('train_Data.mat'); %loading training cases
load('valid_Data.mat'); %loading test cases

numOfTrainCases=size(y_trn,1);

while trainsetPercentage<=100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
X_trn_new=X_trn(randInd,:);
y_trn_new=y_trn(randInd);
m=size(y_trn_new,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








	J_trn =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn_new,y_trn_new, lambda,MaxIter);
load('thetas.mat'); %loading new thetas

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

	J_val =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_val, y_val, lambda);
traindata=[traindata;[m,J_trn]];
validdata=[validdata;[m,J_val]];


trainsetPercentage=trainsetPercentage+10;


endwhile

traindata

X=traindata(:,1);
Y=traindata(:,2);

plot(X,Y);

hold on;
validdata
X=validdata(:,1);
Y=validdata(:,2);

plot(X,Y);
title('Cost-Training Examples plot');
xlabel('Training Examples');
ylabel('Cost');

save('Cost-TrainEx plot.mat','traindata','validdata');
saveas(gcf,'cost-trainex plot.jpg');


[costdiff ind]=min(abs(validdata(:,2)-traindata(:,2)));
goodM=validdata(ind,1)