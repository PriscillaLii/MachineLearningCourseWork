%(f)
%express 2D data into original 13D
newdataset = final_X*(A’);
%calculate L2 distance
L2Dis = [];
for i=1:13
    L2Dis(i) = pdist2(X(i ,:),newdataset(i,:),’euclidean');
end