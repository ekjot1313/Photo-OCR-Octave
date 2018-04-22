function charBoxArray=charSegment(wordBox,bbox)

bbox=bounds2dimensions(bbox);

wordBox=bounds2dimensions(wordBox);

orgbbox=bbox;





%here each wordBox is taken one by one and
%for its dimensions, each segmented character in bbox 
%is compared. If any segmented character of bbox lies in range 
%of that wordBox, it is added to that index of charBoxArray
charBoxArray={};
arrInd=1;
wboxNum=size(wordBox,1);
if(wboxNum>0)
	
	for wboxnum=1:wboxNum
		wordBounds=wordBox(wboxnum,:)';

		bbox=bbox(bbox(:,1)>=wordBounds(1),:);%removing all characters whose
		                                      %xmin is out of wordBox
		bbox=bbox(bbox(:,2)>=wordBounds(2),:);%removing all characters whose
		                                      %ymin is out of wordBox
		bbox=bbox(bbox(:,3)<=wordBounds(3),:);%removing all characters whose
		                                      %xmax is out of wordBox
		bbox=bbox(bbox(:,4)<=wordBounds(4),:);%removing all characters whose
		                                      %ymax is out of wordBox

		if(size(bbox,1)>0)
			charBoxArray(arrInd)=bbox;
			arrInd=arrInd+1;
			bbox=orgbbox;
		endif

		
	endfor
endif


end