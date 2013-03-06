function mag = vMag( V )
    % returns magnitudes of all row vectors in matrix V
    mag = sqrt( sum( V .* V , 2 ) );
end
