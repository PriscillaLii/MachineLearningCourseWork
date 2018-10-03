% load data
load cloud.csv;
load label.csv;
t = 1;
b = 1;
avloss = [];
%R = 1000;
[dataNum, dimNum] = size(cloud);
p = [];
for i = 1:dimNum
    p = [p,1/dimNum];
end
for j = 1:dataNum
    ybar = 0;
    loss = 0;
    pplus = [];
    for i = 1:dimNum
        ybar = ybar + p(t,i) * cloud(j,i);
        loss =  (cloud(j,i) - label(j))^2; %/ R;
        pplus = [pplus, p(t,i)*exp(-b * loss)];
    end
    ptmean = 0;
    ptvar = 0;
    for k = 1:dimNum
        ptmean = ptmean + pplus(k);
    end
    ptmean = ptmean/dimNum;
    for k = 1:dimNum
        ptvar = ptvar + (pplus(k)-ptmean)^2;
    end
    ptvar = sqrt(ptvar);
    for k = 1:dimNum
        pplus(k) = (pplus(k) - ptmean)/ptvar;
    end
    p = [p;pplus];
    thisLoss = loss;
    if t == 1
        avloss = [avloss, thisLoss];
    
    else
        for k = 1:t-1
            thisLoss = thisLoss + avloss(k);
        end
        avloss = [avloss, thisLoss/t];
    end
    
    t = t+1;
    %j=j+1;
end
