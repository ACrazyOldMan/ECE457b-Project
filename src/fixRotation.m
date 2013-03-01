function rotatedSheet = fixRotation( sheet , tolerance )
    % Brief: Fix rotation of sheet using gradient descent to have staff lines horizontally aligned.
    %
    %     rotatedSheet = fixRotation( sheet , tolerance )
    %
    % Outputs:
    %     rotatedSheet - Rotated sheet with horiaontally aligned staff lines.
    %
    % Inputs:
    %     sheet - Thresholded image data for sheet of music; entries > 0 considered features, <= 0 is background
    %     tolerance - Error tolerance for resultant rotation angle.
    
    %% Code
    degrees = 0;
    incFactor = 1.1;
    decFactor = 0.9;
    dDegrees = 1;
    [ minErrorCCW , degreesCCW ] = twiddle( @errorFunc , degrees , dDegrees , tolerance , incFactor , decFactor , @progressFunc , sheet );
    dDegrees = -1;
    [ minErrorCW , degreesCW ] = twiddle( @errorFunc , degrees , dDegrees , tolerance , incFactor , decFactor , @progressFunc , sheet );
    if minErrorCCW < minErrorCW
        rotatedSheet = imrotate( sheet , degreesCCW );
    else
        rotatedSheet = imrotate( sheet , degreesCW );
    end
end

%% Error function for gradient descent
function error = errorFunc( degrees , sheet )
    rotated = imrotate( sheet , degrees );
    features = rotated > 0;
    projH = sum(features,2);
    error = -sum( projH .^ 2 );
end

%% Progress function for gradient descent
function progressFunc( minError , degrees , dDegrees )
    disp( sprintf( '%i , %i , %i' , minError , degrees , dDegrees ) );
end
