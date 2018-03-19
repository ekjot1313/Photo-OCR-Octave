function [mean, variance, median, minx, miny, maxx, maxy]=componentStats(I,componentMat)

Rows=size(I,1);
Cols=size(I,2);

    pixMat=componentMat;
    numPix=size(pixMat,1);


        mean = 0;
        variance = 0;
        minx = inf;
        miny = inf;
        maxx = 0;
        maxy = 0;

        swtMat=[];

        for curPix=1:numPix
            pixInd=pixMat(curPix);
            pixX=rem(pixInd,Rows);
            if(pixX==0)
                pixX=Rows;
            endif
            pixY=(pixInd-pixX)/Rows+1;
            

            swt=I(pixX,pixY);
            swtMat=[swtMat; swt];

            mean = mean + swt;

            miny = min(miny,pixY);
            minx = min(minx,pixX);
            maxy = max(maxy,pixY);
            maxx = max(maxx,pixX);

        endfor

        mean = mean / numPix;

        for curSwt=1:size(swtMat,1)
            variance = variance + (swtMat(curSwt) - mean) * (swtMat(curSwt) - mean);
        endfor

        variance = variance / numPix;

        swtMat=sort(swtMat);
        median = swtMat(uint16(size(swtMat,1)/2),1);	
end