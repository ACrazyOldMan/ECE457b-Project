function n = vNormal2( v , onRight )
    tol = 0.000000000000001;
    x1 = v(1);
    y1 = v(2);
    
    if abs( x1 ) < tol
        x2 = 1;
        y2 = -x1 / y1;
    else
        y2 = 1;
        x2 = -y1 / x1;
    end
    
    n = [ x2 , y2 ];
    cp = cross( [ n , 0 ] , [ v , 0 ] );
    z = cp(3);
    
    if onRight
        if z < 0
            n = -n;
        end
    elseif z > 0
        n = -n;
    end
end
