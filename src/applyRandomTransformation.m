function [ transformed , imageName ] = applyRandomTransformation( image , id , desiredSize , doRotation , doScaling , doTranslation , varargin )
    [ M , N ] = size(image);
    dN = desiredSize(1);
    dM = desiredSize(2);
    prefix = '';
    
    %% Rotation
    if doRotation
        prefix = strcat( prefix , 'r' );
        
        if nargin > 6
            transformed = imrotate( image , varargin{1} , 'bilinear' , 'loose' );
        else
            transformed = imrotate( image , rand * 360 , 'bilinear' , 'loose' );
        end
        
        box = findBoundingBox( transformed > mean(transformed(:)) );
        transformed = transformed( box(1,1) : box(1,2) , box(2,1) : box(2,2) );
    end
    
    %% Scaling
    if doScaling
        prefix = strcat( prefix , 's' );
        
        if ~doRotation
            box = findBoundingBox( image > mean(image(:)) );
            transformed = image( box(1,1) : box(1,2) , box(2,1) : box(2,2) );
        end
        
        transformed = imresize( transformed , rand + 0.5 , 'bilinear' );
    end
    
    %% Translation
    if doTranslation
        prefix = strcat( prefix , 't' );
        
        if ~doRotation && ~doScaling
            box = findBoundingBox( image > mean(image(:)) );
            transformed = image( box(1,1) : box(1,2) , box(2,1) : box(2,2) );
        end
        
        [ tM , tN ] = size(transformed);
        rM = ceil( tN * dM / dN );
        
        if tM <= dM && tN <= dN
            bg = zeros(dM,dN);
            i = ceil( rand * ( dM - tM + 1 ) );
            j = ceil( rand * ( dN - tN + 1 ) );
            bg( i : i + tM - 1 , j : j + tN - 1 ) = transformed;
            transformed = bg;
        else
            if tM < rM
                bg = zeros(rM,tN);
                i = ceil( rand * ( size(bg,1) - tM + 1 ) );
                j = 1;
            else
                bg = zeros( tM , ceil( tM * dN / dM ) );
                i = 1;
                j = ceil( rand * ( size(bg,2) - tN + 1 ) );
            end
            
            bg( i : i + tM - 1 , j : j + tN - 1 ) = transformed;
            transformed = imresize( bg , dM / size(bg,1) , 'bilinear' );
        end
    end
    
    %% Fix size
    if ~all( size(transformed) == desiredSize )
        [ tM , tN ] = size(transformed);
        rM = ceil( tN * dM / dN );
        
        if tM <= dM && tN <= dN
            bg = zeros(dM,dN);
            i = ceil( 0.5 * ( dM - tM + 1 ) );
            j = ceil( 0.5 * ( dN - tN + 1 ) );
            bg( i : i + tM - 1 , j : j + tN - 1 ) = transformed;
            transformed = bg;
        else
            if tM < rM
                bg = zeros(rM,tN);
                i = ceil( 0.5 * ( size(bg,1) - tM + 1 ) );
                j = 1;
            else
                bg = zeros( tM , ceil( tM * dN / dM ) );
                i = 1;
                j = ceil( 0.5 * ( size(bg,2) - tN + 1 ) );
            end
            
            bg( i : i + tM - 1 , j : j + tN - 1 ) = transformed;
            transformed = imresize( bg , dM / size(bg,1) , 'bilinear' );
        end
    end
    
    imageName = strcat( prefix , sprintf( '%i' , id ) );
end
