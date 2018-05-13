function link1to2(bbox,i,progress)


%coming bbox are of all segmented characters 
%and we dont know which characters form what word
%so we will try to find a box around the closely
%packed characters which may be forming a word
wordBox=expandAndMergeBoundBox(bbox,i,0.3,0);



%word boxes are numbered in increasing order of vertical distance only
%but they may be ordered like actual text.i.e, top to bottom and left to right
printboxes(wordBox,i,'Before Box Rearranging',1);
wordBox=orderBoxPlace(wordBox,20);
printboxes(wordBox,i,'After Box Rearranging',1);


%now these big boxes are generally words
%so we have to segment them into only those
%characters which are contained in it.


charBoxArray=charSegment(wordBox,bbox);
%getting dimension array of characters which belong to
%big box or words 
answer={};
arrInd=1;


addpath('..\Stage2 Code');
	%pwd gives current directory and above command make 
	%child directory accessible
	load('thetas.mat'); %loading thetas



printboxes(wordBox,i,'Final Image',0);

waitbar(0.85,progress,'Feding to Neural Network');

progressPercent=0.85;

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
			detectedChar=stage2(im,Theta1, Theta2);
			ans=[ans,detectedChar];
			text(charbounds(:,1),charbounds(:,2),detectedChar,'Color','b','FontSize',30);
			
		endfor
		answer{arrInd}=ans;
		arrInd=arrInd+1;
	endif


	progressPercent=progressPercent+ 0.14/size(charBoxArray,2);
	waitbar(progressPercent,progress);

	

endfor


clc

%answer

%printboxes(wordBox,i,'Final Image',0);
%text(wordBox(:,1),wordBox(:,2),answer,'Color','b','FontSize',30);


j=0;
for i=1:size(answer,2)
	
	if(answer{i}(1)==char(i+64))
		j=j+1;
	endif
	endfor
j
accuracy=j/26
end