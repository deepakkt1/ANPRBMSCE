function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network


Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
% Forward Propagation start
X = [ones(m,1) X];
a1 = X;
z2 = a1*Theta1';
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
z3 = a2*Theta2';
h = sigmoid(z3);
ynew = zeros(m,num_labels);
for i=1:m,
 ynew(i,y(i))=1;
end

% J is logistic regression cost function with regularization
J = (1/m)*sum(sum((-ynew.*log(h))-((1-ynew).*log(1-h))));
J = J + (lambda/(2*m))*(sum(sum(Theta1(:,2:end).^2)) + sum(sum(Theta2(:,2:end).^2)));
% Forward propagation end


% Backward Propagation start
    a1 = X;
    z2 = a1*Theta1';
    a2 = sigmoid(z2);
    a2 = [ones(m,1) a2];
    z3 = a2*Theta2';
    a3 = sigmoid(z3);
    delta3 = a3-ynew;
    delta2 = (delta3*Theta2).*[ones(m,1) sigmoidGradient(z2)];
    delta2 = delta2(:,2:end);
    Theta2_grad = Theta2_grad + delta3'*a2;
    Theta1_grad = Theta1_grad + delta2'*a1;

Theta1_grad = Theta1_grad./m;
Theta2_grad = Theta2_grad./m;

Theta1_grad = Theta1_grad + (lambda/m)*[zeros(size(Theta1,1),1) Theta1(:,2:end)];
Theta2_grad = Theta2_grad + (lambda/m)*[zeros(size(Theta2,1),1) Theta2(:,2:end)];
% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
