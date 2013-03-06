function node = removeNode( this , pos )
    if nargin == 0
        pos = 1;
    end
    
    node = this.heap{pos};
    this.heap{pos} = this.heap{this.size};
    this.size = this.size - 1;
    import tools.swap;
    
    while pos < this.size
        current = this.heap{pos};
        left = pos * 2;
        
        if left <= this.size
            leftChild = this.heap{left};
            right = pos * 2 + 1;
            
            if right <= this.size
                rightChild = this.heap{right};
                
                if leftChild.comparator > rightChild.comparator
                    if current.comparator < leftChild.comparator
                        [ this.heap{pos} , this.heap{left} ] = swap( current , leftChild );
                        pos = left;
                    else
                        break;
                    end
                elseif current.comparator < rightChild.comparator
                    [ this.heap{pos} , this.heap{right} ] = swap( current , rightChild );
                    pos = right;
                else
                    break;
                end
            elseif current.comparator < leftChild.comparator
                [ this.heap{pos} , this.heap{left} ] = swap( current , leftChild );
                pos = left;
            else
                break;
            end
        else
            break;
        end
    end
end
