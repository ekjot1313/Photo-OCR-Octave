
i=imread('E:\Photo OCR\Project\Code\Sample Images\abcd.jpg'); % reads given image in rgb form
save sample5.txt i;
gi=rgb2gray(i); % convert rgb image into grayscale

 

%preprocessing image before recognition
I=imagePreprocessing(gi);
