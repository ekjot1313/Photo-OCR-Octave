function i=imagePreprocessing(I)
%figure;imshow(I);

%removing salt and pepper noise 

%adding noise explicitly
i=imnoise(I,'salt & pepper',0.02);

%removing salt and pepper noise using medfilt2
%i=medfilt2(i);
figure;imshow(i);


%removing noise using ordfiltn
i=ordfiltn(i,13,true(5));
figure;imshow(i);




end