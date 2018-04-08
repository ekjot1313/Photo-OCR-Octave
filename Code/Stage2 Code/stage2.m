function stage2
	%clear ; close all; clc;
	%i=imread('E:\Photo OCR\Project\Code\Sample Images\sample5.png');
	

%% Setup the parameters we will use for this neural network
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 100;   % 100 hidden units
num_labels = 10+26+26;          % 62 labels, from 0 to 9, A to Z, a to z 


%Theta1 and Theta2 will store the weights
%Theta1; % 100x401 weights, 1 for bias neuron
%Theta2; % 62x101 weights, 1 for bias neuron
%load('ex3data1.mat');



%load('train_test_Data.mat'); %loading training cases


%trainNN(input_layer_size,hidden_layer_size,num_labels,X_trn,y_trn,0,100);

load('thetas.mat'); %loading thetas


	i=imread('a.png');

	if(size(i,3)==3) %if image is rgb, convert to gray
		i=rgb2gray(i);
	endif

	i=imageto20X20gray(i);
imshow(i);
	X=i(:)';
X=2*mat2gray(X)-1; %to get gray pixel intensity in range -1 to 1
                   %where -1 is black and 1 is white

p = predict(Theta1, Theta2, X)


if(p<10)
	p-1
elseif (p<37)
	char(p-10+64)
else
	char(p-36+96)
		
		
endif



end