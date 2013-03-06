classdef Stack < handle & base.Debuggable
    %% Public Methods
    methods
        function this = Stack( limit )
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
        top = 0;
    end
end
