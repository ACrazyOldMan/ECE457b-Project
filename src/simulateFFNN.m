function [ MSE , testOutput , trainingOutput , net ] = simulateFFNN( trainingInput , trainingTarget , testInput , testTarget , hiddenLayers )
    % Simulates Feed Forward Neural Network on provided data and given parameters (hiddenLayers
    % is a row vectors representing the number of hidden nodes in each hidden layer, where each
    % element of the vector indicates a hidden layer, and the element values correspond to the
    % number of hidden nodes for that particular layer; layers are fed forward from left to right;
    % current activation function is the sigmoid function, but can be changed to whatever MatLab
    % supports)
    
    %% Code
    net = feedforwardnet( hiddenLayers );
    net.trainParam.showWindow = false;
    net.trainParam.showCOmmandLine = false;
    net.divideFcn = 'dividetrain';
    for l = 1 : size(net.layers,1) - 1
        net.layers{l}.transferFcn = 'logsig';
    end
    net = train( net , trainingInput , trainingTarget );
    trainingOutput = net(trainingInput);
    testOutput = net(testInput);
    MSE = [ calcMSE( trainingOutput , trainingTarget ) , calcMSE( testOutput , testTarget ) ];
end
