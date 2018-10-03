% load data
load irisData.csv
k=3;
loopNum = 1000;
% ramdonly select k numbers as the k means
[numOfData numOfDim]=size(irisData);
mu = [];
% randomly select k center
% assign each mean to each Gaussian as their mean
for j = 1:k-1
    mu(j,:) = [irisData(round(numOfData/k*rand()), :)];
end
j=k;
mu(j,:) = [irisData(round(numOfData/k*rand()), :)];
% init loglikes
loglikes = mu;
% init the weight
w = [];
for j = 1:k
    w = [w,1/k]; 
end
% then init sigma
sigmaM = eye(4);
sigma = [];
for j = 1:k
    sigma = [sigma;1];
end

% start loop
for kkk = 1:loopNum

    % E step
    % rij is P(yi = j|xi)
    % each coloum of r is ri
    r = [];
    for j = 1:k
        newr = [];
        for i = 1:numOfData
            pxiyj = mvnpdf(irisData(i,:),mu(j,:),(sigma(j)*sigmaM));
            pyj = w(j);
            pxi= 0;
            for nn = 1:k
                pxi = pxi + mvnpdf(irisData(i,:),mu(nn,:),(sigma(nn)*sigmaM))*w(nn);
            end
            rij = pxiyj * pyj /(pxi);
            newr = [newr; rij];
        end
        r = [r,newr];
    end

    % nj
    n = [];
    for j = 1:k
        temp = 0;
        for i = 1:numOfData
            temp = temp + r(i,j);
        end
        n = [n,temp];
    end

    % M step
    % weight w
    w = n/numOfData;

    % mean
    mu = [];
    for j = 1:k
        temp = 0;
        for i = 1:numOfData
            temp = temp + (r(i,j)*irisData(i,:));
        end
        temp1 = temp/n(j);
        mu = [mu; temp1];
    end

    loglikes = [loglikes; mu];
    % sigma
    sigma = [];
    for j = 1:k
        temp = 0;
        for i = 1:numOfData
            temp1 = (irisData(i,:)-mu(j,:));
            temp = temp + r(i,j) * (temp1 * temp1');
        end
        temp = sqrt(temp/n(j));
        sigma = [sigma; temp];
    end
end
