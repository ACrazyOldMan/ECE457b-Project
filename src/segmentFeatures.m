function featureList = segmentFeatures( bwImg , algorithm , varargin )
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
    %     bwImg - Binarized feature map resulting from preprocessing of sheet image; should be same
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
    % Insu's Personal Preference
    % set(0,'DefaultFigureWindowStyle','docked');

    % configurations
    % TODO: configs should have default that is overridable 
    % via optional input param
    MARGIN = 2;
    [ ImgWidth ImgHeight ] = size(bwImg);

    if strcmp( algorithm , 'fill' )
        bwImg = imfill(bwImg,'holes');
    end
    
    % Get Containing box of each features in the src bw image
    stats = regionprops(bwImg, 'BoundingBox');

    % project segmentations
    % figure();
    % clf;hold on;
    % imshow(~bwImg);

    % init return var
    featureList = {};
    
    for index=1:length(stats)
        box = stats(index).BoundingBox;
        % U: Upper Left
        % L: Length
        % R: row, C: col
        UC = max(1, box(1) - MARGIN);
        UR = max(1, box(2) - MARGIN);
        LC = min(ImgWidth, box(3) + MARGIN * 2);
        LR = min(ImgHeight, box(4) + MARGIN * 2);
        % [UC UR LC LR]
        if LC + LR > 5
            % Draw cropping boxes
            rectangle('Position', [UC UR LC LR]);
            % Extract Feature
            feature = imcrop(bwImg,[UC UR LC LR]); 
            feature = ~imclearborder(feature);
            featureList{index} = feature;
            % Crop image and save
            imwrite( feature, strcat( sprintf('%03d', index),'.png' ), 'png');
        end
    end

    % hold off;
end
