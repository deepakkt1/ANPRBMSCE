function p = imagePredict(X_test)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)


keySet = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36};
valueSet = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', ...
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
mapObj = containers.Map(keySet, valueSet);


load('FinalThetas.mat'); %load Trained Theta matrices
load('TestData2.mat');

% Display the prediction
for i = 1:size(X_test,1)
    % displayImage(X_test(i,:));
    displayData(X_test(i,:));
    pred = predict(Theta1, Theta2, X_test(i,:));
    fprintf('\nNeural Network Prediction: ');
    disp(mapObj(pred));
    fprintf('\n');
    pause;
end
end
