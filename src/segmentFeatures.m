function featureList = segmentFeatures( features , algorithm , varargin )
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
    %     features - Binarized feature map resulting from preprocessing of sheet image; should be same
    %     size as sheet image data.
    %     algorithm - String defining detection algorithm to be used; more details below.
    %
    % NOTES:
    %     - Additional parameters for specific algorithms can be appended at the end.
    %
    % Valid options for algorithm and their parameters are provided below:
    %
    %     fill: Finds connected feature pixels using paint fill and extracts them as segments.
    
    %% Code
    if strcmp( algorithm , 'fill' )
    end
end
