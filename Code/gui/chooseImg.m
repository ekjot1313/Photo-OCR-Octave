function chooseImg(source,event,slectedImgEdit)

[imgname, imgpath]=uigetfile ({"*.jpeg;*.png;*.jpg", "Supported Picture Formats"},'Select Image');
%i=imread('E:\Photo OCR\Project\Code\Sample Images\abcd1.jpg'); % reads given image in rgb form
imgpath=strcat(imgpath,imgname);

set(slectedImgEdit,'string',imgpath);

i=imread(imgpath); % reads given image in rgb form
figure;
imshow(i);

addpath('..\');
%stage1(i);
end;