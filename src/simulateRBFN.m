function [ MSE , testOutput , trainingOutput , net ] = simulateRBFN( trainingInput , trainingTarget , testInput , testTarget , sigma , maxHiddenQuantity )
    % Simulates Radial Basis Function Network on provided data and given parameters (sigma for
    % Gaussian deviation and maxHiddenQuantity for max number of neurons in hidden layer)
    
    %% Code
    net = newrb( trainingInput , trainingTarget , 0 , sigma , maxHiddenQuantity );
    trainingOutput = net(trainingInput);
    testOutput = net(testInput);
    MSE = [ calcMSE( trainingOutput , trainingTarget ) , calcMSE( testOutput , testTarget ) ];
end
