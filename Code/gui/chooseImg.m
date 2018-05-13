function chooseImg(source,event,selectedImgEdit,imgPanel,recogniseBtn)
% this function helps to select image

absimgpath=get(selectedImgEdit,'string');

if isempty(absimgpath)||strcmp(absimgpath,'Image path here')

% open a file chooser and return image path and image name
[imgname, imgpath]=uigetfile ({"*.jpeg;*.png;*.jpg",...
                             "Supported Picture Formats"},'Select Image');


absimgpath=strcat(imgpath,imgname);


% update slectedImgEdit with the absolute image path
set(selectedImgEdit,'string',absimgpath);

end;
	
% reads given image in rgb form
i=imread(absimgpath);


%clear last image
cla('reset');

imshow(i);

set(recogniseBtn,'visible','on');

end;