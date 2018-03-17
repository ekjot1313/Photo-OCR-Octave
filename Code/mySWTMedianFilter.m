function eeei=mySWTMedianFilter(rayVect,eeei)

for curRay=1:size(rayVect,2)
    

    pV=rayVect(curRay).pointVect;

    if(pV(1).x<1||pV(1).y<1)%if there is no defined ray: exit
        break;
    endif

    for curPoint=1:size(pV,2)
        rayVect(curRay).pointVect(curPoint).swt=eeei(pV(curPoint).x,pV(curPoint).y);
    endfor

    medianSWT=pV(floor((size(pV,2)+1)/2)).swt;

    for curPoint=1:size(pV,2)
        pV(curPoint).swt=min(pV(curPoint).swt,medianSWT);
        eeei(pV(curPoint).x,pV(curPoint).y)=pV(curPoint).swt;
        rayVect(curRay).pointVect=pV;

    endfor
endfor
end