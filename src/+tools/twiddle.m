function [ minError , params ] = twiddle( errorFunc , params , dParams , tolerance , incFactor , decFactor , progressFunc , varargin )
    if length(varargin) == 1
        args = [ { params } , varargin ];
    else
        args = [ { params } , varargin{:} ];
    end
    minError = errorFunc( args{:} );
    
    while sum( abs(dParams) ) > tolerance
        for i = 1 : length( dParams )
            params(i) = params(i) + dParams(i);
            args{1} = params;
            error = errorFunc( args{:} );
            
            if error < minError
                minError = error;
                dParams(i) = dParams(i) * incFactor;
            else
                params(i) = params(i) - 2 * dParams(i);
                args{1} = params;
                error = errorFunc( args{:} );
                
                if error < minError
                    minError = error;
                    dParams(i) = dParams(i) * incFactor;
                else
                    params(i) = params(i) + dParams(i);
                    dParams(i) = dParams(i) * decFactor;
                end
            end
        end
        
        progressFunc( minError , params , dParams );
    end
end
