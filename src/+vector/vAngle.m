function r = vAngle( a , b )
    import vector.*;
    tolerance = 0.000000001;
    dot = ( a * b' ) / vMag(a) / vMag(b);
    
    if abs( dot - 1 ) < tolerance
        dot = 1;
    elseif abs( dot + 1 ) < tolerance
        dot = -1;
    end
    
    r = acos( dot );
end
