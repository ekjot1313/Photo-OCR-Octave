function J_tst=testNN(input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, lambda)


load('test_Data.mat'); %loading test cases



load('thetas.mat'); %loading thetas

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

[J_tst grad]=nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X_tst, y_tst, lambda);



p = predict(Theta1, Theta2, X_tst);
fprintf('Test Case Result........');
correct=sum(p==y_tst)
total=size(y_tst,1)

accuracy=correct*100/total

end