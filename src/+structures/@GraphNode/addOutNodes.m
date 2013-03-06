function addOutNodes( this , graphNodes , nodeCosts )
    this.outNodes = [ this.outNodes , graphNodes ];
    this.outCosts = [ this.outCosts , nodeCosts ];
    this.numOut = this.numOut + length(graphNodes);
end
