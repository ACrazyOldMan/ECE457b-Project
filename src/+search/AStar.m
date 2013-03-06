function [ result , pathIDs , pathCost ] = AStar2( graph , goalID , heuristicFunc )
    import structures.GraphNode;
    
    N = graph.numNodes;
    root = graph.rootNode;
    goalNode = graph.nodeList( goalID );
    openCache = false(N,1);
    closedCache = false(N,1);
    moveCostCache = zeros(N,1);
    totalCostCache = zeros(N,1);
    routeCache( N ) = GraphNode;
    routeCache( root.id ) = root;
    openCache( root.id ) = true;
    
    %% While open set still contains items
    while true
        openIDs = find( openCache & ~closedCache );
        
        if isempty(openIDs)
            result = false;
            pathIDs = [];
            pathCost = 0;
            return;
        end
        
        [ minCost , indices ] = min( totalCostCache(openIDs) );
        id = openIDs(indices(1));
        
        if id == goalID
            result = true;
            pathCost = minCost;
            break;
        end
        
        curNode = graph.nodeList(id);
        
        if closedCache(id)
            continue;
        end
        
        curCost = moveCostCache(id);
        outCosts = curNode.outCosts;
        
        %% Check for any cost improvements
        for i = 1 : length(outCosts)
            outNode = curNode.outNodes(i);
            outCost = outCosts(i);
            moveCost = curCost + outCost + outNode.value;
            totalCost = moveCost + heuristicFunc( outNode , goalNode );
            outID = outNode.id;
            
            %% Add to open set if better and redirect optimal routes
            if ~openCache(outID) || moveCost < moveCostCache(outID)
                openCache(outID) = true;
                routeCache(outID) = curNode;
                moveCostCache(outID) = moveCost;
                totalCostCache(outID) = totalCost;
            end
        end
        
        closedCache(id) = true;
    end
    
    %% Backward traversal
    goal = routeCache(goalID);
    pathIDs = [ goalID ];
    
    while true
        if goal.id == root.id
            return;
        end
        
        pathIDs = [ goal.id ; pathIDs ];
        goal = routeCache(goal.id);
    end
end
