classdef MinHeap < handle & base.Debuggable
    %% Public Methods
    methods
        function this = MinHeap()
        end
        
        addNode( this , binaryNode );
        node = removeNode( this , pos );
        display( this , pos , showComparator );
    end
    %% Private Properties
    properties ( SetAccess = private )
        size = 0;
        root;
        heap = {};
    end
end
