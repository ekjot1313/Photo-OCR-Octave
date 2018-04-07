function I=imageto20X20gray(i)

	if size(i,1)>0% if image is not empty
		ri=imresize(i,[20 20]);
		gi=ri;

		if size(ri,3)==3% if image is rgb
			gi=rgb2gray(ri);
		endif

		I=gi;
	endif
end