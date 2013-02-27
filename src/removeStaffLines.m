function features = removeStaffLines( sheet , lines , algorithm , argin )
    % Brief: Removes provided staff lines from sheet music data and returns matrix of remaining features.
    %
    %     features = removeStaffLines( sheet , lines , algorithm , ... )
    %
    % Outputs:
    % features - Matrix of boolean values (same size as sheet) representing remaining features after
    % line removal; true entries indicate presence of features while false otherwise.
    %
    % Inputs:
    %     sheet - Image data for sheet of music; assumed to be black and white (ie. single channel image).
    %     lines - Detected staff lines; each row corresponds to a single line.
    %     algorithm - String defining detection algorithm to be used; more details below.
    %
    % Valid options for algorithm and their parameters are provided below:
    %
    %     simple: Simplest method of staff line removal using up/down template matching.
    [ M , N ] = size(sheet);
    
    if strcmp( algorithm , 'simple' )
        %% simple
        height = 1;
        features = sheet > 0;
        for i = 1 : size(lines,1)
            line = lines(i,:);
            for j = 1 : N
                y = line(j);
                if features(y,j)
                    indices = y - height : y + height;
                    indices = indices( indices >= 1 );
                    indices = indices( indices <= M );
                    average = mean( sheet(indices,j) );
                    features(y,j) = average > 0;
                end
            end
        end
    else
        %% error
        error( 'Invalid algorithm specified' );
    end
end
