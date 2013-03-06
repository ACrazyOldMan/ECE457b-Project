classdef Queue < handle & base.Debuggable
    %% Public Methods
    methods
        function this = Queue( limit )
            if nargin > 0
                this.limit = limit;
            end
        end
        
        res = push( this , listNode );
        [ res , node ] = pop( this );
    end
    %% Private Properties
    properties ( SetAccess = private )
        limit = 0;
        size = 0;
        front = 0;
        back = 0;
    end
end
