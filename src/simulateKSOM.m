function updatedWeights = simulateKSOM( initialWeights , initialParams , errorFunc , weightUpdateFunc , paramUpdateFunc , trainingData , epochQuantity , varargin )
    %% Code
    updatedWeights = initialWeights;
    params = initialParams;
    N = size(trainingData,2);
    k = 1;
    if epochQuantity == 0
        changeThreshold = varargin{1};
        weightChangeFunc = varargin{2};
        totalChange = 0;
    end
    
    %% Loop
    while true
        for n = 1 : N
            tData = trainingData(:,n);
            errors = errorFunc( updatedWeights , tData );
            [ minError , index ] = min(errors);
            newWeights = weightUpdateFunc( updatedWeights , tData , params , index );
            if epochQuantity == 0
                totalChange = totalChange + weightChangeFunc( newWeights , updatedWeights );
            end
            updatedWeights = newWeights;
        end
        
        if epochQuantity == 0
            if totalChange < changeThreshold
                break;
            end
            totalChange = 0;
        else
            if k == epochQuantity
                break;
            end
        end
        
        params = paramUpdateFunc( params , k );
        k = k + 1;
    end
end
