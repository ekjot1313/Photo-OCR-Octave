%i=1;
%j=1000;
%lambda=i/j;
lambda=0.06;
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=160;
num_labels=62;
MaxIter=50 ;
trainsetPercentage=50;
validsetPercentage=50;



%load('train_Data.mat'); %loading training cases
load('new_train_Data.mat'); %loading training cases

numOfTrainCases=size(y_trn,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
%randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
randInd=1:floor(numOfTrainCases*(trainsetPercentage/100));
X_trn=X_trn(randInd,:);
y_trn=y_trn(randInd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%load('valid_Data.mat'); %loading test cases
load('new_valid_Data.mat'); %loading test cases
numOfValidCases=size(y_val,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
%randInd2=randperm(numOfValidCases)(randperm(floor(numOfValidCases*(validsetPercentage/100))));
randInd2=1:floor(numOfValidCases*(validsetPercentage/100));
X_val=X_val(randInd2,:);
y_val=y_val(randInd2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%load('thetas.mat'); 

%T1 = Theta1;
%T2 = Theta2;
T1 = randInitializeWeights(input_layer_size, hidden_layer_size);
T2 = randInitializeWeights(hidden_layer_size, num_labels);

numOfTrainCases=size(y_trn,1)
numOfValidCases=size(y_val,1)

while lambda<=0.15

	[J_trn,t1,t2] =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn,y_trn, lambda,MaxIter,T1,T2);
%load('thetas.mat'); %loading new thetas

nn_params = [t1(:) ; t2(:)];%unrolling thetas into neural network parameters

	J_val =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_val, y_val, lambda)
traindata=[traindata;[lambda,J_trn]];
validdata=[validdata;[lambda,J_val]];


%lambda=i/j;
	%if i==9
	%	j=j/10;
	%end;
	%i=rem(i,9)+1;

if lambda==0
	lambda=0.01;
else
lambda=lambda+0.02;
end;




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
title('Cost-Lambda plot');
xlabel('Lambda');
ylabel('Cost');

save('Cost-Lambda plot.mat','traindata','validdata');
saveas(gcf,'cost-lambda plot.jpg');


[costdiff ind]=min(abs(validdata(:,2)-traindata(:,2)));
goodLambda=validdata(ind,1)