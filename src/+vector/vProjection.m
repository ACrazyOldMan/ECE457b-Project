function p = vProjection( a , b )
    p = ( a * b' ) / ( b * b' ) * b;
end
