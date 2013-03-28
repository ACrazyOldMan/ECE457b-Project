function ksomWeights = createDataKSOM( data , clusterQuantity , changeThreshold , ksomFile )
    %% Code
    if exist( ksomFile , 'file' )
        ksomWeights = load( ksomFile );
    else
        initialWeights = ones( size(data,1) , clusterQuantity );
        initialParams = 1;
        epochQuantity = 0;
        ksomWeights = simulateKSOM( initialWeights , initialParams , @errorFunc , @weightUpdateFunc , @paramUpdateFunc , data , epochQuantity , changeThreshold , @weightChangeFunc )';
        save( ksomFile , '-ascii' , '-double' , 'ksomWeights' );
    end
end

%% errorFunc
function errors = errorFunc( weights , data )
    errors = sum( ( weights - repmat( data , 1 , size(weights,2) ) ) .^ 2 );
end

%% weightUpdateFunc
function weights = weightUpdateFunc( weights , data , params , index )
    weights(:,index) = weights(:,index) + params * ( data - weights(:,index) );
end

%% paramUpdateFunc
function params = paramUpdateFunc( params , k )
    params = 0.9 * params;
end

%% weightChangeFunc
function change = weightChangeFunc( newWeights , oldWeights )
    change = sum( sum( abs( newWeights - oldWeights ) ) );
end
