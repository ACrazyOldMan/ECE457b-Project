figureID = 1;

%% Test for radial basis network classification
% relative to '../data/symbols'
symbolDir = '';
trainingDir = strcat( symbolDir , 'training' );
testDir = strcat( symbolDir , 'test' );
% list of indices of symbols to load such as whole notes; use empty list for all types: []
% these do not necessarily correspond to the indices of the folders since MatLab sorts string by
% ASCII, but 'loadSymbolData' will output the types loaded in console
symbolsToLoad = [1,2] % ,12,16,17,20,21,22]

%% Load data
disp( 'Loading training data...' );
[ trainingInput , trainingTarget ] = loadSymbolData( trainingDir , symbolsToLoad );
disp( 'Loading test data...' );
[ testInput , testTarget ] = loadSymbolData( testDir , symbolsToLoad );
% normalize inputs
trainingInput = double(trainingInput) / double(max(trainingInput(:)));
testInput = double(testInput) / double(max(testInput(:)));

%% Reduce dimensionality of inputs
disp( 'Reducing dimensionality...' );
desiredDim = 100 % new dimensionality; increase for higher accuracy, decrease for faster RBFN training
reductionAlgorithm = 'pca'
tic
if strcmp( reductionAlgorithm , 'ksom' )
    changeThreshold = 0.001;
    ksomFile = 'ksomWeights'; % filename for caching of KSOM weights; delete to recalculate weights
    delete(ksomFile);
    newInput = reduceDimensionality( { trainingInput , testInput } , desiredDim , reductionAlgorithm , changeThreshold , ksomFile );
elseif strcmp( reductionAlgorithm , 'pca' )
    newInput = reduceDimensionality( { trainingInput , testInput } , desiredDim , reductionAlgorithm );
end
toc
trainingInput = newInput{1};
testInput = newInput{2};

%% Simulate various network parameters and get MSE
disp( 'Finding best RBFN...' );
sigmaList = [ 1 : 1 : 10 ]; % list of sigma values to test
hiddenList = [ 100 : 100 : 1000 ]; % list of hidden quantities to test
sigmaListQuantity = length(sigmaList);
hiddenListQuantity = length(hiddenList);
meanQuantity = 1; % number of runs to average MSE over
[ hiddens , sigmas ] = meshgrid( hiddenList , sigmaList );
errors = zeros( hiddenListQuantity , sigmaListQuantity , meanQuantity );
tic
for s = 1 : sigmaListQuantity
    for h = 1 : hiddenListQuantity
        sigma = sigmas(s,h)
        maxHiddenQuantity = hiddens(s,h)
        % change 'parfor' to 'for' if an error occurs; 'parfor' is used with MatLab's Parallel
        % Computing Toolbox after executing 'matlabpool' to speed up processing
        parfor run = 1 : meanQuantity
            MSE = simulateRBFN( trainingInput , trainingTarget , testInput , testTarget , sigma , maxHiddenQuantity );
            errors(h,s,run) = sum(MSE);
        end
    end
end
toc

%% Plot results
errors = mean(errors,3);
errorFile = sprintf( 'RBFN-%s-%i-errors.txt' , reductionAlgorithm , length(symbolsToLoad) );
save( errorFile , '-ascii' , 'errors' );
figureID = newFigure( figureID );
surf( sigmas , hiddens , errors );
title( sprintf( 'MSE for Varying Sigma Valuse and Max Hidden Neuron Quantities Averaged over %i Run(s)' , meanQuantity ) );
xlabel( 'Sigma' );
ylabel( 'Hidden Neuron Quantity' );
zlabel( 'MSE' );

%% Find optimal parameters and test
tic
[ minMSE , I ] = min(errors(:))
[ optHidden , optSigma ] = ind2sub( [ hiddenListQuantity , sigmaListQuantity ] , I(1) )
optParams = [ hiddenList(optHidden) , sigmaList(optSigma) ]
optFile = sprintf( 'RBFN-%s-%i-optParams.txt' , reductionAlgorithm , length(symbolsToLoad) );
save( optFile , '-ascii' , 'optParams' );
hiddenLayers = optHidden * ones( 1 , optSigma );
[ MSE , testOutput , trainingOutput , net ] = simulateRBFN( trainingInput , trainingTarget , testInput , testTarget , optSigma , optHidden );
MSE
netFile = sprintf( 'RBFN-%s-%i-net' , reductionAlgorithm , length(symbolsToLoad) );
save( netFile , 'net' );
toc
