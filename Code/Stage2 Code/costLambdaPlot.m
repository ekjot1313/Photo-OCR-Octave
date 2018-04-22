lambda=0;
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=110;
num_labels=62;
MaxIter=100;
trainsetPercentage=25;




load('train_Data.mat'); %loading training cases

numOfTrainCases=size(y_trn,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
X_trn=X_trn(randInd,:);
y_trn=y_trn(randInd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('valid_Data.mat'); %loading test cases



while lambda<=1000

	J_trn =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn,y_trn, lambda,MaxIter);
load('thetas.mat'); %loading new thetas

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

	J_val =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_val, y_val, lambda);
traindata=[traindata;[lambda,J_trn]];
validdata=[validdata;[lambda,J_val]];

if lambda==0
	lambda=1;
else
lambda=lambda+100;
endif

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