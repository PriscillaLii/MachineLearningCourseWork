trainX = randn(1000, 20);
trainY = randn(1000, 1);
testX = randn(500, 20);
testY = randn(500, 1);

k = [0.01,0.05,0.1,0.2,0.3];
b = ridge(trainY,trainX,k);
figure
plot(k,b)
grid on 
xlabel('Ridge Parameter') 
ylabel('Standardized Coefficient') 

kk = [0.01, 10, 20,50,100,500,1000, 2000, 3000, 4000, 5000];
bb = ridge(trainYA,trainXA,kk);
figure
plot(kk,bb)
grid on 
xlabel('Ridge Parameter') 
ylabel('Standardized Coefficient') 


trainXC = csvread('ffX.csv');
trainYC = csvread('ffY.csv');

kC = [1,150,470,700,1000];
bC = ridge(trainYC,trainXC,kC);

ridgeMSEC = zeros(1,5);
for i = 1:5
    ridgeMSEC(i) = immse(testYC,testXC*bC(:,i));
end
ridgeMSEC


figure
plot(kC,bC)
grid on 
xlabel('Ridge Parameter') 
ylabel('Standardized Coefficient') 


lambdaC = [0.01,0.3,0.6,1,1.6];
[BC,infoC] = lasso(trainXC,trainYC,'Lambda',lambdaC);
figure
plot(lambdaC,BC)
grid on 
xlabel('Ridge Parameter') 
ylabel('Standardized Coefficient') 
lassoMSEC = zeros(1,5);
for i = 1:5
    lassoMSEC(i) = immse(testYC,testXC*BC(:,i));
end
lassoMSEC

lassoMSEA = zeros(1,5);
for i = 1:5
    lassoMSEA(i) = immse(testYA,testXA*BA(:,i));
end

lassoMSEB = zeros(1,5);
for i = 1:5
    lassoMSEB(i) = immse(testYB,testXB*BB(:,i));
end

nonzero = zeros(1,5);
for i = 1:5
    nonzero(i) = sum(bC(:,i)~=0);
end
nonzero

ridgeMSEA = zeros(1,5);
for i = 1:5
    ridgeMSEA(i) = immse(testYA,testXA*bA(:,i));
end
ridgeMSEA

ridgeMSEC = zeros(1,5);
for i = 1:5
    ridgeMSEC(i) = immse(testYC,testXC*bC(:,i));
end
ridgeMSEC

figure
plot(kC,ridgeMSEC)
grid on 
xlabel('Ridge Parameter') 
ylabel('MSE') 

figure
plot(lambdaA,lassoMSEA)
grid on 
xlabel('Ridge Parameter') 
ylabel('MSE') 