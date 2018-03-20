I=imread('E:\Photo OCR\Project\Code\Sample Images\swtoutput.jpg'); % reads given image in rgb form

%I=rgb2gray(I);

%I=a=[1 0 0; 0 1 1; 0 0 0];


%I=[1 1 0 0 0;0 0 0 0 1;0 0 1 0 0 ;1 0 0 0 1 ;1 0 0 1 0];
[Rows Cols]=size(I);
%I=[1 1 0 0 0;0 0 0 0 1;0 0 1 0 0 ;1 0 0 0 1 ;1 0 0 1 0];
%I=[1 0 1; 0 1 0];

cc=bwconncomp(I);
numComp=cc.NumObjects;

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
    increment = 1/36;
    PI=22/7;


    for theta=increment*PI:increment*PI:PI/2

        xmin = inf;
        ymin = inf;
        xmax = 1;
        ymax = 1;


        for i = 1:size(componentMat)
            
            pixInd=componentMat(i);
            pixX=rem(pixInd,Rows);
            if(pixX==0)
                pixX=Rows;
            endif
            pixY=(pixInd-pixX)/Rows+1;


            xtemp = pixX * cos(theta) + pixY * -sin(theta);
            ytemp = pixX * sin(theta) + pixY * cos(theta);
            xmin = min(xtemp,xmin);
            xmax = max(xtemp,xmax);
            ymin = min(ytemp,ymin);
            ymax = max(ytemp,ymax);
        endfor


        ltemp = xmax - xmin + 1;
        wtemp = ymax - ymin + 1;
        if (ltemp*wtemp < area) 
            area = ltemp*wtemp;
            length = ltemp;
            width = wtemp;
        endif

    endfor

    % check if the aspect ratio is between 1/10 and 10
    if (length/width < 1./10. || length/width > 10.)
        continue;
    endif


    % compute the diameter

    % compute dense representation of component
    denseRepr={};

    for i = 1: maxx-minx+1

        tmp=zeros(size(maxy-miny+1,1));
        denseRepr(i)=tmp;
    endfor


    for i = 1:size(componentMat)

        pixInd=componentMat(i);
        pixX=rem(pixInd,Rows);
        if(pixX==0)
            pixX=Rows;
        endif
        pixY=(pixInd-pixX)/Rows+1;



        denseRepr(pixX - minx+1,pixY - miny+1) = 1;

    endfor


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




pushBack=1;

for curComp = 1:size(validComponents,1)
    count = 0;


    for j = 1:size(validComponents,1)
        if (curComp != j)
            if (compBB(curComp).p.x <= compCenters(j).x && compBB(curComp).q.x >= compCenters(j).x &&
                compBB(curComp).p.y <= compCenters(j).y && compBB(curComp).q.y >= compCenters(j).y)
            
                count++;
            endif
        endif

    endfor



    if (count < 2)
        tempComp(pushBack,:)=validComponents(curComp);
        tempCenters(pushBack)=compCenters(curComp);
        tempMed(pushBack)=compMedians(curComp);
        tempDim(pushBack)=compDimensions(curComp);
        tempBB(pushBack)=compBB(curComp);


        pushBack=pushBack+1;
    endif

endfor


validComponents = tempComp;
compDimensions = tempDim;
compMedians = tempMed;
compCenters = tempCenters;
compBB = tempBB;


bbox=zeros(size(compBB,2),4);

for i=1:size(compBB,2)
    x1=compBB(i).p.x;
    x2=compBB(i).q.x;
    y1=compBB(i).p.y;
    y2=compBB(i).q.y;
    xlen=x2-x1;
    ylen=y2-y1;

    bbox(i,:)=[y1 x1 y2 x2];
    
    endfor

bbox

printboxes(bbox,I);


size(compBB,2)


