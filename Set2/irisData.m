Data = csvread('irisData.csv');
[M,N] = size(Data);
k = 3;
iterations = 10;
sigma = ones(1,k);
r1 = unidrnd(M);
r2 = unidrnd(M);
r3 = unidrnd(M);
mu = {Data(r1,:),Data(r2,:),Data(r3,:)};
omiga = [1/k,1/k,1/k];
n = zeros(1,k);
L = zeros(1,iterations);
number = 1;

while number <= iterations
    
    %E
    f = {mvnpdf(Data,mu{1},sigma(1)*eye(N,N)),...
        mvnpdf(Data,mu{2},sigma(2)*eye(N,N)),...
        mvnpdf(Data,mu{3},sigma(3)*eye(N,N))};
    
    for i = 1:M
        
        proX = 0;
        
        for j = 1:k
            proX = proX + omiga(j)*f{j}(i);
        end
        
        for  j = 1:k
            proYgX(i,j) = (f{j}(i)*omiga(j))/proX;
        end
        
    end
    
    %M
    n = zeros(1,k);
    
    for i = 1:M
        for j = 1:k
            n(j) = n(j) + proYgX(i,j);
        end
    end
    
    for i = 1:k
        
        tempMu = zeros(1,N);
        tempSigma = 0;
        omiga(i) = n(i)/M;
        
        for j = 1:M
            tempMu = tempMu + proYgX(j,i)*Data(j,:);
        end
        
        if(n(i)~=0)
            mu{i} = tempMu/n(i);
        else
            mu{i} = zeros(1,N);
        end
        
        for j = 1:M
            tempSigma = tempSigma + (proYgX(j,i)*...
                sum(sum((Data(j,:)-mu{i}).^2)));
        end
        
        if(n(i)~=0)
            sigma(i) = tempSigma/(N*n(i));
        else
            sigma(i) = 1;
        end
            
    end
    
    %L
    tempL = 0;
    
    for i = 1:numOfData
        for j = 1:k
            tempL = tempL + r(i,j)*(log(mvnpdf(irisData(i,:),mu(j,:),(sigma(j)*sigmaM))*w(j);)+log(w(j)));
        end
    end
    
    L = [L, tempL];
    

end

plot(1:loopNum,L);
fprintf('The maximum of L is:%d',max(L));