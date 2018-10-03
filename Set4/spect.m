trainData = csvread('SpectTrainData.csv');
trainY = csvread('SpectTrainLabels.csv');
testData = csvread('SpectTestData.csv');
testY = csvread('SpectTestLabels.csv');
p = []; % pi set
n = 2;
pp = 0.5;
sizeTrD = size(trainData);
sizeTD = size(testData);

% Query: P(y|x) given x, in which label should it be
for i = 1 : sizeTrD(2)
    xi = trainData(:,i);
    xi1 = 0;
    for j = 1 : sizeTrD(1)
        if xi(j) == 1
            xi1 = xi1 + 1;
        end
    end
    tempPi = (xi1+ n*pp) / (sizeTrD(1) + n);
    p = [p, tempPi];
end

py = 0; % p(y = 1)
y1 = 0;
for i = 1 : sizeTrD(1)
    if trainY(i) == 1
        y1 = y1 + 1;
    end
end
py = y1 / sizeTrD(1);

xp = []; % p(x) of each record in test data
for i = 1 : sizeTD(1)
    x = testData(i,:);
    temp = 1;
    for j = 1 : sizeTD(2)
        temp = temp * ( power(p(j), x(j)) * power((1 - p(j)), (1 - x(j))) );
    end
    xp = [xp; temp];
end

% P(x|y) given y, what's the probability of the label of x is y
% ...* P(xi|y) *....
pxi1y1 = []; % P(xi=1|y=1). P(xi=0|y=1) = 1 - P(xi=1|y=1)
pxi1y0 = [];

for i = 1 : sizeTrD(2) % each attribute
    totalx0y1 = 0; % given y = 1, this is the total number of xi that = 0;
    totalx1y1 = 0;
    totalx0y0 = 0; 
    totalx1y0 = 0;
    for j = 1 : sizeTrD(1) % each sample
        if trainY(j) == 1
            if trainData(j,i) == 1
                totalx1y1 = totalx1y1 + 1;
            else
                totalx0y1 = totalx0y1 + 1;
            end
        else
            if trainData(j,i) == 1
                totalx1y0 = totalx1y0 + 1;
            else
                totalx0y0 = totalx0y0 + 1;
            end
        end
    end
    temp = totalx1y1 / (totalx1y1 + totalx0y1);
    pxi1y1 = [pxi1y1, temp];
    temp = totalx1y0 / (totalx1y0 + totalx0y0);
    pxi1y0 = [pxi1y0, temp];
end

pxi0y1 = abs(pxi1y1 - 1);
pxi0y0 = abs(pxi1y0 - 1);
% P(x|y) is proportional to p(x1|y) * ... * p(xn|y)
pxy1 = [];
pxy0 = [];
for i = 1 : sizeTD(1) % each sample in test P(this.x | y == 1)
    product = 1;
    for j = 1 : sizeTD(2)% each attribute P(this.x | y == 1)
        if testData(i,j) == 1
            product = product * pxi1y1(j);
        else
            product = product * (1 - pxi1y1(j));
        end
    end
    thisIsy1 = product / xp(i);
    product = 1;
    for j = 1 : sizeTD(2)% each attribute P(this.x | y == 0)
        if testData(i,j) == 1
            product = product * pxi1y0(j);
        else
            product = product * (1 - pxi1y0(j));
        end
    end
    thisIsy0 = product / xp(i);
    temp = thisIsy1 / (thisIsy1 + thisIsy0);
    pxy1 = [pxy1, temp];
    temp = 1 - temp;
    pxy0 = [pxy0, temp];
end

errorNum = 0;
for i = 1 : sizeTD(1)
    if testY(i) == 1 & pxy0(i) > 0.5
        errorNum = errorNum + 1;
    elseif testY(i) == 0 & pxy0(i) < 0.5
        errorNum = errorNum + 1;
    else
    end
end
errorRate = errorNum/sizeTD(1);
