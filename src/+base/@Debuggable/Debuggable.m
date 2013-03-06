classdef Debuggable < handle
    %% Public methods
    methods
        function this = Debuggable()
        end
        
        function startDebugging( this )
            this.DEBUGGING = true;
        end
        
        function stopDebugging( this )
            this.DEBUGGING = false;
        end
    end
    %% Protected properties
    properties ( SetAccess = protected )
        DEBUGGING = false;
    end
end
