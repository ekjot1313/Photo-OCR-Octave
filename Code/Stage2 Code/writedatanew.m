function writedatanew
list_English_Img
allLabels=list.ALLlabels;
allNames=list.ALLnames;

X_trn=[];
X_val=[];
X_tst=[];

y_trn=[];
y_val=[];
y_tst=[];


for label=11:36%for A-Z only
%1:62 for 0-9, A-Z, a-z
	classLabel=allLabels(find(allLabels==label));%get only the labels equal to 'label'
	classLabelPath=allNames(find(allLabels==label),:);%get their paths

	numOfClassLabel=size(classLabel,1);%number of total examples of given class

	randInd=randperm(numOfClassLabel); %randomize the examples
	classLabel(randInd)=classLabel;% shuffling classLabel acc to randInd
	classLabelPath(randInd,:)=classLabelPath;% shuffling classLabelPath acc to randInd


	trainInd=[1:floor(0.6*numOfClassLabel)]; % 60% will be training set
	validInd=[trainInd(end)+1:floor(0.8*numOfClassLabel)]; %	next 20% will be validation set
	testInd=[validInd(end)+1:numOfClassLabel]; % last 20% will be test set




	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% obtaining training set:=

	trainLabels=classLabel(trainInd);% getting labels acc to trainInd
	trainImgPath=classLabelPath(trainInd,:);%getting paths for them


	trainImgPath=strcat('E:\Photo OCR\Project\Datasets\EnglishImg\English\Img\', trainImgPath,'.png');

	

	for ind=1:size(trainImgPath,1)% for all training examples

		i=imread(trainImgPath(ind,:));%read image
		i=trim(i);
		if(size(i,3)==3) %if image is rgb, convert to gray
			i=rgb2gray(i);
		endif

		i=imageto20X20gray(i);

		X_trn=[X_trn;2*mat2gray(i(:)')-1];


	endfor

	y_trn=[y_trn; trainLabels];


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% obtaining validation set:=

	validLabels=classLabel(validInd);% getting labels acc to validInd
	validImgPath=classLabelPath(validInd,:);%getting paths for them


	validImgPath=strcat('E:\Photo OCR\Project\Datasets\EnglishImg\English\Img\', validImgPath,'.png');

	

	for ind=1:size(validImgPath,1)% for all validation examples

		i=imread(validImgPath(ind,:));%read image

		if(size(i,3)==3) %if image is rgb, convert to gray
			i=rgb2gray(i);
		endif

		i=imageto20X20gray(i);

		X_val=[X_val;2*mat2gray(i(:)')-1];


	endfor

	y_val=[y_val;validLabels];



	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%obtaining test set:=


	testLabels=classLabel(testInd);% getting labels acc to testInd
	testImgPath=classLabelPath(testInd,:);%getting paths for them


	testImgPath=strcat('E:\Photo OCR\Project\Datasets\EnglishImg\English\Img\', testImgPath,'.png');

	

	for ind=1:size(testImgPath,1)

		i=imread(testImgPath(ind,:));

		if(size(i,3)==3) %if image is rgb, convert to gray
			i=rgb2gray(i);
		endif

		i=imageto20X20gray(i);

		X_tst=[X_tst;2*mat2gray(i(:)')-1];

	endfor

	y_tst=[y_tst;testLabels];


endfor
%saving all data sets
save('train_Data.mat','X_trn','y_trn');
save('valid_Data.mat','X_val','y_val');
save('test_Data.mat','X_tst','y_tst');

end