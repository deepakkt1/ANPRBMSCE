%% Initialization
clear ; close all; clc

keySet = {1, 2};
valueSet = {'Bike','Car'};
mapObj = containers.Map(keySet, valueSet);

%% Seting up the parameters
input_layer_size  = 2500;  % 50x50 Input Images of Digits
hidden_layer_size = floor(input_layer_size * 2/3);   % 1667 hidden units (hidden_layer_size = input_layer_size*(2/3))
num_labels = 2;          % 2 labels, 1 for Bike:2 for Car.   

load('TrainedValues.mat'); % load trained theta values for classification
load('TestData.mat')   %load images to test classification
% Test Data on the Neural Network to see its performance
for i = 1:size(X_test,1)
    displayData(X_test(i,:));
    pred = predict(Theta1, Theta2, X_test(i,:));
    fprintf('\nNeural Network Prediction: ');
    disp(mapObj(pred));
    fprintf('\n');
    pause;
end
close all;