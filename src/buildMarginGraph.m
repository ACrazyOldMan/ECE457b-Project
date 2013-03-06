function graph = buildMarginGraph( costGrid , rootCoords )
    [ M , N ] = size(costGrid);
    ri = rootCoords(1);
    rj = rootCoords(2);
    
    if ri > M || rj > N
        error( 'Root coordinates not in grid!' );
    end
    
    import structures.Graph;
    import structures.GraphNode;
    import vector.vMag;
    
    nodeGrid(M,N) = GraphNode;
    
    for i = 1 : M
        for j = 1 : N
            id = Graph.idFromCoords( [M,N] , [i,j] );
            value = costGrid(i,j);
            nodeGrid(i,j) = GraphNode( id , value );
        end
    end
    
    for i = 1 : M
        for j = 1 : N - 1
            node = nodeGrid(i,j);
            
            %% Set surrounding range
            %             r = ceil(M/6);
            r = 1;
            iMin = i - r;
            iMax = i + r;
            jMin = j + 1;
            jMax = jMin;
            
            %% Check limits
            if iMin < 1
                iMin = 1;
            end
            
            if iMax > M
                iMax = M;
            end
            
            %% Get coordinates of neighbours
            coords = combvec( [ iMin : 1 : iMax ] , [ jMin : 1 : jMax ] );
            l = size(coords,2);
            coords = coords( : , sum( coords == ( [i;j] * ones(1,l) ) ) ~= 2 )';
            
            %% Connect neighbours to node
            l = size(coords,1);
            surrounding = nodeGrid( sub2ind( [M,N] , coords(:,1) , coords(:,2) ) )';
            nodeCosts = vMag( coords - ones(l,1) * [i,j] )';
            node.addOutNodes( surrounding , nodeCosts );
        end
    end
    
    graph = Graph( nodeGrid(ri,rj) , nodeGrid(:) );
end
