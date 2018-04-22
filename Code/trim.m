function I=trim(I)
	

	GI=I;
	if size(I,3)==3
		GI=rgb2gray(I);
	end;

	EI=edge(GI,'canny');

	cc=bwconncomp(EI);
	mserStats=regionprops(cc,'BoundingBox');
	mserRegions=I;
	% Remove Non-Text Regions Based On Basic Geometric Properties
	%[mserRegions mserStats]=removeOnGeometry(mserRegions,mserStats,EI);
	bbox = vertcat(mserStats.BoundingBox);
	
	if size(bbox,1)>0

		bbox=bounds2dimensions(bbox);
		minx=min(bbox(:,1));
		miny=min(bbox(:,2));
		maxx=max(bbox(:,3));
		maxy=max(bbox(:,4));

		I=imcrop(I,dimensions2bounds([minx,miny,maxx,maxy]));
	end;

end;