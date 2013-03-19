figureID = 1;

%% 4.1
trainingRatio = 0.75;
samples = load( 'ExampleData' );
[ sorted , indices ] = sort(samples(:,1));
samples = samples( indices , : );
classTotals = [ sum( sorted == 1 ) , sum( sorted == 2 ) , sum( sorted == 3 ) ];
trainingQuantities = ceil( trainingRatio * classTotals );
trainingInput = [];
trainingTarget = [];
testInput = [];
testTarget = [];
for i = 1 : length(trainingQuantities)
    classInput = samples( sorted == i , 2:end );
    classOutput = sorted( sorted == i );
    trainingInput = [ trainingInput , classInput(1:trainingQuantities(i),:)' ];
    trainingTarget = [ trainingTarget , classOutput(1:trainingQuantities(i))' ];
    testInput = [ testInput , classInput(trainingQuantities(i)+1:end,:)' ];
    testTarget = [ testTarget , classOutput(trainingQuantities(i)+1:end)' ];
end
maxLayerQuantity = 3;
maxHiddenQuantity = 20;
[ hidden , layers ] = meshgrid( 1 : maxHiddenQuantity , 1 : maxLayerQuantity );
meanQuantity = 10;
errors = zeros( maxLayerQuantity , maxHiddenQuantity , meanQuantity );
for d = 1 : meanQuantity
    for l = 1 : maxLayerQuantity
        for h = 1 : maxHiddenQuantity
            hiddenLayers = hidden(l,h) * ones( 1 , layers(l,h) );
            [ MSE , testOutput ] = getNetworkRMSE( hiddenLayers , trainingInput , trainingTarget , testInput , testTarget );
            errors(l,h,d) = MSE;
        end
    end
end
errors = mean(errors,3);
figureID = newFigure( figureID );
surf( layers , hidden , errors );
title( sprintf( 'MSE for Varying Layers and Hidden Neurons Averaged over %i Runs' , meanQuantity ) );
xlabel( 'Layer Quantity' );
ylabel( 'Hidden Neurons' );
zlabel( 'MSE' );

%% 4.2
[ minMSE , I ] = min(errors(:))
[ optLayerQuantity , optHiddenQuantity ] = ind2sub( [ maxLayerQuantity , maxHiddenQuantity ] , I(1) )
hiddenLayers = optHiddenQuantity * ones( 1 , optLayerQuantity );
testInput = [
    13.72 , 1.43 , 2.5 , 16.7 , 108 , 3.4 , 3.67 , 0.19 , 2.04 , 6.8 , 0.89 , 2.87 , 1285 ;
    12.04 , 4.3 , 2.38 , 22 , 80 , 2.1 , 1.75 , 0.42 , 1.35 , 2.6 , 0.79 , 2.57 , 580 ;
    14.13 , 4.1 , 2.74 , 24.5 , 96 , 2.05 , 0.76 , 0.56 , 1.35 , 9.2 , 0.61 , 1.6 , 560 ;
    ]';
testTarget = [ 0 , 0 , 0 ];
[ MSE , testOutput ] = getNetworkRMSE( hiddenLayers , trainingInput , trainingTarget , testInput , testTarget )
