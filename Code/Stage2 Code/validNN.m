function J_val=validNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, lambda)

%%%%%%%%%%%%%%%%%%%%%%%%%%
load('valid_Data.mat'); %loading test cases
X=X_val;
y=y_val;

fprintf('\nValidating data...\n');
%input_layer_size=400;
%hidden_layer_size=100;
%num_labels=62;
%lambda=0;

load('thetas.mat'); %loading thetas

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

[J_val grad]=nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda);



end
