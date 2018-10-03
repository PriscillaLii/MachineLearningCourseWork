cs = [];
me = [];
ee = [];
aaa = zeros(1,120);
for i=7:120
    %aaa(floor(i/2)) = 1;
    %aaa(floor(i/5)) = 1;
    aaa(floor(i/7)) = 1;
end

count = 0;
for i=1:120
    if aaa(i) == 0
     count = count +1;
    end
end

figure
X = linespace(0,2*pi,50)';
stem(X)
hold on
Y = [cos(X), 0.5*sin(X);
stem(Y)

fuction x = main
x = 0;
nestfun1
    function nestfun1
        x = 5;
    end
x = x +1;
end