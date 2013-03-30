function featureList = segmentFeatures( binarySheet , algorithm , varargin )
    % Brief: Segments and extracts features from the provided binarized feature map.
    %
    %     featureList = segmentFeatures( features , algorithm , ... )
    %
    % Outputs:
    %     featureList - List of extracted features formatted as a cell array; each row contains
    %     information for a single feature; first column provides the bounding box while the second
    %     provides a feature pixels map same size as bounding box.
    %
    % Inputs:
    %     binarySheet - Binarized feature map resulting from preprocessing of sheet image; should be same
    %     size as sheet image data; true values indicate feature pixels.
    %     algorithm - String defining detection algorithm to be used; more details below.
    %
    % NOTES:
    %     - Additional parameters for specific algorithms can be appended at the end.
    %
    % Valid options for algorithm and their parameters are provided below:
    %
    %     fill: Finds connected feature pixels using fill and extracts them as segments.
    
    %% Code
    featureList = {};
    
    if strcmp( algorithm , 'fill' )
        %% fill
        features = ~binarySheet;
        count = 1;
        while ~all(features(:))
            indices = find(~features);
            filled = imfill( features , indices(1) , 8 );
            featureMap = filled ~= features;
            box = findBoundingBox(featureMap);
            featureMap = featureMap( box(1,1):box(1,2) , box(2,1):box(2,2) );
            featureList{count,1} = box;
            featureList{count,2} = featureMap;
            count = count + 1;
            features = filled;
        end
    elseif strcmp( algorithm , 'default' )
        %% default
        margin = 2;
        [ imgWidth , imgHeight ] = size(binarySheet);
        
        % Get Containing box of each features in the src bw image
        stats = regionprops( binarySheet , 'BoundingBox' );
        
        for index = 1 : length(stats)
            box = stats(index).BoundingBox;
            % U: Upper Left, L: Length
            % R: row,        C: col
            UC = max(1, box(1) - margin);
            UR = max(1, box(2) - margin);
            LC = min(imgWidth, box(3) + margin * 2);
            LR = min(imgHeight, box(4) + margin * 2);
            if LC + LR > 5 % ignore small features
                % Extract Feature
                feature = imcrop( binarySheet , [UC,UR,LC,LR] );
                feature = ~imclearborder(feature);
                featureList{index,1} = [ UR , UR + LR - 1 ; UC , UC + LC - 1 ];
                featureList{index,2} = feature;
            end
        end
    else
        %% error
        error( 'Invalid algorithm specified' );
    end
end
