function bbox=swtConnComp(I)

Rows=size(I,1);
Cols=size(I,2);
newI=zeros(Rows,Cols);





for  row=1:Rows
	for col=1:Cols


		
		if (I(row,col)>0)

			pixswt=I(row,col);
			% check pixels in all directions
			
			if (col+1 < Cols)
				%right-up, right, right-down

				if(row-1>=1)
					right_up = I(row-1, col+1);
					if (right_up > 0 && (pixswt/right_up <= 3.0 || right_up/pixswt <= 3.0))
						newI(row,col)=1;
						continue;
					endif
				endif

				right = I(row, col+1);
				if (right > 0 && (pixswt/right <= 3.0 || right/pixswt <= 3.0))
					newI(row,col)=1;
					continue;
				endif

				if(row+1<=Rows)
					right_down = I(row+1, col+1);
					if (right_down > 0 && (pixswt/right_down <= 3.0 || right_down/pixswt <= 3.0))
						newI(row,col)=1;
						continue;
					endif
				endif

			endif


			if (col-1 >= 1)
				%left_up, left, left_down

				if(row-1>=1)
					left_up = I(row-1, col-1);
					if (left_up > 0 && (pixswt/left_up <= 3.0 || left_up/pixswt <= 3.0))
						newI(row,col)=1;
						continue;
					endif
				endif

				left = I(row, col-1);
				if (left > 0 && (pixswt/left <= 3.0 || left/pixswt <= 3.0))
					newI(row,col)=1;
					continue;
				endif

				if(row+1<=Rows)
					left_down = I(row+1, col-1);
					if (left_down > 0 && (pixswt/left_down <= 3.0 || left_down/pixswt <= 3.0))
						newI(row,col)=1;
						continue;
					endif
				endif

			endif


			if(row-1>=1)%up
				up = I(row-1, col);
				if (up > 0 && (pixswt/up <= 3.0 || up/pixswt <= 3.0))
					newI(row,col)=1;
					continue;
				endif
			endif

			if(row+1<=Rows)%down
				down = I(row+1, col);
				if (down > 0 && (pixswt/down <= 3.0 || down/pixswt <= 3.0))
					newI(row,col)=1;
					continue;
				endif
			endif


		endif

	endfor

endfor

newI=newI.*I;

%figure;
%imagesc(newI);
%title('SWT image after 3 removal');

cc=bwconncomp(newI);
numComp=cc.NumObjects;

I=newI;



% OTHER FILTERS>>>>>>>>>>>>>


%point struct to store a point having 'x','y' and 'SWT value'
Point=struct('x',-1,'y',-1,'swt',inf);

PointPair=struct('p',Point,'q',Point);

components=cc.PixelIdxList;
compCenters=Point;
compDimensions=Point;
compBB=PointPair;
compMedians=[];

validComponents={};

tempComp={};
tempBB=PointPair;
tempCenters=Point;
tempMed=[];
tempDim=Point;


for curComp=1:numComp

    componentMat=cell2mat(components(curComp));
    [mean, variance, median, minx, miny, maxx, maxy]=componentStats(I,componentMat);


    % check if variance is less than half the mean
    if (variance > 0.5 * mean) 
        continue;
    endif

    length = (maxx-minx+1);
    width = (maxy-miny+1);


    % check font height
    if (width > 300) 
        continue;
    endif


    area = length * width;
    rminx = minx;
    rmaxx = maxx;
    rminy = miny;
    rmaxy = maxy;


    % compute the rotated bounding box
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % check if the aspect ratio is between 1/10 and 10
    if ((length/width) < 0.1 || (length/width) > 10)
        continue;
    endif


    % compute the diameter

    % compute dense representation of component
%removed code of DenseRepr


    center=Point;
    center.x = ((maxx+minx))/2.0;
    center.y = ((maxy+miny))/2.0;

    dimensions=Point;
    dimensions.x = maxx - minx + 1;
    dimensions.y = maxy - miny + 1;

    bb1=Point;
    bb1.x = minx;
    bb1.y = miny;

    bb2=Point;
    bb2.x = maxx;
    bb2.y = maxy;

    pair=PointPair;
    pair.p=bb1;
    pair.q=bb2;

    compBB(curComp)=(pair);
    compDimensions(curComp)=(dimensions);
    compMedians(curComp)=(median);
    compCenters(curComp)=(center);
    validComponents(curComp,:)=componentMat;
                

endfor

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









bbox=zeros(size(compBB,2),4);

for i=1:size(compBB,2)
    if size(compBB(i).p)>0 %if component is non empty
        x1=compBB(i).p.x;
        x2=compBB(i).q.x;
        y1=compBB(i).p.y;
        y2=compBB(i).q.y;
        xlen=x2-x1;
        ylen=y2-y1;
        bbox(i,:)=[y1-0.5 x1-0.5 y2 x2];
    endif

endfor


%printboxes(bbox,I);

end
