function foundLines = findStaffLines( sheet , algorithm , varargin )
    % Brief: Determines vertical positions of staff lines for given sheet of music using specified algorithm.
    %
    %     foundLines = findStaffLines( sheet , algorithm , ... )
    %
    % Outputs:
    %     foundLines - Each row of represents a found staff line and is a 1 by N vector, where N is the
    %     number of columns of the sheet image data (ie. width of sheet in pixels), that contain
    %     vertical positions of each line corresponding to each horizontal position (ie. vector of y
    %     values for each x value represented by index into vector) with respect to top of sheet.
    %
    % Inputs:
    %     sheet - Thresholded image data for sheet of music; entries > 0 considered features, <= 0 is background
    %     algorithm - String defining detection algorithm to be used; more details below.
    %
    % NOTES:
    %     - Additional parameters for specific algorithms can be appended at the end.
    %
    % Valid options for algorithm and their parameters are provided below:
    %
    %     simple: Horizontal projection followed by local peak detection.
    %     shortestPath: Shortest paths from left to right side preferring feature pixels.
    
    %% Code
    [ M , N ] = size(sheet);
    
    if strcmp( algorithm , 'simple' )
        %% simple
        features = sheet > 0;
        projH = sum(features,2);
        [ sorted , rows ] = sort(projH);
        gaps = sorted(2:end) - sorted(1:end-1);
        [ maxGap , index ] = max(gaps);
        threshold = projH( rows(index) );
        projH = projH .* ( projH > threshold );
        dLeft = projH(2:end-1) - projH(1:end-2);
        dRight = projH(2:end-1) - projH(3:end);
        peaks = ( dLeft > 0 ) & ( dRight > 0 );
        lines = find( peaks ) + 1;
        foundLines = repmat( lines , 1 , N );
    elseif strcmp( algorithm , 'shortestPath' )
        %% shortestPath
        features = sheet > 0;
        rows = [1:M]';
        foundLines = [ rows , zeros(M,N-1) ];
        import structures.Graph;
        import search.AStar;
        costGrid = ~features * N^2;
        rootCoords = [1,1];
        graph = buildMarginGraph( costGrid , rootCoords );
        disp( 'Graph built' );
        nodeCoords = Graph.coordsFromID( [M,N] , [1:length(graph.nodeList)]' );
        heuristicFunc = @( outNode , goalNode ) sqrt( sum( ( nodeCoords(outNode.id,:) - nodeCoords(goalNode.id,:) ) .^ 2 ) );
        for i = 1 : length(rows)
            r = rows(i)
            graph.setRoot( graph.nodeList( Graph.idFromCoords( [M,N] , [r,1] ) ) );
            goalID = Graph.idFromCoords( [M,N] , [r,N] );
            [ res , path ] = AStar( graph , goalID , heuristicFunc );
            if res
                coords = Graph.coordsFromID( [M,N] , path );
                foundLines(i,2:N) = coords(:,1);
            end
        end
    else
        %% error
        error( 'Invalid algorithm specified' );
    end
end
