function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1); %number of images
num_labels = size(Theta2, 1); %number of labels

% You need to return the following variables correctly 
p = zeros(m, 1); %predicted labels of all images

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%

%Implementing Forward Propagation:-

X=[ones(m,1) X]; %adding bias units to all images
a2=sigmoid(X*Theta1'); %finding hidden layer activation values of all images

a2=[ones(m,1) a2]; %adding bias units to hidden layer activation values
a3=sigmoid(a2*Theta2'); %finding output layer activation values of all images

[m,prediction]=max(a3'); %finding index of the predicted label
%prediction=char(prediction+64); %converting index to ascii character; 64+1=A
p=prediction';


% =========================================================================


end
