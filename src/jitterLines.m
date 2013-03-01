function lines = jitterLines( sheet , lines , limit )
    % Brief: Jitter found lines to have all line entries fall on feature pixels.
    %
    % Outputs:
    %     lines - Jittered lines.
    %
    % Inputs:
    %     sheet - Thresholded image data for sheet of music; entries > 0 considered features, <= 0 is background
    %     lines - Staff lines found through line detection.
    %     limit - Up/down jitter limit
    
    %% Code
    [ M , N ] = size(sheet);
    [ L , N ] = size(lines);
    offset = 1;
    hCoords = reshape( repmat( 1 : N , size(lines,1) , 1 ) , L * N , 1 );
    vCoords = reshape( lines , L * N , 1 );
    entries = sheet( sub2ind( [M,N] , vCoords , hCoords ) );
    featureless = entries <= 0;
    while sum(featureless) > 0
        vCoords(featureless) = vCoords(featureless) + offset;
        offset = -( offset + offset / abs(offset) );
        vCoords( vCoords < 1 ) = 1;
        vCoords( vCoords > M ) = M;
        entries = sheet( sub2ind( [M,N] , vCoords , hCoords ) );
        featureless = entries <= 0;
        if abs(offset/2) > limit
            vOriginal = reshape( lines , L * N , 1 );
            vCoords(featureless) = vOriginal(featureless);
            break;
        end
    end
    lines = reshape( vCoords , L , N );
end
