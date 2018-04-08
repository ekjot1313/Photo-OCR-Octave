function testNN

load('train_test_Data.mat'); %loading test cases

X=X_tst;
y=y_tst;


load('thetas.mat'); %loading thetas

p = predict(Theta1, Theta2, X);

correct=sum(p==y_tst)
total=size(y_tst,1)

accuracy=correct*100/total

end