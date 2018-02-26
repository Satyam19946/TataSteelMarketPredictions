%DATASET IS TAKEN FROM https://www.nseindia.com/products/content/equities/equities/eq_security.htm
% THE STOCK IN CONSIDERATION IS OF TATASTEEL
% PROGRAM STILL UNDER DEVELOPMENT TO MAKE IT AUTOMATICALLY ADD THE NEW ENTRIES WHICH ARE TESTED 
% A SEPARATE SHEET IS ALSO UPDATED DAILY TO CALCULATE THE DIFFERENCE BETWEEN THE ESTIMATE AND THE ACTUAL PRICE.
% ASSISSTANCE IS REQUIRED TO MAKE THE PROGRAM AUTOMATICALLY ADD NEW ENTRIES TO THE DATASET AND IMPROVE ITS OWN PREDICTIONS.

pkg load io
filename = '25-02-2016-TO-23-02-2018TATASTEELALLN.csv'; %Change the filename accordingly


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



%Linear regression on Opening Price to Predict High Price
%
%

m = length(openprice);
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

%Linear regression on Opening Price to Predict Low Price
Y3 = lowprice;
theta3 = [0;0];
alpha = 0.0000001;
num_iters = 10000;
[theta3,J3]=gradientDescent(X,Y3,theta3,alpha,num_iters);
%Uncomment these to plot the graphs too
plotData(X(:,2),Y3);
hold on; 
plot(X(:,2), X*theta3, '-')
legend('Training data', 'Linear regression')

%Calculating Estimated High Price,Close Price and Low Price Respectively.
a=input("Enter Todays Opening Price for Tata Steel>>");
disp("Todays Estimated High Price is");
disp(theta1(1)+theta1(2)*a);
disp("Todays Estimated Closing Price is ")
disp(theta2(1)+theta2(2)*a);
disp("Todays Estimated Low Price is ")
disp(theta3(1)+theta3(2)*a);
