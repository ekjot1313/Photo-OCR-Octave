function stage2
	%clear ; close all; clc;
	%i=imread('E:\Photo OCR\Project\Code\Sample Images\sample5.png');
	i=imread('a.jpg');
	i=rgb2gray(i);
	i=imageto20X20gray(i);

	X=i(:)';
y=zeros(26,1);
y(10,1)=1;


%% Setup the parameters we will use for this neural network
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 50;   % 50 hidden units
num_labels = 26;          % 26 labels, from A to Z


%Theta1 and Theta2 will store the weights
%Theta1; % 50x401 weights, 1 for bias neuron
%Theta2; % 26x51 weights, 1 for bias neuron
%load('ex3data1.mat');

X=2*mat2gray(X)-1; %to get gray pixel intensity in range -1 to 1
                   %where -1 is black and 1 is white

%load('ex3weights.mat'); %loading pre-calculated thetas

%random initialization of weights/parameters/thetas
Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

nn_params = [Theta1(:) ; Theta2(:)];%unrolling thetas into neural network parameters

% Weight regularization parameter (we set this to 0 here).
lambda = 0;


pred = predict(Theta1, Theta2, X)%predicting the images

[J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda)



%%%%%%%%%%%%%%%%%%%%%%%%%%%done upto cost. now implement back propagation


 

end