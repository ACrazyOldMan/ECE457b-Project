function [ res , int , t ] = vIntersection2( p1 , v1 , p2 , v2 )
    tol = 0.000000001;
    res = false;
    int = 0;
    t = 0;
    x1 = p1(1);
    y1 = p1(2);
    a1 = v1(1);
    b1 = v1(2);
    x2 = p2(1);
    y2 = p2(2);
    a2 = v2(1);
    b2 = v2(2);
    d = a1 * b2 - a2 * b1;
    
    if abs( d ) < tol
        return;
    end
    
    t = ( a1 * ( y1 - y2 ) + b1 * ( x2 - x1 ) ) / d ;
    int = p2 + v2 * t;
    res = true;
end
