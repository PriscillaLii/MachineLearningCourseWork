trainXa = randn(1000,20);
trainYa = randn(1000,1);
testXa = randn(500,20);
testYa = randn(500,1);

Datab = csvread('cloud.csv');
[M,N] = size(Datab);
labelb = Datab(:,7);
Datab = [Datab(:,1:6),Datab(:,8:N)];
trainXb = Datab(1:800,:);
trainYb = labelb(1:800,1);
testXb = Datab(801:M,:);
testYb = labelb(801:M,:);

Datac = csvread('forestfires.csv',1,0);
[P,Q] = size(Datac);
nvector = randperm(P);
temp = zeros(P,Q);

for i= 1:P
    temp(i,:) = Datac(nvector(i),:);
end
Datac = temp;

labelc = log(Datac(:,13)+1);
Datac = [Datac(:,1:12),Datac(:,14:Q)];
trainXc = Datac(1:400,:);
trainYc = labelc(1:400,1);
testXc = Datac(401:P,:);
testYc = labelc(401:P,:);

LambdaL = [0.01,0.05,0.1,0.2,0.3];
[Lomiga,Linfo] = lasso(trainXa,trainYa,'Lambda',LambdaL);
fprintf('the Lambda of set A are:');
disp(Linfo.Lambda);
fprintf('the number of non-zero coefficients of set A are:');
disp(Linfo.DF);
%plot(LambdaL,Linfo.DF,'r');

LMSE = zeros(1,5);

for i = 1:5
    LMSE(i) = immse(testYa,testXa*Lomiga(:,i));
end

fprintf('the MSE of set A are:');
disp(LMSE);
%plot(LambdaL,LMSE,'r');

for i = 1:5
    if(Linfo.DF(i) ~= 0)
        Lflag = i;
    else
        break;
    end
end

fprintf('the Lambda of min_non-zeros of set A is:');
disp(LambdaL(Lflag));
fprintf('the number of non-zero in it is:');
disp(Linfo.DF(Lflag));
fprintf('the MSE of it is:');
disp(LMSE(Lflag));
Lplace = find(LMSE == min(LMSE));
fprintf('the Lambda of min_MSE of set A is:');
disp(LambdaL(Lplace));
fprintf('the number of non-zero in it is:');
disp(Linfo.DF(Lplace));
fprintf('the MSE of it is:');
disp(LMSE(Lplace));


LambdaR = [1,50,100,200,1000];
Romiga = ridge(trainYa,trainXa,LambdaR);
fprintf('the Lambda of set A are:');
disp(LambdaR);

number = zeros(1,5);

for i = 1:5
    number(i) = sum(Romiga(:,i)~=0);
end

fprintf('the number of non-zero coefficients of set A are:');
disp(number);
%plot(LambdaR,Linfo.DF,'r');

RMSE = zeros(1,5);

for i = 1:5
    RMSE(i) = immse(testYa,testXa*Romiga(:,i));
end

fprintf('the MSE of set A are:');
disp(RMSE);
%plot(LambdaR,RMSE,'r');
Rflag = find(number == min(number));
fprintf('the Lambda of min_non-zeros of set A is:');
disp(LambdaR(Rflag));
fprintf('the number of non-zero in it is:');
disp(number(Rflag));
fprintf('the MSE of it is:');
disp(RMSE(Rflag));
Rplace = find(RMSE == min(RMSE));
fprintf('the Lambda of min_MSE of set A is:');
disp(LambdaR(Rplace));
fprintf('the number of non-zero in it is:');
disp(number(Rplace));
fprintf('the MSE of it is:');
disp(RMSE(Rplace));