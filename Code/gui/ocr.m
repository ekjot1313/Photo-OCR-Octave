function ocr

% adding a figure
	first_page=figure('name','Photo OCR',...
						'numbertitle','off',...
						'color','black');

% adding a panel for getting image from user
	select_img_panel=uipanel(first_page,...
							'title','Image',...
							'units','normalized',...
							 "position",[.15 .75 .75 .15],...
							 'backgroundcolor','white');

% adding edit control to show the image path
	slectedImgEdit=uicontrol(select_img_panel,...
							'string','Image path here',...
							'style','edit',...
							'units','normalized',...
							"position",[0 .1 .6 .50],...
							'horizontalalignment','left');

% adding button control to choose image
	selectImgBtn=uicontrol(select_img_panel,...
							'style','pushbutton',...
							'string','Choose Image',...
							'units','normalized',...
							'position',[.65 .1 .3 .5],...
							'backgroundcolor','cyan',...
							'callback',{@chooseImg,slectedImgEdit});



end;