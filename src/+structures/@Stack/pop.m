function [ res , node ] = pop( this )
    res = false;
    node = 0;
    
    if this.size > 0
        node = this.top;
        this.top = node.prevNode;
        this.size = this.size - 1;
        res = true;
    end
end
