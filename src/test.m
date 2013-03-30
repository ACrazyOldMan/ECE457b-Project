figureID = 1;
% originalSheet = imread( dataPath( 'optimal/Bloom_Nobly_Cherry_Blossom_of_Sumizome__Border_of_Life_Piano_Version-1.png' ) );
originalSheet = imread( dataPath( 'ideal/4.png' ) );

%% Preprocessing
if size(originalSheet,3) > 1
    graySheet = double(rgb2gray(originalSheet));
else
    graySheet = double(originalSheet);
end
thresholdedSheet = graySheet - mean(graySheet(:));
workingSheet = -thresholdedSheet;
workingSheet = fixRotation( workingSheet , 0.01 );
[ M , N ] = size(workingSheet);

%% Line detection
lines = findStaffLines( workingSheet , 'simple' );
figureID = newFigure( figureID );
colormap gray;
imagesc( workingSheet );
hold on;
for i = 1 : size(lines,1)
    plot( 1 : N , lines(i,:) , 'c--' , 'linewidth' , 2 );
end
hold off;
title( 'Line Detection Result' );
legend( 'Possible staff lines' , 'location' , 'best' );
% return

%% Line removal
features = removeStaffLines( workingSheet , lines , 'simple' );
figureID = newFigure( figureID );
colormap gray;
imagesc( features );
title( 'Line Removal Result' );

%% Feature segmentation
featureList = segmentFeatures( features , 'default' );
figureID = newFigure( figureID );
colormap gray;
imagesc( features );
for i = 1 : size(featureList,1)
    drawBox( featureList{i,1} , [1,0,0] );
end
title( 'Feature Segmentation Result' );
