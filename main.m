
%% Initialization
clear ; close all; clc

keySet = {1, 2};
valueSet = {'Bike','Car'};
mapObj = containers.Map(keySet, valueSet);

%% Seting up the parameters
input_layer_size  = 2500;  % 50x50 Input Images of Digits
hidden_layer_size = floor(input_layer_size * 2/3);   % 1667 hidden units (hidden_layer_size = input_layer_size*(2/3))
num_labels = 2;       %    2 labels, 1 for Bike:2 for Car.  

% Load Training Data
% fprintf('Loading and Visualizing Data ...\n')
 
 load('TrainData.mat'); % Load Training Data
m = size(X, 1);
displayData(X);
fprintf('\nInitializing Neural Network Parameters ...\n')
% Start timer
tic;
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

fprintf('\nTraining Neural Network... \n')

%  Change the MaxIter to a larger value to see how more training helps.
options = optimset('MaxIter', 500);

%  Try different values of lambda
lambda = 10;

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                    num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));
 
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
% Stop timer 
timeElapsed = toc;
fprintf('\nTime taken for training = %f\n',timeElapsed);


pred = predict(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);


% %Test Data on the Neural Network to see its performance
% for i = 1:size(X_test,1)
%     displayData(X_test(i,:));
%     pred = predict(Theta1, Theta2, X_test(i,:));
%     fprintf('\nNeural Network Prediction: ');
%     disp(mapObj(pred));
%     fprintf('\n');
%     pause;
% end

% Save the trained Theta1 and Theta2 for further use
save('TrainedValues.mat','Theta1','Theta2');
close all;