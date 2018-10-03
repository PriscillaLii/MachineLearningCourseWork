function [center km_final]=kmeans(dataSet,k)
    [numOfData numOfDim]=size(dataSet);
    randValue=round(numOfData/k*rand());
    center = [];
    %randomly select k center
    for j = 1:k
        center(j,:) = [dataSet(randValue * j, :)];
    end
    while 1
        pre_center=center;%change center at each loop
        for i=1:k
            xSubCenter{i}=[];%make the finding of distance eaiser
            for j=1:numOfData
                xSubCenter{i}=[xSubCenter{i};dataSet(j,:)-center(i,:)];
            end
        end
        weight=zeros(numOfData,k);%find distance
        for i=1:numOfData
            distance=[];
            for j=1:k
                distance=[distance norm(xSubCenter{j}(i,:))];
            end
            [value indexOfMin]=min(distance);
            weight(i,indexOfMin)=norm(xSubCenter{indexOfMin}(i,:));
        end
        for i=1:k%new center
            for j=1:numOfDim
                center(i,j)=sum(weight(:,i).*dataSet(:,j))/sum(weight(:,i));
            end
        end
        if norm(pre_center-center)<0.01 %when the center is unlikely to change, stop the loop
            break;
        end
    end
    km_final=[];
    for i=1:numOfData
        xSubCenter=[];
        for j=1:k
            xSubCenter=[xSubCenter norm(dataSet(i,:)-center(j,:))];
        end
        [value indexOfMin]=min(xSubCenter);
        km_final=[km_final;dataSet(i,:) indexOfMin];
    end
end