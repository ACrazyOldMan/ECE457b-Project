function [ res , node ] = pop( this )
    res = false;
    node = 0;
    
    if this.size > 0
        node = this.front;
        this.front = node.nextNode;
        this.size = this.size - 1;
        res = true;
    end
end
