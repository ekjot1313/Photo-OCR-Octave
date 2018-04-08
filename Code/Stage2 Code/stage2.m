function stage2
	%clear ; close all; clc;
	%i=imread('E:\Photo OCR\Project\Code\Sample Images\sample5.png');
	i=imread('a.jpg');
	i=rgb2gray(i);
	i=imageto20X20gray(i);

	X=i(:)';
y=[10];% y is let to be 10


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

%load('weights.mat'); %loading pre-calculated thetas


%trainNN(input_layer_size,hidden_layer_size,num_labels,X,y,0,50);



end