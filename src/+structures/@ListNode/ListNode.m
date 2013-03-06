classdef ListNode < handle & base.Debuggable
    %% Public Methods
    methods
        function this = ListNode( id , value )
            this.id = id;
            this.value = value;
        end
    end
    %% Public Properties
    properties
        prevNode;
        nextNode;
    end
    %% Private Properties
    properties ( SetAccess = private )
        id;
        value;
    end
end
