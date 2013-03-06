function display( this , pos , showComparator )
    disp( '----------' );
    tol = 0.001;
    s = '';
    
    for i = pos : this.size
        node = this.heap{i};
        
        if showComparator
            show = node.comparator;
        else
            show = node.id;
        end
        
        if abs(mod(log2(i),1)) < tol
            disp(s);
            s = sprintf( '%5.2f' , show );
        else
            s = strcat( s , sprintf( ' , %5.2f' , show ) );
        end
    end
    
    disp(s);
end
