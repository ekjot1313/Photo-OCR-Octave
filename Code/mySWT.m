
function [mserRegions mserStats]= mySWT(mserRegions,mserStats,GI)

	

strokeWidthThreshold=0;
	for j = 1:numel(mserStats)


gi=imcrop(GI,mserStats(j).BoundingBox);
%figure;
%imshow(gi);

%i=imread('E:\Photo OCR\Project\Code\Sample Images\demo.jpg');

%gi=rgb2gray(i);



%calculating Canny edge image
[ei t]=edge(gi,'canny');

%figure;
%imshow(ei);

 %cc = bwconncomp (ei);
%mserStats = regionprops(cc,'all');

%for j = 1:numel(mserStats)
  %  figure;imshow(mserStats(j).Image);
%endfor


eei=ei;
eig= uint8( ei);

%eei=zeros(11,7);
%eei(3:9,3:5)=1;


%calculating gradients of gi
[GY GX]=imgradientxy(gi);

%[eei t]=edge(eii,'canny');

%eei(4:8,4)=0;


%matlab's canny
%eei=zeros(11,7);
%eei(4:8,[2 6])=1;
%eei([3 9],3:5)=1;
%eei([2 10],4)=1;


prec=0.5;

%total rows and columns in gray image
[rows cols]=size(eei);
%rows=0;
%cols=0;

%point struct to store a point having 'x','y' and 'SWT value'
Point=struct('x',-1,'y',-1,'swt',inf);

%ray struct to store 'p-point','q-point' and 'point vector'
Ray=struct('p',Point,'q',Point,'pointVect',Point);



PI=22/7;
%



a=zeros(rows,cols);
b=zeros(rows,cols);
ci=ei.*0.01;
%treding through each pixel
K=1;




strokeWidthMetric=0;


for dark_on_light=0:1

	
eeei=ones(size(eei)).*inf;

rayPushBackVar=1;
rayVect=Ray;

for row=1:rows
    for col=1:cols

        if(eei(row,col)~=0)
p='pixel found';
            pushBackVar=1;

K=0;

            r=Ray;

            p=Point;
            p.x=row;
            p.y=col;

            r.p=p;

            points=Point;

            points(pushBackVar)=p;
            pushBackVar=pushBackVar+1;


            curX = row + 0.5;
            curY = col + 0.5;

            curPixX = row;
            curPixY = col;

ci(curPixX,curPixY)=5/(rows*cols);

            G_x = GX(row, col);
            G_y = GY(row, col);

            % normalize gradient
            mag = sqrt( (G_x * G_x) + (G_y * G_y) );
            if(mag==0)
                mag;
                 row;
                  col;
                   sp=' ';
                    break;
                     endif

            if (dark_on_light)
                G_x = -G_x/mag;
                G_y = -G_y/mag;
            else 
                G_x = G_x/mag;
                G_y = G_y/mag;
            endif


            while(true)


                curX = curX + G_x*prec;
                curY = curY + G_y*prec;
                
                if (floor(curX) ~= curPixX || floor(curY) ~= curPixY)

                    curPixX = floor(curX);
                    curPixY = floor(curY);

                    % check if pixel is outside boundary of image
                    if (curPixX < 1 || (curPixX > rows) || curPixY < 1 || (curPixY > cols))
                        break;
                    endif


                    ci(curPixX,curPixY)=K/(rows*cols);

                    K=K+1;


                    pnew= Point;
                    pnew.x = curPixX;
                    pnew.y = curPixY;

                    points(pushBackVar)=pnew;
                    pushBackVar=pushBackVar+1;

                    if (eei(curPixX, curPixY) > 0)

                        r.q = pnew;

                        % dot product
                        G_xt = GX(curPixX,curPixY);
                        G_yt = GY(curPixX,curPixY);
                            
                        mag = sqrt( (G_xt * G_xt) + (G_yt * G_yt) );
                        if(mag==0)
                mag;
                 curPixX;
                  curPixY;
                   sp=' ';
                    break;
                     endif


                        if (dark_on_light)
                            G_xt = -G_xt / mag;
                            G_yt = -G_yt / mag;
                        else
                            G_xt = G_xt / mag;
                            G_yt = G_yt / mag;
                        endif



                        if (acos(G_x * -G_xt + G_y * -G_yt) < PI/2.0 )

                            len = sqrt( (r.q.x - r.p.x)*(r.q.x - r.p.x) + (r.q.y - r.p.y)*(r.q.y - r.p.y));


                            for pit=1:size(points,2)


                                if (eeei(points(pit).x, points(pit).y) == inf)
                                    eeei(points(pit).x, points(pit).y) = len;
                                else
                                    len=min(len, eeei(points(pit).x, points(pit).y));
                                    eeei(points(pit).x, points(pit).y) = len;
                                    points(pit).swt=len;                               endif

                            endfor

                            r.pointVect = points;
                             
                                rayVect(rayPushBackVar)=r;
                                rayPushBackVar=rayPushBackVar+1;

                        endif



                        break;

                    endif       


                endif



            endwhile

            %figure;
            %imagesc(ci);title([num2str(row) '  ' num2str(col)]);

            ci=ei.*0.01;







        endif


        
    endfor

endfor
eeei(~isfinite(eeei))=0;
figure;imagesc(eeei);

%eeei(~isfinite(eeei))=0;

strokeWidthMetric = std(eeei)/mean(eeei)


%Doing Median Filter acc to paper
eeei=mySWTMedianFilter(rayVect,eeei);

eeei(~isfinite(eeei))=0;
figure;
imagesc(eeei);


strokeWidthMetric = std(eeei)/mean(eeei)



swtConnComp(eei);






%swtConnComp(eeei);



endfor
strokeWidthMetric;
strokeWidthFilterIdx(j) = strokeWidthMetric == strokeWidthThreshold;

endfor


% Remove regions based on the stroke width variation

mserRegions(strokeWidthFilterIdx) = [];
mserStats(strokeWidthFilterIdx) = [];






end