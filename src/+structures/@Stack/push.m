function res = push( this , listNode )
    res = false;
    
    if this.limit < 1 || this.size < this.limit
        listNode.prevNode = this.top;
        this.top = listNode;
        this.size = this.size + 1;
        res = true;
    end
end
