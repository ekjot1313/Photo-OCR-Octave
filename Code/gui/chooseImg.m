function chooseImg(source,event,slectedImgEdit,imgPanel)
% this function helps to select image


% open a file chooser and return image path and image name
[imgname, imgpath]=uigetfile ({"*.jpeg;*.png;*.jpg",...
                             "Supported Picture Formats"},'Select Image');

% absolute image path
absimgpath=strcat(imgpath,imgname);

% update slectedImgEdit with the absolute image path
set(slectedImgEdit,'string',absimgpath);

% reads given image in rgb form
i=imread(absimgpath);


pos=get(imgPanel,'position');

iresize=i;%imresize(i,pos);


set(imgPanel,'userdata',iresize);



end;