function [ res , graph ] = fromGrid2Directed( grid , root , isFull )
    % Create directed graph from 2D grid
    % If isFull is true, all neighbours are included in the graph, else only the
    % up, down, left, and right neighbours are considered
    res = false;
    graph = 0;
    [ m , n ] = size(grid);
    ri = root(1);
    rj = root(2);
    
    if ri > m || rj > n
        disp( 'Root coordinates not in grid!' );
        return;
    end
    
    import structures.Graph;
    import structures.GraphNode;
    import vector.vMag;
    
    nodeGrid(m,n) = GraphNode;
    
    for i = 1 : m
        for j = 1 : n
            id = Graph.idFromCoords( [m,n] , [i,j] );
            value = grid(i,j);
            nodeGrid(i,j) = GraphNode( id , value );
        end
    end
    
    for i = 1 : m
        for j = 1 : n
            node = nodeGrid(i,j);
            
            %% Set surrounding range
            iMin = i - 1;
            iMax = i + 1;
            jMin = j - 1;
            jMax = j + 1;
            
            %% Check limits
            if iMin < 1
                iMin = 1;
            end
            
            if iMax > m
                iMax = m;
            end
            
            if jMin < 1
                jMin = 1;
            end
            
            if jMax > n
                jMax = n;
            end
            
            %% Get coordinates of neighbours
            coords = combvec( [ iMin : 1 : iMax ] , [ jMin : 1 : jMax ] );
            
            if ~isFull
                I = find( coords(1,:) - i );
                J = find( coords(2,:) - j );
                int = intersect( I , J );
                coords = coords( : , [ setdiff( I , int ) , setdiff( J , int ) ] );
            end
            
            [ ~ , l ] = size(coords);
            coords = coords( : , sum( coords == ( [i;j] * ones(1,l) ) ) ~= 2 )';
            
            %% Connect neighbours to node
            [ l , ~ ] = size(coords);
            surrounding = nodeGrid( sub2ind( [m,n] , coords(:,1) , coords(:,2) ) )';
            nodeCosts = vMag( coords - ones(l,1) * [i,j] )';
            node.addInNodes( surrounding , nodeCosts );
            node.addOutNodes( surrounding , nodeCosts );
        end
    end
    
    graph = Graph( nodeGrid(ri,rj) , m * n , nodeGrid );
    res = true;
end
