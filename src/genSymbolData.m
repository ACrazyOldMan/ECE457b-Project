function genSymbolData( inputDir , outputQuantity , outputFormat , outputSize , outputDir , doRotation , doScaling , doTranslation )
    symbolPath = dataPath( 'symbols/' );
    inputPath = strcat( symbolPath , inputDir , '/' );
    outputPath = strcat( symbolPath , outputDir , '/' );
    inputDir = dir( inputPath );
    symbolTypes = ls( inputPath );
    symbolTypes = symbolTypes([inputDir.isdir],:);
    symbolTypes = symbolTypes( ~ismember( symbolTypes , { '.' , '..' } ) , : );
    
    %% For each type
    for i = 1 : size(symbolTypes,1)
        type = symbolTypes(i,:)
        inputTypePath = strcat( inputPath , type , '/' );
        typeDir = dir( inputTypePath );
        imageFiles = ls( inputTypePath );
        imageFiles = imageFiles(~[typeDir.isdir],:);
        outputTypePath = strcat( outputPath , type , '/' );
        if ~exist( outputTypePath , 'dir' )
            mkdir( outputTypePath );
        end
        
        %% For each image
        for j = 1 : size(imageFiles,1)
            fileName = imageFiles(j,:)
            inputFile = strcat( inputTypePath , fileName );
            inputImage = imread( inputFile );
            inputImage = imcomplement( inputImage );
            if size(inputImage,3) > 1
                inputImage = rgb2gray( inputImage );
            end
            
            %% Generate images
            for k = 1 : outputQuantity
                if doRotation && ~doScaling && ~doTranslation
                    [ transformed , imageName ] = applyRandomTransformation( inputImage , k , outputSize , doRotation , doScaling , doTranslation , k );
                else
                    [ transformed , imageName ] = applyRandomTransformation( inputImage , k , outputSize , doRotation , doScaling , doTranslation );
                end
                outputFile = strcat( outputTypePath , fileName , '-' , imageName , '.' , outputFormat );
                imwrite( transformed / range(transformed(:)) , outputFile , outputFormat );
            end
        end
    end
end
