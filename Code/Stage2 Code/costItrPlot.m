lambda=4.5;
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=110;
num_labels=62;
MaxIter=10;
trainsetPercentage=10;




load('train_Data.mat'); %loading training cases
load('valid_Data.mat'); %loading test cases

numOfTrainCases=size(y_trn,1);
randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
X_trn_new=X_trn(randInd,:);
y_trn_new=y_trn(randInd);
m=size(y_trn_new,1);



while MaxIter<=100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%








	J_trn =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn_new,y_trn_new, lambda,MaxIter);
load('thetas.mat'); %loading new thetas

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

figure;
title(num2str(MaxIter));
subplot(1,2,1);
imagesc(Theta1);
subplot(1,2,2);
imagesc(Theta2);

	J_val =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_val, y_val, lambda);
traindata=[traindata;[MaxIter,J_trn]];
validdata=[validdata;[MaxIter,J_val]];


MaxIter=MaxIter+10;


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
title('Cost-Iteration plot');
xlabel('Iterations');
ylabel('Cost');

save('Cost-Itr plot.mat','traindata','validdata');
saveas(gcf,'cost-itr plot.jpg');


[costdiff ind]=min(abs(validdata(:,2)-traindata(:,2)));
goodM=validdata(ind,1)