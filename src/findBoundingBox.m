function coords = findBoundingBox( features )
    % Brief: Finds smallest bounding box of image features
    %
    %     coords = findBoundingBox( features )
    %
    % Outputs:
    %     coords - Coordinates of smallest bounding box found.
    %              Format is a 2x2 matrix as follows: [ minRow , maxRow ; minColumn , maxColumn ]
    %
    % Inputs:
    %     features - Matrix of booleans representing feature locations where a value of 'true'
    %     corresponds to the location being part of a feature.
    
    %% Code
    [ I , J ] = ind2sub( size(features) , find(features) );
    coords = [ min(I) , max(I) ; min(J) , max(J) ];
end
