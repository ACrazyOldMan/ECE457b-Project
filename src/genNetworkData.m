%% generate random training data for each symbol type
inputDir = 'original';
outputQuantity = 100;
outputFormat = 'png';
outputSize = [ 32 , 32 ];
outputDir = 'training';
doRotation = true;
doScaling = true;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% generate random test data for each symbol type
inputDir = 'original';
outputQuantity = 100;
outputFormat = 'png';
outputSize = [ 32 , 32 ];
outputDir = 'test';
doRotation = true;
doScaling = true;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );
