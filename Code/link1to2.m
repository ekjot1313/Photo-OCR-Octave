function link1to2(bbox,i)


%coming bbox are of all segmented characters 
%and we dont know which characters form what word
%so we will try to find a box around the closely
%packed characters which may be forming a word
wordBox=expandAndMergeBoundBox(bbox,i,0.3,0);



%word boxes are numbered in increasing order of vertical distance only
%but they may be ordered like actual text.i.e, top to bottom and left to right
printboxes(wordBox,i,'Before Box Rearranging');
wordBox=orderBoxPlace(wordBox,20);
printboxes(wordBox,i,'After Box Rearranging');


%now these big boxes are generally words
%so we have to segment them into only those
%characters which are contained in it.


charBoxArray=charSegment(wordBox,bbox);
%getting dimension array of characters which belong to
%big box or words 
answer={};
arrInd=1;


addpath('E:\Photo OCR\Project\Code\Stage2 Code');
load('thetas.mat'); %loading thetas

for word=1:size(charBoxArray,2)
	charbox=charBoxArray{word};%getting dimension matrix of given word
	charbox=dimensions2bounds(charbox);%converting to bounds

	charboxNum=size(charbox,1);

	if(charboxNum>0)
		ans=[];
		for cboxnum=1:charboxNum
			charbounds=charbox(cboxnum,:);
			im=imcrop(i,charbounds);
			im=trim(im);%to trim the extra space around the character
			%printboxes(charbounds,i,'After Box Rearranging');
			ans=[ans,stage2(im,Theta1, Theta2)];
			
		endfor
		answer{arrInd}=ans;
		arrInd=arrInd+1;
	endif
	

endfor


%clc

answer




j=0;
for i=1:size(answer,2)
	
	if(answer{i}(1)==char(i+64))
		j=j+1;
	endif
	endfor
j
accuracy=j/26
end