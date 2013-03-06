figureID = 1;
% originalSheet = imread( dataPath( 'rotated/Bloom_Nobly_Cherry_Blossom_of_Sumizome__Border_of_Life_Piano_Version-3.png' ) );
originalSheet = imread( dataPath( 'ideal3.png' ) );

%% preprocessing
[ M , N , C ] = size(originalSheet);
channelledSheet = sum( originalSheet , 3 ) / C;
thresholdedSheet = channelledSheet - min(channelledSheet(:));
thresholdedSheet = ( thresholdedSheet - mean(thresholdedSheet(:)) );
workingSheet = thresholdedSheet;
% workingSheet = fixRotation( workingSheet , 0.01 );
[ M , N ] = size(workingSheet);

%% line detection
lines = findStaffLines( workingSheet , 'shortestPath' );
figureID = newFigure( figureID );
colormap gray;
imagesc( workingSheet <= 0 );
hold on;
for i = 1 : size(lines,1)
    plot( 1 : N , lines(i,:) , 'c--' , 'linewidth' , 2 );
end
hold off;
title( 'Line Detection Result' );
legend( 'Possible staff lines' , 'location' , 'best' );
return

%% line removal
features = removeStaffLines( workingSheet , lines , 'simple' );
figureID = newFigure( figureID );
colormap gray;
imagesc( features );
title( 'Line Removal Result' );
