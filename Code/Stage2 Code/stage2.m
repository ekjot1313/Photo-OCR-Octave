function alphanum=stage2(i,Theta1, Theta2)
	%clear ; close all; clc;
	%i=imread('E:\Photo OCR\Project\Code\Stage2 Code\1.png'); % reads given image in rgb form



	if(size(i,3)==3) %if image is rgb, convert to gray
		i=rgb2gray(i);
	endif

	i=imageto20X20gray(i);

	%i=edge(i,'canny');
%	figure;
%imshow(i);
	X=i(:)';
X=2*mat2gray(X)-1; %to get gray pixel intensity in range -1 to 1
                   %where -1 is black and 1 is white




p = predict(Theta1, Theta2, X);


if(p<=10)
	%alphanum=num2str(p-1);
	alphanum=char(p-1+48);
elseif (p<37)
	alphanum=char(p-10+64);
else
	alphanum=char(p-36+96);
endif




end