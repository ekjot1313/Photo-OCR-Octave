function chooseImg(source,event,slectedImgEdit)
% this function helps to select image


[imgname, imgpath]=uigetfile ({"*.jpeg;*.png;*.jpg",...
                             "Supported Picture Formats"},'Select Image');
% open a file chooser and return image path and image name

absimgpath=strcat(imgpath,imgname);
% absolute image path

set(slectedImgEdit,'string',absimgpath);
% update slectedImgEdit with the absolute image path

i=imread(absimgpath);
% reads given image in rgb form

end;