function swtConnComp(I)

%adding load path of Octave Graph Theory library
%addpath('E:\Photo OCR\Project\Code\lib\octave-networks-toolbox-master');

% Create the graph
%g = graph(overlapRatio);

% Find the connected text regions within the graph
%[componentIndices numRegionsInGroup]= conncomp(g)

chvl='func start'
swtmap=I(:);

G=zeros(size(swtmap),size(swtmap));

Rows=size(I,1);
Cols=size(I,2);

for  row=1:Rows
	for col=1:Cols
		if (I(row,col)~=0)
			pixswt=I(row,col);
			% check pixel to the right, right-down, down, left-down
			this_pixel = row * Cols + col;

			if (col+1 < Cols)
				right = I(row, col+1);
				if (right > 0 && (pixswt/right <= 3.0 || right/pixswt <= 3.0))
					G(this_pixel, row * Cols + col + 1)=1;
					G(row * Cols + col + 1,this_pixel)=1;
				endif
			endif

			if (row+1 < Rows)
				if (col+1 < Cols)
					right_down = I(row+1, col+1);
					if (right_down > 0 && (pixswt/right_down <= 3.0 || right_down/pixswt <= 3.0))
						G(this_pixel, (row+1) * Cols + col + 1)=1;
						G((row+1) * Cols + col + 1,this_pixel)=1;
					endif
				endif

				down = I(row+1, col);
				if (down > 0 && (pixswt/down <= 3.0 || down/pixswt <= 3.0))
					G(this_pixel, (row+1) * Cols + col)=1;
					G((row+1) * Cols + col,this_pixel)=1;
				endif

				if (col-1 >= 1)
					left_down = I(row+1, col-1);
					if (left_down > 0 && (pixswt/left_down <= 3.0 || left_down/pixswt <= 3.0))
						G(this_pixel, (row+1) * Cols + col - 1)=1;
						G((row+1) * Cols + col - 1,this_pixel)=1;
					endif
				endif

			endif



		endif



	endfor
endfor

[componentIndices numRegionsInGroup]= conncomp(G);

sum(numRegionsInGroup~=1)
cc=bwconncomp(G,4);
cc.NumObjects

chvl='func stop..................'

end