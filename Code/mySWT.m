function mySWT

i=imread('E:\Photo OCR\Project\Code\Sample Images\swt.jpg'); 

gi=rgb2gray(i);

%calculating Canny edge image
[ei t]=edge(gi,'canny');

eei=ei;
%calculating gradients of gi
[GX GY]=gradient(gi);


prec=0.5;

%total rows and columns in gray image
[rows cols]=size(gi);

%point struct to store a point having 'x','y' and 'SWT value'
Point=struct('x',-1,'y',-1,'swt',inf);

%ray struct to store 'p-point','q-point' and 'point vector'
Ray=struct('p',Point,'q',Point,'pointVect',Point);


dark_on_light=1;
PI=22/7;
%


raysVect=Ray;
rV=0;

%treding through each pixel
for row=1:rows
	for col=1:cols
		if(eei(row,col)~=0)
			r=Ray;

			p=Point;
			p.x=row;
			p.y=col;

			r.p=p;

			points=Point;

			points(1)=p;



			curX = col + 0.5;
            curY = row + 0.5;

            curPixX = col;
            curPixY = row;

            G_x = GY(row, col);
            G_y = GY(row, col);

            % normalize gradient
            mag = sqrt( (G_x * G_x) + (G_y * G_y) );

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
                    if (curPixX < 0 || (curPixX >= rows) || curPixY < 0 || (curPixY >= cols))
                    	break;
                    endif

                    pnew= Point;
                    pnew.x = curPixX;
                    pnew.y = curPixY;

                    points(2)=pnew;



                    if (eei(curPixY, curPixX) > 0)

                    	r.q = pnew;

                        % dot product
                        G_xt = GX(curPixY,curPixX);
                        G_yt = GY(curPixY,curPixX);
                            
                        mag = sqrt( (G_xt * G_xt) + (G_yt * G_yt) );

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
                        		
                        		if (eei(points(pit).y, points(pit).x) < 0)
                        			eei(points(pit).y, points(pit).x) = len;
                        		else
                        			eei(points(pit).y, points(pit).x) = min(len, eei(points(pit).y, points(pit).x));
                        		endif

                        	endfor

                        	r.pointVect = points;
                        	raysVect(rV+1)=r;

                        endif

                        break;

                    endif
                
                endif

            endwhile

        endif

    endfor

endfor







end