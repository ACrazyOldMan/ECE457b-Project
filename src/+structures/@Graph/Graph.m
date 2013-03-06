classdef Graph < handle & base.Debuggable
    %% Static Public Methods
    methods ( Static )
        id = idFromCoords( gridSize , coords );
        coords = coordsFromID( gridSize , id );
        [ res , graph ] = fromGrid2Directed( grid , root , isFull );
    end
    %% Public Methods
    methods
        function this = Graph( rootNode , nodeList )
            this.rootNode = rootNode;
            this.nodeList = nodeList;
            this.numNodes = length(nodeList);
        end
        
        setRoot( this , rootNode );
    end
    %% Private Properties
    properties ( SetAccess = private )
        rootNode;
        nodeList;
        numNodes = 0;
    end
end
