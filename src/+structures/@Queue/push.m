function res = push( this , listNode )
    res = false;
    
    if this.limit < 1 || this.size < this.limit
        if this.size > 0
            this.back.nextNode = listNode;
            listNode.prevNode = this.back;
        else
            this.front = listNode;
        end
        
        this.back = listNode;
        this.size = this.size + 1;
        res = true;
    end
end
