classdef BinaryNode < handle & base.Debuggable
    %% Public Methods
    methods
        function this = BinaryNode( id , value , comparator )
            if nargin > 0
                this.id = id;
                this.value = value;
                this.comparator = comparator;
            end
        end
        
        function setParent( this , binaryNode )
            this.parent = binaryNode;
            this.hasParent = true;
        end
        
        function setLeft( this , binaryNode )
            this.leftChild = binaryNode;
            this.hasLeft = true;
        end
        
        function setRight( this , binaryNode )
            this.rightChild = binaryNode;
            this.hasRight = true;
        end
        
        function node = removeParent( this )
            node = this.parent;
            this.parent = 0;
            this.hasParent = false;
        end
        
        function node = removeLeft( this )
            node = this.leftChild;
            this.leftChild = 0;
            this.hasLeft = false;
        end
        
        function node = removeRight( this )
            node = this.rightChild;
            this.rightChild = 0;
            this.hasRight = false;
        end
    end
    %% Private Properties
    properties ( SetAccess = private )
        id;
        value;
        comparator;
        parent;
        leftChild;
        rightChild;
        hasParent = false;
        hasLeft = false;
        hasRight= false;
    end
end
