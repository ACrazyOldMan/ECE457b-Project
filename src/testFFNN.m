figureID = 1;

%% Test for feedforward network classification
% relative to '../data/symbols'
trainingDir = 'training';
testDir = 'test';
% list of indices of symbols to load such as whole notes
% these do not necessarily correspond to the indices of the folders since MatLab sorts string by
% ASCII, but 'loadSymbolData' will output the types loaded in console
symbolsToLoad = [1,2];
[ trainingInput , trainingTarget ] = loadSymbolData( trainingDir , symbolsToLoad );
[ testInput , testTarget ] = loadSymbolData( testDir , symbolsToLoad );
% normalize inputs
trainingInput = single(trainingInput)/255;
testInput = single(testInput)/255;

%% Simulate various network parameters and get MSE
maxLayerQuantity = 2;
maxHiddenQuantity = 10;
meanQuantity = 1; % number of runs to average MSE over
[ hidden , layers ] = meshgrid( 1 : maxHiddenQuantity , 1 : maxLayerQuantity );
errors = zeros( maxLayerQuantity , maxHiddenQuantity , meanQuantity );
for l = 1 : maxLayerQuantity
    for h = 1 : maxHiddenQuantity
        hiddenLayers = hidden(l,h) * ones( 1 , layers(l,h) )
        for run = 1 : meanQuantity
            MSE = simulateFFNN( trainingInput , trainingTarget , testInput , testTarget , hiddenLayers );
            errors(l,h,run) = sum(MSE);
        end
    end
end

%% Plot results
errors = mean(errors,3);
figureID = newFigure( figureID );
surf( layers , hidden , errors );
title( sprintf( 'MSE for Varying Layers and Hidden Neurons Averaged over %i Runs' , meanQuantity ) );
xlabel( 'Layer Quantity' );
ylabel( 'Hidden Neurons' );
zlabel( 'MSE' );

%% Find optimal parameters and test
[ minMSE , I ] = min(errors(:))
[ optLayerQuantity , optHiddenQuantity ] = ind2sub( [ maxLayerQuantity , maxHiddenQuantity ] , I(1) )
hiddenLayers = optHiddenQuantity * ones( 1 , optLayerQuantity );
[ MSE , testOutput ] = simulateFFNN( trainingInput , trainingTarget , testInput , testTarget , hiddenLayers )
