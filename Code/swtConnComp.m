function swtConnComp(I)

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


cc=bwconncomp(newI);
cc.NumObjects

end
