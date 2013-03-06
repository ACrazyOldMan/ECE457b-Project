classdef GraphNode < handle & base.Debuggable
    %% Public Methods
    methods
        function this = GraphNode( id , value , inNodes , outNodes )
            if nargin > 0
                this.id = id;
                this.value = value;
                
                if nargin > 2
                    this.inNodes = inNodes;
                    this.outNodes = outNodes;
                    this.numIn = length(inNodes);
                    this.numOut = length(outNodes);
                end
            end
        end
        
        addInNodes( this , graphNodes , nodeCosts );
        addOutNodes( this , graphNodes , nodeCosts );
    end
    %% Private Properties
    properties ( SetAccess = private )
        id = 0;
        value = 0;
        numIn = 0;
        numOut = 0;
        inNodes = [];
        outNodes = [];
        inCosts = [];
        outCosts = [];
    end
end
