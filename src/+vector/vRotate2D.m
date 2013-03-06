function V = vRotate2D( V , rads )
    % Two dimensional rotation of row vectors in "V" along x-y plane by radians
    R = [ cos(rads) , -sin(rads) ; sin(rads) , cos(rads) ];
    V = sum( repmat( R , size(V,1) , 1 ) .* V( ceil( ( 1 : numel(V) ) / size(V,2) ) , : ) , 2 );
    V = vec2mat( V , 2 );
end
