function [connComp numRegionsInGroup]=conncomp(G)
%this function return vector of index of respective connected components to which nodes of grapg G lie

%this function works similarly to the 'conncomp' funciton of Matlab

numRegionsInGroup=[];

nodes=size(G,1);
compInd=zeros(1,nodes);
componentIndices = findConnComp(G);% compInd is cell array containing connected nodes

%changing nodes to the number of the connected component they lie in
for i=1:size(componentIndices,2)
	c2m=cell2mat(componentIndices(1,i));%convert cell's ith cell into matrix
	nodesInComp=size(c2m,2);%calc size of that matrix
	for j=1:nodesInComp
		compInd(1,c2m(1,j))=i;%save ith component into jth(j-node) place
	end

numRegionsInGroup=[numRegionsInGroup size(c2m,2)];
end

%changing cell array into 1xnum_of_nodes matrix
connComp=compInd;

