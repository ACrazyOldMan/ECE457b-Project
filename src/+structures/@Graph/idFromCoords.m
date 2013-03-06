function id = idFromCoords( gridSize , coords )
    id = sub2ind( gridSize , coords(1) , coords(2) );
end
