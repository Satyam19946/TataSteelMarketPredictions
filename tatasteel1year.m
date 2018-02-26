%DATASET IS TAKEN FROM https://www.nseindia.com/products/content/equities/equities/eq_security.htm
% THE STOCK IN CONSIDERATION IS OF TATASTEEL
% PROGRAM STILL UNDER DEVELOPMENT TO MAKE IT AUTOMATICALLY ADD THE NEW ENTRIES WHICH ARE TESTED AND IMPROVE THE PREDICTIONS


pkg load io
filename = '24-02-2017-TO-23-02-2018TATASTEELALLN.csv';

%Reading from the file
c = csv2cell(filename);
date = cell2mat(c(:,1));
prevclose = cell2mat(c(:,2));
openprice = cell2mat(c(:,3));
highprice = cell2mat(c(:,4));
lowprice  = cell2mat(c(:,5));
lastprice = cell2mat(c(:,6));
closeprice= cell2mat(c(:,7));
averageprice = cell2mat(c(:,8));
totaltraded = cell2mat(c(:,9));
turnover = cell2mat(c(:,10));
numberoftrades = cell2mat(c(:,11));
deliverablequantity = cell2mat(c(:,12));
deliveryquantitytotradedquantity = cell2mat(c(:,13));
%

%Defination of the Gradient Descent Function
function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha
% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters	
	hypothesis = X * theta;
	theta = theta - (1/m)*alpha*(X'*(hypothesis-y));
    J_history(iter) = computeCost(X, y, theta);
end

end

m = length(openprice);

%Linear regression on Opening Price to Predict High Price
%
%
X = [ones(m,1),openprice];
Y1 = highprice;
theta1 = [0;0];
%Taking initial parameters to be 0 and 1
alpha = 0.0000001;
num_iters = 10000;
[theta1,J]=gradientDescent(X,Y1,theta,alpha,num_iters);
%
%Uncomment these to plot the graphs too
%plotData(X(:,2),Y1);
%hold on; 
%plot(X(:,2), X*theta1, '-')
%legend('Training data', 'Linear regression')


%Linear regression on Opening Price to Predict Close Price
Y2 = closeprice;
theta2 = [0;0];
alpha = 0.0000001;
num_iters = 10000;
[theta2,J]=gradientDescent(X,Y2,theta2,alpha,num_iters);
%
%Uncomment these to plot the graphs too
%plotData(X(:,2),Y2);
%hold on; 
%plot(X(:,2), X*theta2, '-')
%legend('Training data', 'Linear regression')


%Calculating Estimated High Price and Close Price Respectively.
a=input("Enter Todays Opening Price for Tata Steel>>");
disp("Today's Estimated High Price and Close Price Respectively are");
disp(theta1(1)+theta1(2)*a);
disp(theta2(1)+theta2(2)*a);