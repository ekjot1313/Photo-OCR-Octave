function trainNN

%trainNN function trains the Neural Network to obtain weights for hidden layer
%and output layer and save them into 'weights.mat' file as theta1 and theta2

input_layer_size=400;
hidden_layer_size=100;
num_labels=62;
MaxIter=100;
lambda=0;



load('train_test_Data.mat'); %loading training cases

X=X_trn;
y=y_trn;

%random initialization of weights/parameters/thetas
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

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
pause;

save('thetas.mat','Theta1','Theta2');
%predAfterTraining = predict(Theta1, Theta2, X);

%testNN;
end