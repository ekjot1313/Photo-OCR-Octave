lambda=3;%10-15
traindata=[];
validdata=[];

input_layer_size=400;
hidden_layer_size=110;
num_labels=62;
MaxIter=1000;
trainsetPercentage=100;

%1 5.3 5.3     22   0
%4.3 4.6 4.6   26    13
%4.6 4.7 4.7   23    25
%4.6 4.6 4.7   22    20
%3.6 4.6 4.7   30    5
%2.7 5  5      29   2
%3.2 4.7 4.7   32   4
%3 4.7 4.7     30    3
%3.5 4.7 4.7   32   4.5  25itr  100%
%3.1 4.4 4.4   42   4.5  100itr  100%
%2.3 5.2 5.1   57   4.5  200itr  100%
%4.8 4.8 4.8   7    100
%2.1 5.1 5.1   62   4.5  1000itr 100%
%1.8 5.2 5.1   59   3    1000itr 100%

load('train_Data.mat'); %loading training cases
load('valid_Data.mat'); %loading test cases



numOfTrainCases=size(y_trn,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
%randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases*(trainsetPercentage/100))));
%X_trn=X_trn(randInd,:);
%y_trn=y_trn(randInd);
m=size(y_trn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%random initialization of weights/parameters/thetas
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

%for i=1:10:m
	
	%if(i+10>m)
	%	break;
	%endif
%X_trn_new=X_trn(i:i+10,:);
%y_trn_new=y_trn(i:i+10,:);
X_trn_new=X_trn;
y_trn_new=y_trn;
	[J_trn Theta1 Theta2] =trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn_new,y_trn_new, lambda,MaxIter,Theta1,Theta2);
J_trn
%endfor

save('thetas.mat','Theta1','Theta2');%saving new thetas


J_val=validNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, lambda)


J_tst=testNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, lambda)

%stage1
%i

