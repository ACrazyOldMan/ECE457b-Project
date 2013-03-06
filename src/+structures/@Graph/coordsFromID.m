function coords = coordsFromID( gridSize , id )
    [ I , J ] = ind2sub( gridSize , id );
    coords = [ I , J ];
end
