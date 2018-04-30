lambda=0.32;
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=100;
num_labels=26;
MaxIter=100;
trainsetPercentage=1;




load('train_Data.mat'); %loading training cases
load('valid_Data.mat'); %loading validation cases
load('test_Data.mat');

X_trn=[X_trn;X_tst];
y_trn=[y_trn;y_tst];

numOfTrainCases=size(y_trn,1);

%load('thetas.mat'); %loading new thetas

%T1 = Theta1;
%T2 = Theta2;
T1 = randInitializeWeights(input_layer_size, hidden_layer_size);
T2 = randInitializeWeights(hidden_layer_size, num_labels);

while trainsetPercentage<=100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
X_trn_new=X_trn(randInd,:);
y_trn_new=y_trn(randInd);
m=size(y_trn_new,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	[J_trn,t1,t2] =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn_new,y_trn_new, lambda,MaxIter,T1,T2);
%load('thetas.mat'); %loading new thetas

nn_params = [t1(:) ; t2(:)];%unrolling thetas into neural network parameters

	J_val =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_val, y_val, lambda)
traindata=[traindata;[m,J_trn]];
validdata=[validdata;[m,J_val]];

if trainsetPercentage==1
	trainsetPercentage=10;
	continue;
end;
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