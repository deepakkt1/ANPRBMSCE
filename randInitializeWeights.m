function W = randInitializeWeights(L_in, L_out)
%RANDINITIALIZEWEIGHTS Randomly initialize the weights of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. 
%
%   Note that W should be set to a matrix of size(L_out, 1 + L_in) as
%   the column row of W handles the "bias" terms
%

W = zeros(L_out, 1 + L_in);

% epsilon_init = sqrt(6)/sqrt(L_out + L_in)
% Here epsilon_init is chosen as sqrt(6)/sqrt(input_layer_size + num_labels)
epsilon_init = sqrt(6)/sqrt(L_out + L_in);

% This creates a matrix with random values in the range [-epsilon_init, epsilon_init]
W = rand(L_out, 1 + L_in)*2*epsilon_init-epsilon_init;
end
