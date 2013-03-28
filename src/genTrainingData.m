%% rotation
inputDir = 'original';
outputQuantity = 360;
outputFormat = 'png';
outputSize = [ 32 , 32 ];
outputDir = 'training';
doRotation = true;
doScaling = false;
doTranslation = false;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% scaling
outputQuantity = 50;
doRotation = false;
doScaling = true;
doTranslation = false;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% translation
outputQuantity = 50;
doRotation = false;
doScaling = false;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% rotation/scaling
outputQuantity = 200;
doRotation = true;
doScaling = true;
doTranslation = false;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% rotation/translation
outputQuantity = 200;
doRotation = true;
doScaling = false;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% scaling/translation
outputQuantity = 100;
doRotation = false;
doScaling = true;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );

%% rotation/scaling/translation
outputQuantity = 500;
doRotation = true;
doScaling = true;
doTranslation = true;
genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation );
