function newData = reduceDimensionality( data , desiredDim , algorithm , varargin )
    %% Code
    if strcmp( algorithm , 'ksom' )
        %% ksom
        changeThreshold = varargin{1};
        ksomFile = varargin{2};
        ksomWeights = createDataKSOM( [data{:}] , desiredDim , changeThreshold , ksomFile );
        newData = cell(1,length(data));
        for i = 1 : length(data)
            newData{i} = ksomWeights * data{i};
        end
    elseif strcmp( algorithm , 'pca' )
        %% pca
        pcaFile = varargin{1};
        X = [data{:}];
        X = X - repmat( mean(X,2) , 1 , size(X,2) );
        C = X * X';
        [ U , S , V ] = svd(C);
        W = double( U(:,1:desiredDim)' );
        save( pcaFile , '-ascii' , '-double' , 'W' );
        newData = cell(1,length(data));
        for i = 1 : length(data)
            newData{i} = W * data{i};
        end
    else
        %% error
        error( 'Invalid algorithm specified' );
    end
end
