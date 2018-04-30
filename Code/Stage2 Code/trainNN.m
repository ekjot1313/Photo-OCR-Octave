function [J_trn,Theta1,Theta2]=trainNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels,X_trn,y_trn, lambda,MaxIter,Theta1,Theta2)

%trainNN function trains the Neural Network to obtain weights for hidden layer
%and output layer and save them into 'weights.mat' file as theta1 and theta2

%input_layer_size=400;
%hidden_layer_size=100;
%num_labels=62;
%MaxIter=50;
%lambda=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load('train_Data.mat'); %loading training cases


%X=X_trn;
%y=y_trn;


%numOfTrainCases=size(y_trn,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dec train case and randomize
%randInd=randperm(numOfTrainCases)(randperm(floor(numOfTrainCases/10)));
%X_trn=X_trn(randInd,:);
%y_trn=y_trn(randInd);
%numOfTrainCases=size(y_trn,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%for m=1:floor(1*numOfTrainCases):numOfTrainCases
X=X_trn;
y=y_trn;

%load('thetas.mat'); %loading old thetas

%random initialization of weights/parameters/thetas
%Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
%Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', MaxIter);


% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
%pause;

	J_trn =nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda);

%endfor


%save('thetas.mat','Theta1','Theta2');%saving new thetas

end