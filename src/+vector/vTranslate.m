function V = vTranslate( V , amount )
    % Translation of row vectors of "V" by rows in "amount"
    amount = amount';
    V = sum( [ repmat( eye(size(V,2)) , size(V,1) , 1 ) , amount(:) ] .* [ V( ceil( ( 1 : numel(V) ) / size(V,2) ) , : ) , ones( numel(V) , 1 ) ] , 2 );
    V = vec2mat( V , size(amount,1) );
end
