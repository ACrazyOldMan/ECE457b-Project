%% generate random test data for each symbol type
inputDir = 'original';
outputQuantity = 100;
outputFormat = 'png';
outputSize = [ 64 , 64 ];
outputDir = 'test';
doRotation = true;
doScaling = true;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );
