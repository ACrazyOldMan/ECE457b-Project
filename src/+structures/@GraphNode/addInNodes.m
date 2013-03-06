function addInNodes( this , graphNodes , nodeCosts )
    this.inNodes = [ this.inNodes , graphNodes ];
    this.inCosts = [ this.inCosts , nodeCosts ];
    this.numIn = this.numIn + length(graphNodes);
end
