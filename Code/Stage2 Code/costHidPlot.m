lambda=0;
traindata=[];
validdata=[];

input_layer_size=400;

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


hidden_layer_size=100;

while hidden_layer_size<=150

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
traindata=[traindata;[hidden_layer_size,J_trn]];
validdata=[validdata;[hidden_layer_size,J_val]];

hidden_layer_size=hidden_layer_size+5;



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
title('Cost-Hidden Layer Size plot');
xlabel('Hidden Layer Size');
ylabel('Cost');

save('Cost-Hid plot.mat','traindata','validdata');
saveas(gcf,'cost-hid plot.jpg');


[costdiff ind]=min(abs(validdata(:,2)-traindata(:,2)));
goodHid=validdata(ind,1)