figureID = 1;

%% Test for feedforward network classification
% relative to '../data/symbols'
symbolDir = '';
trainingDir = strcat( symbolDir , 'training' );
testDir = strcat( symbolDir , 'test' );
% list of indices of symbols to load such as whole notes; use empty list for all types: []
% these do not necessarily correspond to the indices of the folders since MatLab sorts string by
% ASCII, but 'loadSymbolData' will output the types loaded in console
symbolsToLoad = [1,2];

%% Load data
disp( 'Loading training data...' );
[ trainingInput , trainingTarget ] = loadSymbolData( trainingDir , symbolsToLoad );
disp( 'Loading test data...' );
[ testInput , testTarget ] = loadSymbolData( testDir , symbolsToLoad );
% normalize inputs
trainingInput = single(trainingInput) / single(max(trainingInput(:)));
testInput = single(testInput) / single(max(testInput(:)));

%% reduce dimensionality of inputs
disp( 'Reducing dimensionality using KSOM...' );
clusterQuantity = 100; % new dimensionality; increase for higher accuracy, decrease for faster FFNN training
changeThreshold = 0.001;
ksomFile = 'ksomWeights'; % filename for cache for weights; delete to recalculate weights
ksomWeights = createSymbolKSOM( [ trainingInput , testInput ] , clusterQuantity , changeThreshold , ksomFile );
trainingInput = ksomWeights * trainingInput;
testInput = ksomWeights * testInput;

%% Simulate various network parameters and get MSE
disp( 'Finding best FFNN...' );
layerList = [ 1 : 2 ]; % list of layer quantities to test
hiddenList = [ 10 : 10 : 100 ]; % list of hidden quantities to test
layerListQuantity = length(layerList);
hiddenListQuantity = length(hiddenList);
meanQuantity = 10; % number of runs to average MSE over
[ hiddens , layers ] = meshgrid( hiddenList , layerList );
errors = zeros( layerListQuantity , hiddenListQuantity , meanQuantity );
for l = 1 : layerListQuantity
    for h = 1 : hiddenListQuantity
        hiddenLayers = hiddens(l,h) * ones( 1 , layers(l,h) )
        for run = 1 : meanQuantity
            MSE = simulateFFNN( trainingInput , trainingTarget , testInput , testTarget , hiddenLayers );
            errors(l,h,run) = sum(MSE);
        end
    end
end

%% Plot results
errors = mean(errors,3);
figureID = newFigure( figureID );
surf( layers , hiddens , errors );
title( sprintf( 'MSE for Varying Layer and Hidden Neuron Quantities Averaged over %i Run(s)' , meanQuantity ) );
xlabel( 'Layer Quantity' );
ylabel( 'Hidden Neuron Quantity' );
zlabel( 'MSE' );

%% Find optimal parameters and test
[ minMSE , I ] = min(errors(:))
[ optLayerQuantity , optHiddenQuantity ] = ind2sub( [ layerListQuantity , hiddenListQuantity ] , I(1) )
hiddenLayers = optHiddenQuantity * ones( 1 , optLayerQuantity );
[ MSE , testOutput ] = simulateFFNN( trainingInput , trainingTarget , testInput , testTarget , hiddenLayers )
