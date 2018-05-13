function ocr


	first_page=figure('name','Photo OCR','numbertitle','off',...
		'color','black');

	select_img_panel=uipanel(first_page,'title','Image', "position",...
	 [.25 .25 .5 .15],'backgroundcolor','white');

	slectedImgEdit=uicontrol(select_img_panel,'style','edit',...
		"position",[0 5 110 30],...
		'horizontalalignment','left','string','Image path here');

	selectImgBtn=uicontrol(select_img_panel,'style','pushbutton',...
		'string','Choose path','position',[120 5 100 30],...
		'backgroundcolor','cyan','callback',{@chooseImg,slectedImgEdit});



end;