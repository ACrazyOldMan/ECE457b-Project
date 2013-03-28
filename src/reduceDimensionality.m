function newData = reduceDimensionality( data , desiredDim , algorithm , varargin )
    %% Code
    if strcmp( algorithm , 'ksom' )
        changeThreshold = varargin{1};
        ksomFile = varargin{2};
        ksomWeights = createDataKSOM( [data{:}] , desiredDim , changeThreshold , ksomFile );
        newData = cell(1,length(data));
        for i = 1 : length(data)
            newData{i} = ksomWeights * data{i};
        end
    end
end
