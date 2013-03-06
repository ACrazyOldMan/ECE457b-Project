classdef MaxHeap < handle & base.Debuggable
    %% Public Methods
    methods
        function this = MaxHeap()
        end
        
        addNode( this , binaryNode );
        node = removeNode( this , pos );
        display( this , pos );
    end
    %% Private Properties
    properties ( SetAccess = private )
        size = 0;
        root;
        heap = {};
    end
end
