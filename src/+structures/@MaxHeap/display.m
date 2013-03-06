function display( this , pos )
    tol = 0.001;
    s = '';
    
    for i = pos : this.size
        node = this.heap{i};
        
        if abs(mod(log2(i),1)) < tol
            disp(s);
            s = sprintf( '%5.2f' , node.id );
        else
            s = strcat( s , sprintf( ' , %5.2f' , node.id ) );
        end
    end
    
    disp(s);
end
