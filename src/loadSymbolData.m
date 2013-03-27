function [ inputs , targets ] = loadSymbolData( inputDir , symbolsToLoad )
    symbolPath = dataPath( 'symbols/' );
    inputPath = strcat( symbolPath , inputDir , '/' );
    inputDir = dir( inputPath );
    symbolTypes = ls( inputPath );
    symbolTypes = symbolTypes([inputDir.isdir],:);
    symbolTypes = symbolTypes( ~ismember( symbolTypes , { '.' , '..' } ) , : );
    if ~isempty(symbolsToLoad)
        symbolTypes = symbolTypes( symbolsToLoad , : );
    else
        symbolsToLoad = [ 1 : size(symbolTypes,1) ];
    end
    inputs = [];
    targets = [];
    
    %% For each type
    for i = 1 : size(symbolTypes,1)
        type = symbolTypes(i,:)
        inputTypePath = strcat( inputPath , type , '/' );
        typeDir = dir( inputTypePath );
        imageFiles = ls( inputTypePath );
        imageFiles = imageFiles(~[typeDir.isdir],:);
        
        %% For each image
        for j = 1 : size(imageFiles,1)
            fileName = imageFiles(j,:);
            inputFile = strcat( inputTypePath , fileName );
            inputImage = imread( inputFile );
            inputImage = imcomplement( inputImage );
            if size(inputImage,3) > 1
                inputImage = rgb2gray( inputImage );
            end
            inputs = [ inputs , reshape( inputImage , numel(inputImage) , 1 ) ];
            targets = [ targets , symbolsToLoad(i) ];
        end
    end
end
