function addNode( this , binaryNode )
    if this.size == 0
        this.heap{1} = binaryNode;
    else
        pos = this.size + 1;
        this.heap{pos} = binaryNode;
        import tools.swap;
        
        while pos ~= 1
            pPos = floor(pos/2);
            parent = this.heap{pPos};
            
            if binaryNode.comparator < parent.comparator
                [ this.heap{pos} , this.heap{pPos} ] = swap( binaryNode , parent );
                pos = pPos;
            else
                break;
            end
        end
    end
    
    this.size = this.size + 1;
    this.root = this.heap{1};
end
