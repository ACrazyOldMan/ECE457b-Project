function [ MSE , testOutput ] = getNetworkRMSE( hiddenLayers , trainingInput , trainingTarget , testInput , testTarget )
    net = feedforwardnet( hiddenLayers );
    net.trainParam.showWindow = false;
    net.trainParam.showCOmmandLine = false;
    net.divideFcn = 'dividetrain';
    for l = 1 : size(net.layers,1) - 1
        net.layers{l}.transferFcn = 'logsig';
    end
    net = train( net , trainingInput , trainingTarget );
    testOutput = net(testInput);
    MSE = mean( mean( ( testTarget - testOutput ) .^ 2 ) );
end
